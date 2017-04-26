//
//  CustomAnimationController.m
//  TransitionAnimationDemo
//
//  Created by 吕同生 on 17/4/26.
//  Copyright © 2017年 JimmyLTS. All rights reserved.
//

#import "CustomAnimationController.h"

#define kTransitionDuration 1.0

typedef NS_ENUM (NSUInteger, JLCustomTransitionType)  {
    JLNavigationTransition,
    JLTabTransition,
    JLModalTransition
};

typedef enum : NSUInteger {
    TabOperationLeft,
    TabOperationRight
} CustomTabOperationDirection;

typedef enum : NSUInteger {
    ModalOperationPresentation,
    ModalOperationDismissal
} CustomModalOperation;

struct CustomTransitionStruct {
    JLCustomTransitionType transitionType;
    CustomTabOperationDirection *tabOperationDirection;
};

@implementation CustomAnimationController

#pragma mark -
#pragma mark - UIViewControllerAnimatedTransitioning
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return kTransitionDuration;
}

- (void)animationEnded:(BOOL)transitionCompleted {
    
}

@end
