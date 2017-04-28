//
//  CustomPresentationController.m
//  TransitionAnimationDemo
//
//  Created by 吕同生 on 17/4/27.
//  Copyright © 2017年 JimmyLTS. All rights reserved.
//

#import "CustomPresentationController.h"

@interface CustomPresentationController ()

@property (nonatomic, strong) UIView *dimmingView;

@end

@implementation CustomPresentationController

- (void)presentationTransitionWillBegin {
    CGFloat dimmingViewInitailWidth = 20, dimmingViewInitailHeight = 40;
    [self.containerView addSubview:self.dimmingView];
    self.dimmingView.bounds = CGRectMake(0, 0, dimmingViewInitailWidth, dimmingViewInitailHeight);
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.bounds = self.containerView.bounds;
    } completion:nil];
}

- (void)dismissalTransitionWillBegin {
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0;
    } completion:nil];
    
}

- (void)containerViewWillLayoutSubviews {
    self.dimmingView.center = self.containerView.center;
    self.dimmingView.bounds = self.containerView.bounds;
    
    CGFloat width = self.containerView.frame.size.width * 2 / 3, height = self.containerView.frame.size.height * 2 / 3;
    self.presentedView.center = self.containerView.center;
    self.presentedView.bounds = CGRectMake(0, 0, width, height);
}

- (UIView *)dimmingView {
    if (!_dimmingView) {
        _dimmingView = [[UIView alloc] init];
        _dimmingView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _dimmingView.center = self.containerView.center;
    }
    return _dimmingView;
}

@end
