//
//  ARBasicAnimation.m
//  ARTransitionAnimatorDemo
//
//  Created by August on 15/5/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARBasicAnimation.h"

@interface ARBasicAnimation ()

@end

@implementation ARBasicAnimation

+(instancetype)animationWithKeyPath:(NSString *)path
{
    ARBasicAnimation *animation = [super animationWithKeyPath:path];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.delegate = animation;
    return animation;
}

#pragma mark - animation delegate methods

-(void)animationDidStart:(CAAnimation *)anim
{
    if (self.start) {
        self.start();
    }
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.completion) {
        self.completion(flag);
    }
}

@end
