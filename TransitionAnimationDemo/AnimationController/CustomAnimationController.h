//
//  CustomAnimationController.h
//  TransitionAnimationDemo
//
//  Created by 吕同生 on 17/4/26.
//  Copyright © 2017年 JimmyLTS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, JLCustomTransitionType)  {
    JLNavigationTransition,
    JLTabTransition,
    JLModalTransition
};

typedef enum : NSUInteger {
    //TabTransition
    TabOperationLeft,
    TabOperationRight,
    
    //ModalTransition
    ModalOperationNone,
    ModalOperationPresentation,
    ModalOperationDismissal,
    
    //NavigationTransition
    NavigationTransitionNone,
    NavigationTransitionPop,
    NavigationTransitionPush
} CustomTransitionOperation;


@interface CustomAnimationController : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTransitionType:(JLCustomTransitionType)transitionType transitionOperation:(CustomTransitionOperation)transitionOperation;

@end
