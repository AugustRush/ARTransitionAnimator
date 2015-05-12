//
//  ARTransitionAnimator.h
//  ARTransitionAnimatorDemo
//
//  Created by August on 15/5/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ARTransitionAnimator : NSObject<UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>

@property (nonatomic, assign) CGFloat behindViewScale;
@property (nonatomic, assign) NSTimeInterval transitionDuration;
@property (nonatomic, assign) UIEdgeInsets modalInsets;
@property (nonatomic, assign) BOOL touchBackgroudDismissEnabled;

@end
