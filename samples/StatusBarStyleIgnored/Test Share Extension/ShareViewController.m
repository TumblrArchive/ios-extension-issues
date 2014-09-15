//
//  ShareViewController.m
//  Test Share Extension
//
//  Created by Paul Rehkugler on 8/7/14.
//  Copyright (c) 2014 Tumblr. All rights reserved.
//

#import "ShareViewController.h"
#import "SomeViewController.h"

@interface ShareViewController ()<ExtensionContextHolder>

@end

@implementation ShareViewController

- (void)viewDidAppear:(BOOL)animated {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[SomeViewController alloc] initWithExtensionContextHolder:self]];
    [self presentViewController:navigationController animated:YES completion:nil];    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
