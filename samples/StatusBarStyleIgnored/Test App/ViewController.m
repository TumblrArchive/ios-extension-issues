//
//  ViewController.m
//  Test App
//
//  Created by Paul Rehkugler on 8/7/14.
//  Copyright (c) 2014 Tumblr. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    
    UILabel *instructions = [[UILabel alloc] init];
    instructions.text = @"Nothing to see here.\n-preferredStatusBarStyle works as expected. Launch the Test Share Extension to see what I'm talking about.";
    instructions.frame = CGRectInset(self.view.bounds, 20, 20);
    instructions.textAlignment = NSTextAlignmentCenter;
    instructions.textColor = [UIColor lightGrayColor];
    instructions.numberOfLines = 0;
    
    [self.view addSubview:instructions];

}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
