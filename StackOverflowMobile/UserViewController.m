//
//  UserViewController.m
//  StackOverflowMobile
//
//  Created by Kevin Pham on 11/16/14.
//  Copyright (c) 2014 Kevin Pham. All rights reserved.
//

#import "UserViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface UserViewController ()

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TABLE VIEW DATA SOURCE

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.users == nil) {
        return 0;
    } else {
        return self.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"USER_CELL" forIndexPath:indexPath];
    
    User *user = self.users[indexPath.row];
    cell.textLabel.text = user.displayName;
    
    return cell;
}

#pragma mark - TABLE VIEW DELEGATE

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - SEARCH BAR

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [SVProgressHUD show];
    NSString *searchText = searchBar.text;
    NSLog(@"%@", searchText);
    
    [[StackOverflowService networkController] fetchUsers:searchText withCompletion:^(NSMutableArray *results, NSString *errorDescription) {
        if (errorDescription != nil) {
            NSLog(@"%@", errorDescription);
        } else {
            self.users = results;
            [self.tableView reloadData];
        }
    }];
    
    [SVProgressHUD dismiss];
    [self.searchBar resignFirstResponder];
}

@end