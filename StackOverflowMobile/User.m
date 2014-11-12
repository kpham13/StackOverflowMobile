//
//  User.m
//  StackOverflowMobile
//
//  Created by Kevin Pham on 11/11/14.
//  Copyright (c) 2014 Kevin Pham. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)userDictionary {
    self = [super init];
    
    if (self) {
        self.accountID = userDictionary[@"account_id"];
        self.userID = userDictionary[@"user_id"];
        self.displayName = userDictionary[@"display_name"];
        self.location = userDictionary[@"location"];
        self.link = userDictionary[@"link"];
        self.websiteURL = userDictionary[@"website_url"];
        self.avatarURL = userDictionary[@"profile_image"];
    }
    
    return self;
}

+ (NSMutableArray *)parseJSONDataIntoUser:(NSData *)rawJSONData {
    NSError *error;
    
    // JSONDictionary points to NSDictionary of NSJSONSerialization(rawJSONData)
    NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:rawJSONData options:0 error:&error];
    if ([JSONDictionary isKindOfClass:[NSDictionary class]]) {
        // Allocate memory and initialize userArray
        NSMutableArray *userArray = [[NSMutableArray alloc] init];
        
        // JSONArray points to NSMutableArray of JSONDictionary["items"]
        NSMutableArray *JSONArray = JSONDictionary[@"items"];
        if ([JSONArray isKindOfClass:[NSMutableArray class]]) {
            for (NSDictionary *object in JSONArray) {
                User *newUser = [[User alloc] initWithDictionary:object];
                [userArray addObject:newUser];
            }
        }
        
        return userArray;
    }
    
    return nil;
}

@end