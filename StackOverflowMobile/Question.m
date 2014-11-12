//
//  Question.m
//  StackOverflowMobile
//
//  Created by Kevin Pham on 11/11/14.
//  Copyright (c) 2014 Kevin Pham. All rights reserved.
//

#import "Question.h"

@implementation Question

- (instancetype)initWithDictionary:(NSDictionary *)questionDictionary {
    self = [super init];
    
    if (self) {
        self.questionID = questionDictionary[@"question_id"];
        self.title = questionDictionary[@"title"];
        self.link = questionDictionary[@"link"];
        self.tags = [[NSMutableArray alloc] init];
        //self.body = questionDictionary[@"body"];
    }
    
    return self;
}

+ (NSMutableArray *)parseJSONDataIntoQuestion:(NSData *)rawJSONData {
    NSError *error;
    
    // JSONDictionary points to NSDictionary of NSJSONSerialization(rawJSONData)
    NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:rawJSONData options:0 error:&error];
    if ([JSONDictionary isKindOfClass:[NSDictionary class]]) {
        // Allocate memory and initialize questionArray
        NSMutableArray *questionArray = [[NSMutableArray alloc] init];
        
        // JSONArray points to NSMutableArray of JSONDictionary["items"]
        NSMutableArray *JSONArray = JSONDictionary[@"items"];
        if ([JSONArray isKindOfClass:[NSMutableArray class]]) {
            for (NSDictionary *object in JSONArray) {
                Question *newQuestion = [[Question alloc] initWithDictionary:object];
                [questionArray addObject:newQuestion];
            }
        }
        
        return questionArray;
    }
    
    return nil;
}

@end