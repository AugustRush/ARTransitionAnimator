//
//  ARTransitionAnimator.m
//  ARTransitionAnimatorDemo
//
//  Created by August on 15/5/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARTransitionAnimator.h"

@interface ARTransitionAnimator ()

@property (nonatomic, assign) BOOL isDismiss;
@property (nonatomic, assign) BOOL isNavigationTransition;
@property (nonatomic, weak) UIViewController *toViewController;

@end

@implementation ARTransitionAnimator

#pragma mark - init methods

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.modalInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.transitionDuration = 0.65;
        self.behindViewScale = 1;
        self.touchBackgroudDismissEnabled = NO;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning methods

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.transitionDuration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.isDismiss) {
        [self dismissWithAnimateTransition:transitionContext];
    }else{
        [self presentingWithAnimateTransition:transitionContext];
    }
}

#pragma mark - private methods

-(void)presentingWithAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    if (self.touchBackgroudDismissEnabled) {
        UITapGestureRecognizer *tapGesureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [containerView addGestureRecognizer:tapGesureRecognizer];
    }
    
    [containerView addSubview:toViewController.view];
    
    toViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    CGRect startRect = CGRectMake(0,
                                  CGRectGetHeight(containerView.frame),
                                  CGRectGetWidth(containerView.bounds),
                                  CGRectGetHeight(containerView.bounds));

    startRect.size.height -= (self.modalInsets.top + self.modalInsets.bottom);
    startRect.size.width -= (self.modalInsets.left + self.modalInsets.right);
    startRect.origin.x = self.modalInsets.left;
    
    toViewController.view.frame = startRect;
    
    CGRect finalRect = startRect;
    finalRect.origin.y = self.modalInsets.top;
    finalRect.origin.x = self.modalInsets.left;
    
    containerView.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:0.2
                        options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
                         fromViewController.view.transform = CGAffineTransformScale(fromViewController.view.transform, self.behindViewScale, self.behindViewScale);
                         toViewController.view.frame = finalRect;
                         
                     } completion:^(BOOL finished) {
                         self.toViewController = toViewController;
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
    
}

-(void)dismissWithAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromViewController.view;
    UIView *toView = toViewController.view;
    
    UIView *containerView = [transitionContext containerView];

    if (self.isNavigationTransition) {
        [containerView addSubview:toView];
        [containerView addSubview:fromView];
    }
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    CGRect fromViewFinalFrame  = [transitionContext initialFrameForViewController:fromViewController];
    fromViewFinalFrame.origin.y = CGRectGetHeight(containerView.bounds);
    
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:0.2
                        options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         containerView.backgroundColor = [UIColor clearColor];
                         toView.transform = CGAffineTransformMakeScale(1, 1);
                         toView.frame = [transitionContext finalFrameForViewController:toViewController];
                         fromView.frame = fromViewFinalFrame;
                     } completion:^(BOOL finished) {
                         self.toViewController = nil;
                         [fromView removeFromSuperview];
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
    
}

#pragma amrk - custom event methods

-(void)handleTapGesture:(UITapGestureRecognizer *)tapGesture
{
    if (!self.isNavigationTransition) {
        [self.toViewController.view endEditing:YES];
        [self.toViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UIViewControllerTransitioningDelegate methods

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.isNavigationTransition = NO;
    self.isDismiss = NO;
    return self;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.isNavigationTransition = NO;
    self.isDismiss = YES;
    return self;
}

#pragma mark - UINavigationControllerDelegate methods

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                 animationControllerForOperation:(UINavigationControllerOperation)operation
                                              fromViewController:(UIViewController *)fromVC
                                                toViewController:(UIViewController *)toVC
{
    
    NSInteger fromIndex = [navigationController.viewControllers indexOfObject:fromVC];
    NSInteger toIndex = [navigationController.viewControllers indexOfObject:toVC];
    if (fromIndex > toIndex) {
        self.isDismiss = YES;
    }else{
        self.isDismiss = NO;
    }
    self.isNavigationTransition = YES;
    return self;
}

@end
