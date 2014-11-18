//
//  MasterTableViewController.h
//  StackOverflowMobile
//
//  Created by Kevin Pham on 11/12/14.
//  Copyright (c) 2014 Kevin Pham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterTableViewController : UITableViewController <UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)setupVC;

@end