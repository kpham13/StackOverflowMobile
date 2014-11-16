//
//  StackOverflowService.m
//  StackOverflowMobile
//
//  Created by Kevin Pham on 11/11/14.
//  Copyright (c) 2014 Kevin Pham. All rights reserved.
//

#import "StackOverflowService.h"
#import "Question.h"
#import "User.h"
#import "Constants.h"

@interface StackOverflowService()

@property (strong, nonatomic) NSString *token;

@end

@implementation StackOverflowService

- (instancetype)init {
    if (self.urlSession == nil) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.urlSession = [NSURLSession sessionWithConfiguration:configuration];
        NSString *authToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"AUTH_TOKEN"];
        if (authToken) {
            self.token = authToken;
            NSLog(@"Token Retrieved");
        }
    }
    
    return self;
}

#pragma mark - SINGLETON

+ (StackOverflowService *)networkController {
    static StackOverflowService *networkController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkController = [[self alloc] init];
    });
    
    return networkController;
}

#pragma mark - API REQUESTS

- (void)fetchQuestions:(NSString *)searchText withCompletion:(void(^)(NSMutableArray *results, NSString *errorDescription))completionHandler {
    NSString *searchTextString = searchText;
    NSString *urlString;
    
    if (self.token != nil) {
        urlString = [NSString stringWithFormat:@"%@%@%@&access_token=%@&key=%@%@", kAPIDomain, kAPISearch, searchTextString, self.token, kClientKey, kAPISite];
        //NSLog(@"%@", urlString);
    } else {
        urlString = [NSString stringWithFormat:@"%@%@%@%@", kAPIDomain, kAPISearch, searchTextString, kAPISite];
        //NSLog(@"%@", urlString);
    }
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
   
    // Create an NSURL Session Data Task
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"Error");
            NSLog(@"%@", error.localizedDescription);
        } else {
            if ([response respondsToSelector:@selector(statusCode)]) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                NSInteger responseCode = [httpResponse statusCode];
                if (responseCode >= 200 && responseCode <= 299) {
                    NSLog(@"Good! Response Code: 200.");
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        completionHandler([Question parseJSONDataIntoQuestion:data], nil);
                    }];
                } else if (responseCode >= 400 && responseCode <= 499) {
                    NSLog(@"Status Code: %ld. Client error.", (long)responseCode);
                } else if (responseCode >= 500 && responseCode <= 599) {
                    NSLog(@"Status Code: %ld. Server error.", (long)responseCode);
                } else {
                    NSLog(@"Bad Response: %ld.", (long)responseCode);
                }
            } else {
                NSLog(@"Invalid, say what!?");
                completionHandler(nil, @"Invalid");
            }
        }
    }];
    
    [dataTask resume];
}

- (void)fetchUsers:(NSString *)searchText withCompletion:(void(^)(NSMutableArray *results, NSString *errorDescription))completionHandler {
    NSString *searchTextString = searchText;
    NSString *urlString;
    
    if (self.token != nil) {
        urlString = [NSString stringWithFormat:@"%@%@%@&access_token=%@&key=%@%@", kAPIDomain, kAPIUser, searchTextString, self.token, kClientKey, kAPISite];
        NSLog(@"%@", urlString);
    } else {
        urlString = [NSString stringWithFormat:@"%@%@%@%@", kAPIDomain, kAPIUser, searchTextString, kAPISite];
        NSLog(@"%@", urlString);
    }
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    // Create an NSURL Session Data Task
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"Error");
            NSLog(@"%@", error.localizedDescription);
        } else {
            if ([response respondsToSelector:@selector(statusCode)]) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                NSInteger responseCode = [httpResponse statusCode];
                if (responseCode >= 200 && responseCode <= 299) {
                    NSLog(@"Good! Response Code: 200.");
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        completionHandler([User parseJSONDataIntoUser:data], nil);
                    }];
                } else if (responseCode >= 400 && responseCode <= 499) {
                    NSLog(@"Status Code: %ld. Client error.", (long)responseCode);
                } else if (responseCode >= 500 && responseCode <= 599) {
                    NSLog(@"Status Code: %ld. Server error.", (long)responseCode);
                } else {
                    NSLog(@"Bad Response: %ld.", (long)responseCode);
                }
            } else {
                NSLog(@"Invalid, say what!?");
                completionHandler(nil, @"Invalid");
            }
        }
    }];
    
    [dataTask resume];
}

#pragma mark - HELPER METHODS

+ (void)setToken:(NSString *)token {
    [[self networkController] setToken:token];
}

@end