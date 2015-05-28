//
//  ARBasicAnimation.h
//  ARTransitionAnimatorDemo
//
//  Created by August on 15/5/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_INLINE CGFloat CGPointDistance(CGPoint fromPoint,CGPoint toPoint){
    CGFloat distance;
    CGFloat xDist = (toPoint.x - fromPoint.x);
    CGFloat yDist = (toPoint.y - fromPoint.y);
    distance = sqrt((xDist * xDist) + (yDist * yDist));
    return distance;
}

@interface ARBasicAnimation : CABasicAnimation

@property (nonatomic, copy) void(^completion)(BOOL finished);
@property (nonatomic, copy) void(^start)(void);

@end
