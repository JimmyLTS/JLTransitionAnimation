//
//  PopViewController.m
//  TransitionAnimationDemo
//
//  Created by 吕同生 on 17/4/28.
//  Copyright © 2017年 JimmyLTS. All rights reserved.
//

#import "PopViewController.h"
#import "CustomTransitionDelegate.h"

@interface PopViewController ()
@property (weak, nonatomic) IBOutlet UIButton *popButton;

@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *panGesture;

@property (nonatomic, strong) CustomNavigationTransitionDelegate *navTransitionDelegate;

@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.panGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    self.panGesture.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:_panGesture];
}

- (void)panGestureAction:(UIScreenEdgePanGestureRecognizer *)panGesture {
    CGFloat translationX = [panGesture translationInView:self.view].x;
    CGFloat transitionBase = kScreenWidth / 3;
    CGFloat transitionAbs = translationX > 0 ? translationX : -translationX;
    CGFloat persent = transitionAbs > transitionBase ? 1.0 : transitionAbs / transitionBase;
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.navTransitionDelegate = (CustomNavigationTransitionDelegate *)self.navigationController.delegate;
            self.navTransitionDelegate.interactive = true;
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self.navTransitionDelegate.interactionController updateInteractiveTransition:persent];
        }
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            if (persent > 0.5) {
                [self.navTransitionDelegate.interactionController finishInteractiveTransition];
            }else {
                [self.navTransitionDelegate.interactionController cancelInteractiveTransition];
            }
            self.navTransitionDelegate.interactive = false;
        }
            break;
            
        default:
            break;
    }
    
}

- (IBAction)pressPopButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [self.panGesture removeTarget:self action:@selector(panGestureAction:)];
}

@end
