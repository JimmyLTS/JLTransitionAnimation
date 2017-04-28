//
//  PresentViewController.m
//  TransitionAnimationDemo
//
//  Created by 吕同生 on 17/4/28.
//  Copyright © 2017年 JimmyLTS. All rights reserved.
//

#import "PresentViewController.h"
#import "CustomTransitionDelegate.h"

@interface PresentViewController ()
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;

@end

@implementation PresentViewController
{
    CustomModalTransitionDelegate *_modalTransitionDelegate;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupModalTransitionDelegate];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupModalTransitionDelegate];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupModalTransitionDelegate];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.5 animations:^{
        self.dismissButton.alpha = 1.0;
        [self.view layoutIfNeeded];
    }];
}

- (void)setupModalTransitionDelegate {
    _modalTransitionDelegate  = [[CustomModalTransitionDelegate alloc] init];
    self.transitioningDelegate = _modalTransitionDelegate;
    self.modalPresentationStyle = UIModalPresentationCustom;
}

- (IBAction)dismissAction:(id)sender {
    CGAffineTransform transform = CGAffineTransformMakeRotation(3.0 * M_PI);
    transform = CGAffineTransformScale(transform, 0.1, 0.1);
    [UIView animateWithDuration:0.5 animations:^{
        self.dismissButton.transform = transform;
        [self.view layoutIfNeeded];
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
