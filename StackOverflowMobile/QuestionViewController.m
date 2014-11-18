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
    
    // Register Nib
    [[self tableView] registerNib:[UINib nibWithNibName:@"QuestionCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"QUESTION_CELL"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;

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
    QuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QUESTION_CELL" forIndexPath:indexPath];
    
    Question *question = self.questions[indexPath.row];
    cell.titleLabel.text = question.title;
    
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
    
    [[StackOverflowService networkController] fetchQuestions:searchText withCompletion:^(NSMutableArray *results, NSString *errorDescription) {
        if (errorDescription != nil) {
            NSLog(@"%@", errorDescription);
        } else {
            self.questions = results;
            [self.tableView reloadData];
        }
    }];

    [SVProgressHUD dismiss];
    [self.searchBar resignFirstResponder];
}

@end