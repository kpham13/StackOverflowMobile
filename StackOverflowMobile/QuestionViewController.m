//
//  QuestionViewController.m
//  StackOverflowMobile
//
//  Created by Kevin Pham on 11/12/14.
//  Copyright (c) 2014 Kevin Pham. All rights reserved.
//

#import "QuestionViewController.h"
#import "Question.h"
#import "StackOverflowService.h"

@interface QuestionViewController () <UITableViewDataSource>

@property (strong, nonatomic) NSArray *questions;
@property (strong, nonatomic) StackOverflowService *networkController;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end


@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    
    [[StackOverflowService networkController] fetchTaggedQuestions:self.searchBar.text withCompletion:^(NSArray *results, NSString *errorDescription) {
        self.questions = results;
        [self.tableView reloadData];
    }];
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

@end