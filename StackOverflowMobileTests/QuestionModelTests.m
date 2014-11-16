//
//  QuestionModelTests.m
//  StackOverflowMobile
//
//  Created by Kevin Pham on 11/16/14.
//  Copyright (c) 2014 Kevin Pham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Question.h"

@interface QuestionModelTests : XCTestCase

@property (strong, nonatomic) Question *question;

@end

@implementation QuestionModelTests

- (void)setUp {
    [super setUp];
    
    self.question = [[Question alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testQuestionInit {
    XCTAssertNotNil(self.question, @"Question class should not be nil");
}

- (void)testParsing {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Sample" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSMutableArray *array = [Question parseJSONDataIntoQuestion:data];
    
    Question *question = array[0];
    XCTAssertTrue(question);
}

@end