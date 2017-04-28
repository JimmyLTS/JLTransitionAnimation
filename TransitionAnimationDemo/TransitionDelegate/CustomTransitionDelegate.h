//
//  CustomTransitionDelegate.h
//  TransitionAnimationDemo
//
//  Created by 吕同生 on 17/4/26.
//  Copyright © 2017年 JimmyLTS. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark -
#pragma mark - CustomNavigationTransitionDelegate
@interface CustomNavigationTransitionDelegate : NSObject <UINavigationControllerDelegate>

@property (nonatomic, assign) BOOL interactive;

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;

@end

#pragma mark -
#pragma mark - CustomTabBarTransitionDelegate
@interface CustomTabBarTransitionDelegate : NSObject <UITabBarControllerDelegate>

@property (nonatomic, assign) BOOL interactive;

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;

@end

#pragma mark -
#pragma mark - CustomModalTransitionDelegate
@interface CustomModalTransitionDelegate : NSObject <UIViewControllerTransitioningDelegate>

@end
