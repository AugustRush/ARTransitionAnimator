//
//  ARTransitionAnimator.h
//  ARTransitionAnimatorDemo
//
//  Created by August on 15/5/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, ARTransitionStyle) {
    ARTransitionStyleMaterial = 1 << 0,
    ARTransitionStyleLeftToRight = 1 << 1,
    ARTransitionStyleBottomToTop = 1 << 2,
    ARTransitionStyleRightToLeft = 1 << 3,
    ARTransitionStyleTopToBottom = 1 << 4,
};

@interface ARTransitionAnimator : NSObject<UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>

@property (nonatomic, assign) NSTimeInterval transitionDuration;
@property (nonatomic, assign) ARTransitionStyle transitionStyle;

@end
