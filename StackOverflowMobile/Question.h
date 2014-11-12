//
//  Question.h
//  StackOverflowMobile
//
//  Created by Kevin Pham on 11/11/14.
//  Copyright (c) 2014 Kevin Pham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

// /questions
// /2.2/questions?order=desc&sort=activity&site=stackoverflow
@property (nonatomic, strong) NSNumber *questionID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSMutableArray *tags;
//@property (nonatomic, strong) NSString *body;

- (instancetype)initWithDictionary:(NSDictionary *)questionDictionary;
+ (NSMutableArray *)parseJSONDataIntoQuestion:(NSData *)rawJSONData;

@end