//
//  ARBasicAnimation.m
//  ARTransitionAnimatorDemo
//
//  Created by August on 15/5/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARBasicAnimation.h"

@implementation ARBasicAnimation

+(instancetype)animationWithKeyPath:(NSString *)path
{
    ARBasicAnimation *animation = [super animationWithKeyPath:path];
    animation.delegate = animation;
    return animation;
}

#pragma mark - animation delegate methods

-(void)animationDidStart:(CAAnimation *)anim
{

}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.completion) {
        self.completion(flag);
    }
}

@end
