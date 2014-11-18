//
//  MasterTableViewController.m
//  StackOverflowMobile
//
//  Created by Kevin Pham on 11/12/14.
//  Copyright (c) 2014 Kevin Pham. All rights reserved.
//

#import "MasterTableViewController.h"
#import "AuthorizationViewController.h"
#import "StackOverflowService.h"

@interface MasterTableViewController ()

@end

@implementation MasterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupVC];
    
    // Localization
    self.title = NSLocalizedString(@"Stack", nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TABLE VIEW DELEGATE

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.height * 0.3;
}

#pragma mark - VIEW DID LOAD

- (void)setupVC {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"AUTH_TOKEN"];
    
    if (!token) {
        dispatch_after(1, dispatch_get_main_queue(), ^{
            [((UIWindow *)[[UIApplication sharedApplication].windows firstObject]).rootViewController presentViewController:[AuthorizationViewController new] animated:true completion:nil];
        });
    } else {
        [StackOverflowService setToken:token];
    }
}

@end