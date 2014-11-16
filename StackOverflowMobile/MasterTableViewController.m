//
//  MasterTableViewController.m
//  StackOverflowMobile
//
//  Created by Kevin Pham on 11/12/14.
//  Copyright (c) 2014 Kevin Pham. All rights reserved.
//

#import "MasterTableViewController.h"

@interface MasterTableViewController ()

@end

@implementation MasterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Localization
    self.title = NSLocalizedString(@"Stack", nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TABLE VIEW DELEGATE

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.height * 0.3;
}

@end