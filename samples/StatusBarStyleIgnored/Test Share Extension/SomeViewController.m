//
//  SomeViewController.m
//  Test App
//
//  Created by Paul Rehkugler on 8/7/14.
//  Copyright (c) 2014 Tumblr. All rights reserved.
//

#import "SomeViewController.h"

@interface SomeViewController ()

@property (nonatomic) id<ExtensionContextHolder> extensionContextHolder;

@end

@implementation SomeViewController

- (instancetype)initWithExtensionContextHolder:(id<ExtensionContextHolder>)extensionContextHolder {
    if (self = [super init]) {
        _extensionContextHolder = extensionContextHolder;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *instructions = [[UILabel alloc] init];
    instructions.text = @"preferredStatusBarStyle is set to UIStatusBarStyleLightContent, but it's still dark. :(";
    instructions.frame = CGRectInset(self.view.bounds, 20, 20);
    instructions.textAlignment = NSTextAlignmentCenter;
    instructions.textColor = [UIColor lightGrayColor];
    instructions.numberOfLines = 0;
    
    [self.view addSubview:instructions];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissShareExtension:)];
    self.view.backgroundColor = [UIColor blackColor];
    
}

- (void)dismissShareExtension:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [[self.extensionContextHolder extensionContext] completeRequestReturningItems:nil completionHandler:nil];
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
