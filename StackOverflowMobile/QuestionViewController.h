//
//  QuestionViewController.h
//  StackOverflowMobile
//
//  Created by Kevin Pham on 11/12/14.
//  Copyright (c) 2014 Kevin Pham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "QuestionCell.h"
#import "StackOverflowService.h"

@interface QuestionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) NSMutableArray *questions;
@property (strong, nonatomic) StackOverflowService *networkController;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;

@end