//
//  CustomAnimationController.m
//  TransitionAnimationDemo
//
//  Created by 吕同生 on 17/4/26.
//  Copyright © 2017年 JimmyLTS. All rights reserved.
//

#import "CustomAnimationController.h"

#define kTransitionDuration 1.0

@implementation CustomAnimationController
{
    JLCustomTransitionType _transitionType;
    CustomTransitionOperation _transitionOperation;
}

- (instancetype)initWithTransitionType:(JLCustomTransitionType)transitionType transitionOperation:(CustomTransitionOperation)transitionOperation {
    self = [super init];
    if (self) {
        _transitionType = transitionType;
        _transitionOperation = transitionOperation;
    }
    return self;
}

#pragma mark -
#pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromController.view;
    UIView *toView = toController.view;
    
    CGFloat transition = containerView.frame.size.width;
    CGAffineTransform toViewTransform = CGAffineTransformIdentity;
    CGAffineTransform fromViewTransform = CGAffineTransformIdentity;
    
    CGFloat duration = [self transitionDuration:transitionContext];
    
    switch (_transitionType) {
        case JLTabTransition:
        {
            transition = (_transitionOperation == TabOperationLeft) ? transition : -transition;
            fromViewTransform = CGAffineTransformMakeTranslation(transition, 0);
            toViewTransform = CGAffineTransformMakeTranslation(-transition, 0);
            
            [containerView addSubview:toView];
            toView.transform = toViewTransform;
            
            //1、第一种实现方式
            [UIView animateWithDuration:duration animations:^{
                fromView.transform = fromViewTransform;
                toView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                fromView.transform = CGAffineTransformIdentity;
                toView.transform = CGAffineTransformIdentity;
                
                BOOL isCancelled = [transitionContext transitionWasCancelled];
                [transitionContext completeTransition:!isCancelled];
            }];
        }
            break;
        case JLModalTransition:
        {
            if (toController.isBeingPresented) {
                [containerView addSubview:toView];
                CGFloat toViewWidth = containerView.frame.size.width * 2 / 3, toViewHeight = containerView.frame.size.height * 2 / 3;
                toView.center = containerView.center;
                toView.bounds = CGRectMake(0, 0, 0, 0);
                
                [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    toView.bounds = CGRectMake(0, 0, toViewWidth, toViewHeight);
                } completion:^(BOOL finished) {
                    [transitionContext completeTransition:(![transitionContext transitionWasCancelled])];
                }];
            }
            
            //Dismissal 转场中不要将 toView 添加到 containerView
            if (fromController.isBeingDismissed) {
//                CGFloat fromViewHeight = fromView.frame.size.height;
                [UIView animateWithDuration:duration animations:^{
                    fromView.bounds = CGRectMake(0, 0, 10, 10);
                    fromView.transform = CGAffineTransformMakeRotation(3 * M_PI);
                    [fromView layoutIfNeeded];
                } completion:^(BOOL finished) {
                    [transitionContext completeTransition:(![transitionContext transitionWasCancelled])];
                }];
            }
        }
            break;
        case JLNavigationTransition:
        {
            transition = (_transitionOperation == NavigationTransitionPush) ? transition : -transition;
            fromViewTransform = CGAffineTransformMakeTranslation(transition, 0);
            toViewTransform = CGAffineTransformMakeTranslation(-transition, 0);
            [containerView addSubview:toView];
            toView.transform = toViewTransform;
            [UIView animateWithDuration:duration animations:^{
                fromView.transform = fromViewTransform;
                toView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                fromView.transform = CGAffineTransformIdentity;
                toView.transform = CGAffineTransformIdentity;
                [transitionContext completeTransition:(![transitionContext transitionWasCancelled])];
            }];
        }
            break;
            
        default:
            break;
    }

}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return kTransitionDuration;
}

- (void)animationEnded:(BOOL)transitionCompleted {
    
}

@end
