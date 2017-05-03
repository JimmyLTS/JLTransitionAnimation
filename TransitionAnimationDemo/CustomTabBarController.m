//
//  CustomTabBarController.m
//  TransitionAnimationDemo
//
//  Created by 吕同生 on 17/4/27.
//  Copyright © 2017年 JimmyLTS. All rights reserved.
//

#import "CustomTabBarController.h"
#import "CustomTransitionDelegate.h"

@interface CustomTabBarController ()

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@property (nonatomic, strong) CustomTabBarTransitionDelegate *transitionDelegate;

@property (nonatomic, assign) NSInteger subControllerCount;

@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addGestureRecognizer:self.panGesture];
    self.delegate = self.transitionDelegate;
    self.viewControllers = @[self.viewControllers[0], self.viewControllers[1], self.viewControllers[2],];
}

#pragma mark-
#pragma mark- Event Response
- (void)panGestureAction:(UIPanGestureRecognizer *)panGesture {
    CGFloat translationX = [panGesture translationInView:self.view].x;
    CGFloat translationAbs = (translationX > 0) ? translationX : -translationX;
    CGFloat progress = translationAbs / kScreenWidth;
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.transitionDelegate.interactive = true;
            CGFloat velocityX = [panGesture velocityInView:self.view].x;
            if (velocityX < 0) {
                if (self.selectedIndex < (self.subControllerCount - 1)) {
                    self.selectedIndex += 1;
                }
            }else {
                if (self.selectedIndex > 0) {
                    self.selectedIndex -= 1;
                }
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
            [self.transitionDelegate.interactionController updateInteractiveTransition:progress];
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            if (progress > 0.3) {
                self.transitionDelegate.interactionController.completionSpeed = 0.99;
                [self.transitionDelegate.interactionController finishInteractiveTransition];
            }else {
                self.transitionDelegate.interactionController.completionSpeed = 0.99;
                [self.transitionDelegate.interactionController cancelInteractiveTransition];
            }
            self.transitionDelegate.interactive = false;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark-
#pragma mark- Getters && Setters
- (NSInteger)subControllerCount {
    return (self.viewControllers != nil) ? self.viewControllers.count : 0;
}

- (CustomTabBarTransitionDelegate *)transitionDelegate {
    if (!_transitionDelegate) {
        _transitionDelegate = [[CustomTabBarTransitionDelegate alloc] init];
    }
    return _transitionDelegate;
}

- (UIPanGestureRecognizer *)panGesture {
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    }
    return _panGesture;
}

@end
