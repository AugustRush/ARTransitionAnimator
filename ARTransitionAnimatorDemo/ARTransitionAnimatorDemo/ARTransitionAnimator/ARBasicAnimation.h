//
//  ARBasicAnimation.h
//  ARTransitionAnimatorDemo
//
//  Created by August on 15/5/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface ARBasicAnimation : CABasicAnimation

@property (nonatomic, copy) void(^completion)(BOOL finished);

@end
