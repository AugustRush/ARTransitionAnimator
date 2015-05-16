//
//  ARTransitionAnimator.m
//  ARTransitionAnimatorDemo
//
//  Created by August on 15/5/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARTransitionAnimator.h"
#import "ARBasicAnimation.h"

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
        self.transitionDuration = 0.5;
        self.transitionStyle = ARTransitionStyleLeftToRight;
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
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *toView = toViewController.view;
    
    UIView *containerView = [transitionContext containerView];
        
    [containerView addSubview:toViewController.view];
    
    NSUInteger style = self.transitionStyle;
    if (style == 1 ||
        style == 3 ||
        style == 5 ||
        style == 9 ||
        style == 17) {
        CGRect ToViewFinalRect = [transitionContext finalFrameForViewController:toViewController];
        toView.frame = ToViewFinalRect;
    
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = toView.bounds;
        maskLayer.fillColor = [UIColor blackColor].CGColor;
        [toView.layer setMask:maskLayer];
        
        
        ARBasicAnimation *animation = [ARBasicAnimation animationWithKeyPath:@"path"];
        animation.additive = YES;
        animation.removedOnCompletion = YES;
        animation.duration = self.transitionDuration;
        
        switch (style) {
            case 1:{
                CGPoint center = CGPointMake(CGRectGetMidX(ToViewFinalRect), CGRectGetMidY(ToViewFinalRect));
                animation.fromValue = (__bridge id)([UIBezierPath bezierPathWithArcCenter:center radius:1 startAngle:0 endAngle:2*M_PI clockwise:YES].CGPath);
                CGFloat radius = MAX(CGRectGetWidth(ToViewFinalRect), CGRectGetHeight(ToViewFinalRect));
                animation.toValue = (__bridge id)[UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES].CGPath;
                break;
            }
            case 3:{
                animation.fromValue = (__bridge id)([UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 1, CGRectGetHeight(ToViewFinalRect))].CGPath);
                animation.toValue = (__bridge id)([UIBezierPath bezierPathWithRect:ToViewFinalRect].CGPath);
                
                break;
            }
            case 5:{
                animation.fromValue = (__bridge id)([UIBezierPath bezierPathWithRect:CGRectMake(0, CGRectGetHeight(ToViewFinalRect), CGRectGetWidth(ToViewFinalRect), 1)].CGPath);
                animation.toValue = (__bridge id)([UIBezierPath bezierPathWithRect:ToViewFinalRect].CGPath);
                
                break;
            }
            case 17:{
                animation.fromValue = (__bridge id)([UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(ToViewFinalRect), 1)].CGPath);
                animation.toValue = (__bridge id)([UIBezierPath bezierPathWithRect:ToViewFinalRect].CGPath);
                
                break;
            }

            case 9:{
                animation.fromValue = (__bridge id)([UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMaxX(ToViewFinalRect), 0, 1, CGRectGetHeight(ToViewFinalRect))].CGPath);
                animation.toValue = (__bridge id)([UIBezierPath bezierPathWithRect:ToViewFinalRect].CGPath);
                
                break;
            }
    
            default:
                break;
        }
        
        [maskLayer setValue:animation.toValue forKey:animation.keyPath];
        [maskLayer addAnimation:animation forKey:@"path"];

        [animation setCompletion:^(BOOL finished) {
            toView.layer.mask = nil;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    
    if (style == 2 ||
        style == 4 ||
        style == 8 ||
        style == 16) {
        CGRect ToViewFinalRect = [transitionContext finalFrameForViewController:toViewController];
        CGRect startRect = ToViewFinalRect;
        switch (style) {
            case 2:
                startRect.origin.x = -CGRectGetWidth(startRect);
                break;
            case 4:
                startRect.origin.y = CGRectGetHeight(startRect);
                break;
            case 8:
                startRect.origin.x = CGRectGetWidth(startRect);
                break;
            case 16:
                startRect.origin.x = CGRectGetWidth(startRect);
                break;

            default:
                break;
        }
        toView.frame = startRect;
        [UIView animateWithDuration:self.transitionDuration
                         animations:^{
                             toView.frame = ToViewFinalRect;
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
    }
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
    
    NSUInteger style = self.transitionStyle;
    if (style == 1 ||
        style == 3 ||
        style == 5 ||
        style == 9 ||
        style == 17) {
        CGRect fromFinalRect = fromView.bounds;
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.fillColor = [UIColor whiteColor].CGColor;
        [fromView.layer setMask:maskLayer];
        
        
        ARBasicAnimation *animation = [ARBasicAnimation animationWithKeyPath:@"path"];
        animation.removedOnCompletion = YES;
        animation.duration = self.transitionDuration;
        
        switch (style) {
            case 1:{
                CGPoint center = CGPointMake(CGRectGetMidX(fromFinalRect), CGRectGetMidY(fromFinalRect));
                animation.toValue = (__bridge id)([UIBezierPath bezierPathWithArcCenter:center radius:1 startAngle:0 endAngle:2*M_PI clockwise:YES].CGPath);
                CGFloat radius = MAX(CGRectGetWidth(fromFinalRect), CGRectGetHeight(fromFinalRect));
                animation.fromValue = (__bridge id)[UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES].CGPath;
                break;
            }
            case 3:{
                animation.toValue = (__bridge id)([UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 1, CGRectGetHeight(fromFinalRect))].CGPath);
                animation.fromValue = (__bridge id)([UIBezierPath bezierPathWithRect:fromFinalRect].CGPath);
                
                break;
            }
            case 5:{
                animation.toValue = (__bridge id)([UIBezierPath bezierPathWithRect:CGRectMake(0, CGRectGetHeight(fromFinalRect), CGRectGetWidth(fromFinalRect), 1)].CGPath);
                animation.fromValue = (__bridge id)([UIBezierPath bezierPathWithRect:fromFinalRect].CGPath);
                
                break;
            }
            case 17:{
                animation.toValue = (__bridge id)([UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(fromFinalRect), 1)].CGPath);
                animation.fromValue = (__bridge id)([UIBezierPath bezierPathWithRect:fromFinalRect].CGPath);
                
                break;
            }
                
            case 9:{
                animation.toValue = (__bridge id)([UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMaxX(fromFinalRect), 0, 1, CGRectGetHeight(fromFinalRect))].CGPath);
                animation.fromValue = (__bridge id)([UIBezierPath bezierPathWithRect:fromFinalRect].CGPath);
                
                break;
            }
                
            default:
                break;
        }
        
        [maskLayer addAnimation:animation forKey:@"path"];
        
        [animation setCompletion:^(BOOL finished) {
            fromView.layer.mask = nil;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    
    if (style == 2 ||
        style == 4 ||
        style == 8 ||
        style == 16) {
        CGRect fromRect = [transitionContext finalFrameForViewController:toViewController];
        CGRect startRect = fromRect;
        switch (style) {
            case 2:
                startRect.origin.x = -CGRectGetWidth(startRect);
                break;
            case 4:
                startRect.origin.y = CGRectGetHeight(startRect);
                break;
            case 8:
                startRect.origin.x = CGRectGetWidth(startRect);
                break;
            case 16:
                startRect.origin.x = CGRectGetWidth(startRect);
                break;

            default:
                break;
        }

        [UIView animateWithDuration:self.transitionDuration
                         animations:^{
                             fromView.frame = startRect;
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
    }
    
}

#pragma mark - backgroud event methods

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
