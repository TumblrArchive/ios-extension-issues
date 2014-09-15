//
//  ShareViewController.m
//  awesomeshare
//
//  Created by Brian Michel on 8/27/14.
//  Copyright (c) 2014 Tumblr. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareTableView : UITableView

@property (nonatomic) BOOL usesSaneKeyboardHeight;

@property (nonatomic) CGFloat saneKeyboardHeight;

@end

@interface ShareViewController ()

@property (nonatomic) UITextView *footerTextView;

@property (nonatomic) UISwitch *sanitySwitch;

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.footerTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    self.footerTextView.editable = NO;
    
    self.tableView.tableFooterView = self.footerTextView;
    
    self.sanitySwitch = [[UISwitch alloc] init];
    [self.sanitySwitch addTarget:self action:@selector(sanitySwitchChanged:) forControlEvents:UIControlEventValueChanged];
    
    UIBarButtonItem *switchItem = [[UIBarButtonItem alloc] initWithCustomView:self.sanitySwitch];
    self.navigationItem.leftBarButtonItem = switchItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)sanitySwitchChanged:(UISwitch *)sender {
    self.shareTableView.usesSaneKeyboardHeight = sender.isOn;
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.shareTableView.saneKeyboardHeight = CGRectGetHeight(frame);
    self.footerTextView.text = [notification description];
}

- (void)keyboardDidShow:(NSNotification *)notification {
    self.footerTextView.text = [notification description];
}

- (IBAction)done:(id)sender {
    [self.extensionContext completeRequestReturningItems:nil completionHandler:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (ShareTableView *)shareTableView {
    return (ShareTableView *)self.tableView;
}

@end

@implementation ShareTableView

- (void)setSaneKeyboardHeight:(CGFloat)saneKeyboardHeight {
    if (_saneKeyboardHeight == saneKeyboardHeight) {
        return;
    }
    
    _saneKeyboardHeight = saneKeyboardHeight;
    
    self.contentInset = ({
        UIEdgeInsets insets = UIEdgeInsetsZero;
        
        insets.top = self.contentInset.top;
        insets.left = self.contentInset.left;
        insets.bottom = _saneKeyboardHeight;
        insets.right = self.contentInset.right;
        
        insets;
    });
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    UIEdgeInsets insets = contentInset;
    
    if (self.usesSaneKeyboardHeight && contentInset.bottom > self.saneKeyboardHeight) {
        insets = ({
            UIEdgeInsets insets = UIEdgeInsetsZero;
            
            insets.top = self.contentInset.top;
            insets.left = self.contentInset.left;
            insets.bottom = _saneKeyboardHeight;
            insets.right = self.contentInset.right;
            
            insets;
        });
    }
    
    [super setContentInset:insets];
}

@end
