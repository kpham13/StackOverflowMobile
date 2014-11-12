//
//  User.h
//  StackOverflowMobile
//
//  Created by Kevin Pham on 11/11/14.
//  Copyright (c) 2014 Kevin Pham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

// /users
// /2.2/users?order=desc&sort=reputation&site=stackoverflow
@property (nonatomic, strong) NSNumber *accountID;
@property (nonatomic, strong) NSNumber *userID;
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *websiteURL;
@property (nonatomic, strong) NSString *avatarURL;

- (instancetype)initWithDictionary:(NSDictionary *)userDictionary;
+ (NSMutableArray *)parseJSONDataIntoUser:(NSData *)rawJSONData;

@end