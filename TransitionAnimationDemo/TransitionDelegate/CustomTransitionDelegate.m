//
//  CustomTransitionDelegate.m
//  TransitionAnimationDemo
//
//  Created by 吕同生 on 17/4/26.
//  Copyright © 2017年 JimmyLTS. All rights reserved.
//

#import "CustomTransitionDelegate.h"
#import "CustomAnimationController.h"
#import "CustomPresentationController.h"

#pragma mark -
#pragma mark - CustomNavigationTransitionDelegate
@implementation CustomNavigationTransitionDelegate

- (instancetype)init {
    self = [super init];
    if (self) {
        _interactive = NO;
        _interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
    }
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    CustomAnimationController *animationController = [[CustomAnimationController alloc] initWithTransitionType:JLNavigationTransition transitionOperation:NavigationTransitionNone];
    return animationController;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return _interactive ? self.interactionController : nil;
}

@end

#pragma mark -
#pragma mark - CustomTabBarTransitionDelegate
@implementation CustomTabBarTransitionDelegate

- (instancetype)init {
    self = [super init];
    if (self) {
        _interactive = NO;
        _interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
    }
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    NSUInteger fromIndex = [tabBarController.viewControllers indexOfObject:fromVC];
    NSUInteger toIndex = [tabBarController.viewControllers indexOfObject:toVC];
    
    CustomTransitionOperation tabChangeDirection = toIndex < fromIndex ? TabOperationLeft : TabOperationRight;
    JLCustomTransitionType transitionType = JLTabTransition;
    CustomAnimationController *animationController = [[CustomAnimationController alloc] initWithTransitionType:transitionType transitionOperation:tabChangeDirection];
    return animationController;
}

- (id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return _interactive ? _interactionController : nil;
}

@end

#pragma mark -
#pragma mark - CustomModalTransitionDelegate
@implementation CustomModalTransitionDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[CustomAnimationController alloc] initWithTransitionType:JLModalTransition transitionOperation:ModalOperationNone];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[CustomAnimationController alloc] initWithTransitionType:JLModalTransition transitionOperation:ModalOperationNone];
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[CustomPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

@end
