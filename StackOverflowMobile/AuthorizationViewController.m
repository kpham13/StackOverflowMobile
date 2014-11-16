//
//  AuthorizationViewController.m
//  StackOverflowMobile
//
//  Created by Kevin Pham on 11/14/14.
//  Copyright (c) 2014 Kevin Pham. All rights reserved.
//

#import "AuthorizationViewController.h"
#import "StackOverflowService.h"

@interface AuthorizationViewController ()

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation AuthorizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *urlString = @"https://stackexchange.com/oauth/dialog?client_id=3871&redirect_uri=https://stackexchange.com/oauth/login_success&scope=read_inbox";
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    self.webView.navigationDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadView {
    self.webView = [[WKWebView alloc] init];
    self.view = self.webView;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    //NSLog(@"%@", navigationAction.request.URL);
    decisionHandler(WKNavigationActionPolicyAllow);
    
    NSString *requestString = [[[navigationAction request] URL] absoluteString];
    if ([requestString containsString:@"access_token"]) {
        NSArray *components = [requestString componentsSeparatedByString:@"="];
        NSArray *tokenComponents = [components[1] componentsSeparatedByString:@"&"];
        //NSLog(@"%@", tokenComponents[0]);
        NSString *token = tokenComponents[0];
        [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"AUTH_TOKEN"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [StackOverflowService setToken:token];
        
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

@end