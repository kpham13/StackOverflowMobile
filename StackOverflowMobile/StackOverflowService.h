//
//  StackOverflowService.h
//  StackOverflowMobile
//
//  Created by Kevin Pham on 11/11/14.
//  Copyright (c) 2014 Kevin Pham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StackOverflowService : NSObject

+ (StackOverflowService *)networkController;

- (void)fetchTaggedQuestions:(NSString *)searchTag withCompletion:(void(^)(NSArray *results, NSString *errorDescription))completionHandler;

@end