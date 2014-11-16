//
//  StackOverflowService.h
//  StackOverflowMobile
//
//  Created by Kevin Pham on 11/11/14.
//  Copyright (c) 2014 Kevin Pham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StackOverflowService : NSObject

@property (strong, nonatomic) NSOperationQueue *operationQueue;
@property (strong, nonatomic) NSURLSession *urlSession;
@property (strong, nonatomic) NSString *key;

+ (StackOverflowService *)networkController;
+ (void)setToken:(NSString *)token;

- (void)fetchTaggedQuestions:(NSString *)searchTag withCompletion:(void(^)(NSMutableArray *results, NSString *errorDescription))completionHandler;

@end