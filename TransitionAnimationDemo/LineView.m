//
//  LineView.m
//  TransitionAnimationDemo
//
//  Created by 吕同生 on 17/5/3.
//  Copyright © 2017年 JimmyLTS. All rights reserved.
//

#import "LineView.h"

@implementation LineView
{
    CGRect _rect;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _rect = frame;
    }
    return self;
}

- (void)show {
    CGRect newRect = CGRectMake(_rect.origin.x + self.offsetX, _rect.origin.y, _rect.size.width, _rect.size.height);
    [UIView animateWithDuration:1 animations:^{
        self.frame = newRect;
        NSShiftJISStringEncoding
    }];
}

- (void)hidden {
    CGRect newRect = CGRectMake(_rect.origin.x + self.offsetX * 2, _rect.origin.y, _rect.size.width, _rect.size.height);
    [UIView animateWithDuration:1 animations:^{
        self.frame = newRect;
        self.alpha = 0;
    }];
}

@end
