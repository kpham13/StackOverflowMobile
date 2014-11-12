//
//  SplitContainerViewController.m
//  StackOverflowMobile
//
//  Created by Kevin Pham on 11/11/14.
//  Copyright (c) 2014 Kevin Pham. All rights reserved.
//

#import "SplitContainerViewController.h"

@interface SplitContainerViewController ()

@end

@implementation SplitContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISplitViewController *splitVC = self.childViewControllers[0];
    splitVC.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    return true;
}

@end