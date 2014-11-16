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

- (void)fetchTaggedQuestions:(NSString *)searchTag withCompletion:(void(^)(NSMutableArray *results, NSString *errorDescription))completionHandler {
    NSString *searchTagString = searchTag;
    self.key = (@"AGLRU84QIkWw*XfUGX65eA((");
    //NSString *questionURLStart = (@"http://api.stackexchange.com/2.2/questions?order=desc&sort=activity&tagged=");
    NSString *questionURLStart = (@"https://api.stackexchange.com/2.2/search/advanced?order=desc&sort=activity&site=stackoverflow&q=");
    //NSString *questionURLEnd = (@"&site=stackoverflow");
    NSString *questionURL1 = (@"&access_token=");
    NSString *questionURL2 = (@"&key=");
    NSString *questionURL = [[[[[questionURLStart stringByAppendingString:searchTagString] stringByAppendingString:questionURL1] stringByAppendingString:self.token] stringByAppendingString:questionURL2] stringByAppendingString:self.key];
    NSLog(@"%@", questionURL);
    //http://api.stackexchange.com/2.2/questions?order=desc&sort=activity&tagged=swift&site=stackoverflow
    //    NSString *urlWithKey = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/search/advanced?order=desc&sort=activity&site=stackoverflow&q=%@&access_token=%@&key=%@",key,self.token,kClientKey];
    
    NSURL *url = [[NSURL alloc] initWithString:questionURL];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
   
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
                } else {
                    NSLog(@"Bad: %ld", (long)responseCode); // %@ <- string interpolation
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