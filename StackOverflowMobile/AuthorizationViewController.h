//
//  AuthorizationViewController.h
//  StackOverflowMobile
//
//  Created by Kevin Pham on 11/14/14.
//  Copyright (c) 2014 Kevin Pham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface AuthorizationViewController : UIViewController <WKNavigationDelegate>

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;

@end