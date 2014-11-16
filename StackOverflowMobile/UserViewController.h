//
//  UserViewController.h
//  StackOverflowMobile
//
//  Created by Kevin Pham on 11/16/14.
//  Copyright (c) 2014 Kevin Pham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "StackOverflowService.h"

@interface UserViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) NSMutableArray *users;
@property (strong, nonatomic) StackOverflowService *networkController;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;

@end