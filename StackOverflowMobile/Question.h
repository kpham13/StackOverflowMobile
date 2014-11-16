//
//  Question.h
//  StackOverflowMobile
//
//  Created by Kevin Pham on 11/11/14.
//  Copyright (c) 2014 Kevin Pham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property (strong, nonatomic) NSNumber *questionID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSMutableArray *tags;
//@property (nonatomic, strong) NSString *body;

+ (NSMutableArray *)parseJSONDataIntoQuestion:(NSData *)rawJSONData;

- (instancetype)initWithDictionary:(NSDictionary *)questionDictionary;

@end

// /search/advanced -> list of questions
// /2.2/search/advanced?order=desc&sort=activity&q=swift&site=stackoverflow

// /questions -> list of questions
// /2.2/questions?order=desc&sort=activity&tagged=swift&site=stackoverflow