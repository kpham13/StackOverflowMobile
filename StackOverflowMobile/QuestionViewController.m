//
//  QuestionViewController.m
//  StackOverflowMobile
//
//  Created by Kevin Pham on 11/12/14.
//  Copyright (c) 2014 Kevin Pham. All rights reserved.
//

#import "QuestionViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface QuestionViewController ()

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Localization
    self.title = NSLocalizedString(@"Questions", nil);
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TABLE VIEW DATA SOURCE

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.questions == nil) {
        return 0;
    } else {
        return self.questions.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QUESTION_CELL" forIndexPath:indexPath];
    
    Question *question = self.questions[indexPath.row];
    cell.textLabel.text = question.title;
        
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
    
    [[StackOverflowService networkController] fetchTaggedQuestions:searchText withCompletion:^(NSMutableArray *results, NSString *errorDescription) {
        if (errorDescription != nil) {
            NSLog(@"%@", errorDescription);
        } else {
            NSLog(@"hello");
            self.questions = results;
            [self.tableView reloadData];
        }
    }];
 
//    [self.networkController fetchTaggedQuestions:searchText withCompletion:^(NSMutableArray *results, NSString *errorDescription) {
//        if (errorDescription != nil) {
//            NSLog(@"%@", errorDescription);
//        } else {
//            NSLog(@"hello");
//            self.questions = results;
//            [self.tableView reloadData];
//        }
//    }];

    [SVProgressHUD dismiss];
    [self.searchBar resignFirstResponder];
}

@end