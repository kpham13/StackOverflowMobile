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

@implementation StackOverflowService

// MARK: - API REQUESTS

- (void)fetchTaggedQuestions:(NSString *)tag withCompletion:(void(^)(NSArray *results, NSString *errorDescription))completionHandler {
    NSString *tagString = tag;
    NSString *questionURLStart = (@"http://api.stackexchange.com/2.2/questions?order=desc&sort=activity&tagged=");
    NSString *questionURLEnd = (@"&site=stackoverflow");
    NSString *questionURL = [[questionURLStart stringByAppendingString:tagString] stringByAppendingString:questionURLEnd];
    NSLog(@"%@", questionURL);
    //http://api.stackexchange.com/2.2/questions?order=desc&sort=activity&tagged=swift&site=stackoverflow
    
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
                switch (responseCode) {
                    case 200:
                        NSLog(@"Good!");
                        completionHandler([Question parseJSONDataIntoQuestion:data], nil);
                        break;
                    default:
                        break;
                }
            } else {
                NSLog(@"Invalid, say what!?");
                completionHandler(nil, @"Invalid");
            }
        }
    }];
    
    [dataTask resume];
}


//func repoSearch(searchText: String, completionHandler: (errorDescription: String?, repos: [Repositories]?) -> (Void)) {
//    // Checks to see if authenticated
//    if self.authenticationConfig == nil {
//        return()
//    }
//
//    let searchString = searchText
//    let searchDirectory = "/search/repositories?q="
//    let searchURL = self.gitHubAPI + searchDirectory + searchString
//    let request = NSURLRequest(URL: NSURL(string: searchURL)!)
//
//    // Create session using authentication config
//    let configuration = self.authenticationConfig!
//    let session = NSURLSession(configuration: configuration)
//
//    // Create an NSURL Session Data Task
//    let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
//        if error != nil {
//            println("Error!")
//        } else {
//            if let httpResponse = response as? NSHTTPURLResponse {
//                var error : NSError?
//
//                let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
//                let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
//
//                switch httpResponse.statusCode {
//                case 200...299:
//                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//                        var repos = [Repositories]()
//
//                        let repoObjects = Repositories.parseJSONDataIntoRepos(data)
//                        repos = repoObjects!
//                        completionHandler(errorDescription: nil, repos: repos)
//                    })
//                case 400...499:
//                    completionHandler(errorDescription: "Status Code: \(httpResponse.statusCode). Client error.", repos: nil)
//                case 500...599:
//                    completionHandler(errorDescription: "Status Code: \(httpResponse.statusCode). Server error.", repos: nil)
//                default:
//                    completionHandler(errorDescription: "Bad Response: \(responseString)", repos: nil)
//                }
//            }
//        }
//    })
//
//    // Run the task
//    dataTask.resume()
//}

//func fetchHomeTimeLine( completionHandler : (errorDescription : String?, tweets : [Tweet]?) -> (Void)) {
//    
//    let accountStore = ACAccountStore()
//    let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
//    
//    accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted : Bool, error : NSError!) -> Void in
//        if granted {
//            
//            let accounts = accountStore.accountsWithAccountType(accountType)
//            self.twitterAccount = accounts.first as ACAccount?
//            //setup our twitter request
//            let url = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
//            let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: url, parameters: nil)
//            twitterRequest.account = self.twitterAccount
//            
//            twitterRequest.performRequestWithHandler({ (data, httpResponse, error) -> Void in
//                
//                switch httpResponse.statusCode {
//                case 200...299:
//                    let tweets = Tweet.parseJSONDataIntoTweets(data)
//                    println(tweets?.count)
//                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//                        completionHandler(errorDescription: nil, tweets: tweets)
//                    })
//                    //right here, we are on a background queue aka thread
//                case 400...499:
//                    println("this is the clients fault")
//                    println(httpResponse.description)
//                    completionHandler(errorDescription: "This is your fault", tweets: nil)
//                case 500...599:
//                    println("this is the servers fault")
//                    completionHandler(errorDescription: "Our servers are currently down", tweets: nil)
//                default:
//                    println("something bad happened")
//                }
//                
//            })
//        }
//    }
//    
//}


/*
- (void)questionSearch:(NSString *)searchText withCompletion:(void(^)(NSArray *results, NSString *errorDescription))completionHandler {
 
 
 
}
*/

@end

//-(void)fetchUserReposAndFollowers {
//    NSURL *repoURL = [[NSURL alloc]initWithString:@"https://api.github.com/user/repos?sort=pushed"];
//    NSURL *followerURL = [[NSURL alloc]initWithString:@"https://api.github.com/user/followers"];
//    NSLog(@"%@", self.session.configuration.HTTPAdditionalHeaders);
//    [[self.session dataTaskWithURL:repoURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        if (error) {
//            NSLog(@"%@", error.localizedDescription);
//        } else {
//            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//            switch (httpResponse.statusCode) {
//                case 200:
//                    NSLog(@"all good");
//                    break;
//                case 401:
//                    NSLog(@"Unauthorized");
//                default:
//                    break;
//            }
//            NSLog(@"%@", response);
//        }
//        NSArray *reposJson = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//        if (self.delegate && [self.delegate respondsToSelector:@selector(reposFinishedParsing:)]) {
//            [self.delegate reposFinishedParsing:reposJson];
//        }
//    }] resume];
//    [[self.session dataTaskWithURL:followerURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        if (error) {
//            NSLog(@"%@", error.localizedDescription);
//        } else {
//            NSLog(@"%@", response);
//        }
//        NSArray *followersJson = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//        if (self.delegate && [self.delegate respondsToSelector:@selector(followersFinishedParsing:)]) {
//            [self.delegate followersFinishedParsing:followersJson];
//        }
//    }] resume];
//}

//func userSearch(searchText: String, completionHandler: (errorDescription: String?, users: [Users]?) -> (Void)) {
//    // Checks to see if authenticated
//    if self.authenticationConfig == nil {
//        return()
//    }
//    
//    let searchString = searchText
//    let searchDirectory = "/search/users?q="
//    let searchURL = self.gitHubAPI + searchDirectory + searchString
//    let request = NSURLRequest(URL: NSURL(string: searchURL)!)
//    
//    // Create session using authentication config
//    let configuration = self.authenticationConfig!
//    let session = NSURLSession(configuration: configuration)
//    
//    // Create an NSURL Session Data Task
//    let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
//        if error != nil {
//            println("Error!")
//        } else {
//            if let httpResponse = response as? NSHTTPURLResponse {
//                var error : NSError?
//                
//                let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
//                let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
//                
//                switch httpResponse.statusCode {
//                case 200...299:
//                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//                        var users = [Users]()
//                        
//                        let userObjects = Users.parseJSONDataIntoUsers(data)
//                        users = userObjects!
//                        completionHandler(errorDescription: nil, users: users)
//                    })
//                case 400...499:
//                    completionHandler(errorDescription: "Status Code: \(httpResponse.statusCode). Client error.", users: nil)
//                case 500...599:
//                    completionHandler(errorDescription: "Status Code: \(httpResponse.statusCode). Server error.", users: nil)
//                default:
//                    completionHandler(errorDescription: "Bad Response: \(responseString)", users: nil)
//                }
//            }
//        }
//    })
//    
//    // Run the task
//    dataTask.resume()
//}