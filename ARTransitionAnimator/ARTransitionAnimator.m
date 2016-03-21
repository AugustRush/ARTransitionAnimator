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
        if (CGRectIsEmpty(ToViewFinalRect)) {
            ToViewFinalRect = [[UIScreen mainScreen] bounds];
        }
        toView.frame = ToViewFinalRect;
    
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = toView.bounds;
        maskLayer.fillColor = [UIColor blackColor].CGColor;
        [toView.layer setMask:maskLayer];
        
        
        ARBasicAnimation *animation = [ARBasicAnimation animationWithKeyPath:@"path"];
        animation.removedOnCompletion = YES;
        animation.duration = self.transitionDuration;
        
        CGPoint center = CGPointZero;
        CGFloat radius = 0;
        switch (style) {
            case 1:{
                center = CGPointMake(CGRectGetMidX(ToViewFinalRect), CGRectGetMidY(ToViewFinalRect));
                radius = sqrt((CGRectGetWidth(ToViewFinalRect) *CGRectGetWidth(ToViewFinalRect)/4 + CGRectGetHeight(ToViewFinalRect)*CGRectGetHeight(ToViewFinalRect))/4);
                break;
            }
            case 3:{
                center = CGPointMake(0, CGRectGetMidY(ToViewFinalRect));
                radius = sqrt((CGRectGetWidth(ToViewFinalRect) *CGRectGetWidth(ToViewFinalRect) + CGRectGetHeight(ToViewFinalRect)*CGRectGetHeight(ToViewFinalRect))/4);
                break;
            }
            case 5:{
                center = CGPointMake(CGRectGetMidX(ToViewFinalRect), CGRectGetHeight(ToViewFinalRect));
                radius = sqrt((CGRectGetWidth(ToViewFinalRect) *CGRectGetWidth(ToViewFinalRect)/4 + CGRectGetHeight(ToViewFinalRect)*CGRectGetHeight(ToViewFinalRect)));
                break;
            }
            case 17:{
                center = CGPointMake(CGRectGetMidX(ToViewFinalRect), 0);
                radius = sqrt((CGRectGetWidth(ToViewFinalRect) *CGRectGetWidth(ToViewFinalRect)/4 + CGRectGetHeight(ToViewFinalRect)*CGRectGetHeight(ToViewFinalRect)));
                break;
            }

            case 9:{
                center = CGPointMake(CGRectGetMaxX(ToViewFinalRect), CGRectGetMidY(ToViewFinalRect));
                radius = sqrt((CGRectGetWidth(ToViewFinalRect) *CGRectGetWidth(ToViewFinalRect) + CGRectGetHeight(ToViewFinalRect)*CGRectGetHeight(ToViewFinalRect))/4);
                break;
            }
    
            default:
                break;
        }
        
        animation.fromValue = (__bridge id)([UIBezierPath bezierPathWithArcCenter:center radius:1 startAngle:0 endAngle:2*M_PI clockwise:YES].CGPath);
        animation.toValue = (__bridge id)[UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES].CGPath;
        [maskLayer setValue:animation.toValue forKey:animation.keyPath];
        [maskLayer addAnimation:animation forKey:nil];

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
        if (CGRectIsEmpty(ToViewFinalRect)) {
            ToViewFinalRect = [[UIScreen mainScreen] bounds];
        }
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
                startRect.origin.y = -CGRectGetHeight(startRect);
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
        CGRect fromViewRect = [transitionContext initialFrameForViewController:fromViewController];
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = toView.bounds;
        maskLayer.fillColor = [UIColor blackColor].CGColor;
        [fromView.layer setMask:maskLayer];
        
        
        ARBasicAnimation *animation = [ARBasicAnimation animationWithKeyPath:@"path"];
        animation.removedOnCompletion = YES;
        animation.duration = self.transitionDuration;
        
        CGPoint center = CGPointZero;
        CGFloat radius = 0;
        switch (style) {
            case 1:{
                center = CGPointMake(CGRectGetMidX(fromViewRect), CGRectGetMidY(fromViewRect));
                radius = sqrt((CGRectGetWidth(fromViewRect) *CGRectGetWidth(fromViewRect)/4 + CGRectGetHeight(fromViewRect)*CGRectGetHeight(fromViewRect))/4);
                break;
            }
            case 3:{
                center = CGPointMake(0, CGRectGetMidY(fromViewRect));
                radius = sqrt((CGRectGetWidth(fromViewRect) *CGRectGetWidth(fromViewRect) + CGRectGetHeight(fromViewRect)*CGRectGetHeight(fromViewRect))/4);
                break;
            }
            case 5:{
                center = CGPointMake(CGRectGetMidX(fromViewRect), CGRectGetHeight(fromViewRect));
                radius = sqrt((CGRectGetWidth(fromViewRect) *CGRectGetWidth(fromViewRect)/4 + CGRectGetHeight(fromViewRect)*CGRectGetHeight(fromViewRect)));
                break;
            }
            case 17:{
                center = CGPointMake(CGRectGetMidX(fromViewRect), 0);
                radius = sqrt((CGRectGetWidth(fromViewRect) *CGRectGetWidth(fromViewRect)/4 + CGRectGetHeight(fromViewRect)*CGRectGetHeight(fromViewRect)));
                break;
            }
                
            case 9:{
                center = CGPointMake(CGRectGetMaxX(fromViewRect), CGRectGetMidY(fromViewRect));
                radius = sqrt((CGRectGetWidth(fromViewRect) *CGRectGetWidth(fromViewRect) + CGRectGetHeight(fromViewRect)*CGRectGetHeight(fromViewRect))/4);
                break;
            }
                
            default:
                break;
        }
        
        animation.toValue = (__bridge id)([UIBezierPath bezierPathWithArcCenter:center radius:1 startAngle:0 endAngle:2*M_PI clockwise:YES].CGPath);
        animation.fromValue = (__bridge id)[UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES].CGPath;
        [maskLayer setValue:animation.toValue forKey:animation.keyPath];
        [maskLayer addAnimation:animation forKey:nil];
        
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
                startRect.origin.y = -CGRectGetHeight(startRect);
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

//remove methods. will impliment ASAP

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
