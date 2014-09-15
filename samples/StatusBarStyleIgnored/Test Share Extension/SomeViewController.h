//
//  SomeViewController.h
//  Test App
//
//  Created by Paul Rehkugler on 8/7/14.
//  Copyright (c) 2014 Tumblr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ExtensionContextHolder <NSObject>

- (NSExtensionContext *)extensionContext;

@end


@interface SomeViewController : UIViewController

- (instancetype)initWithExtensionContextHolder:(id<ExtensionContextHolder>)extensionContextHolder;

@end
