//
//  ShareViewController.m
//  ShareExtension
//
//  Created by Bryan Irace on 8/22/14.
//  Copyright (c) 2014 Bryan Irace. All rights reserved.
//

#import "ShareViewController.h"

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    static NSString *GroupIdentifier = @"group.ShareExtensionTest";
    
    // Create an `NSURLSession` with a background configuration that uses the app group's identifier as its `sharedContainerIdentifier`
    NSURLSession *session = [NSURLSession sessionWithConfiguration:({
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"id"];
        configuration.sharedContainerIdentifier = GroupIdentifier;
        configuration;
    })];
    
    /*
     *  Create a URL where we will write the file that will be uploaded by our `NSURLSessionUploadTask`. This file will
     *  be written into our app group's shared container.
     */
    NSURL *requestBodyFileURL = [[[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:GroupIdentifier]
                                 URLByAppendingPathComponent:@"requestBody.txt"];

    // Create a simple request body
    NSData *data = [@"{\"foo\":\"bar\"}" dataUsingEncoding:NSUTF8StringEncoding];

    // Write the request body to disk – we need it in a file so that we can upload it using an `NSURLSessionUploadTask`
    if (![data writeToURL:requestBodyFileURL atomically:YES]) {
        NSLog(@"Failed to write request body data to file URL: %@", requestBodyFileURL);
    }
    
    // Prove that I can read from the shared container. If I can write and read it from the extension, the `NSURLSessionUploadTask` should be able read it as well
    NSData *readRequestBodyData = [NSData dataWithContentsOfFile:requestBodyFileURL.path];
    
    NSLog(@"Length of request body data read from the shared container: %lu", (unsigned long)readRequestBodyData.length);
    
    // I am uploading the request body to a very simple web server (included in the .zip file)
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:3000/"]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
    
    /*
     *  When run on a device, this line generates the following error message:
     *
     *  `Failed to issue sandbox extension for file file:///private/var/mobile/Containers/Shared/AppGroup/DAC0CE53-E97B-40D8-B636-18F85460DC2B/requestBody.txt, errno = 1`
     *
     *  Aug 22 17:37:34 BryPhone-5 nsurlsessiond[101] <Error>: Error linking upload file: Error Domain=NSCocoaErrorDomain Code=257 "The operation couldn’t be completed. (Cocoa error 257.)" UserInfo=0x145bc9f0 {NSFilePath=/private/var/mobile/Containers/Shared/AppGroup/DAC0CE53-E97B-40D8-B636-18F85460DC2B/requestBody.txt, NSUnderlyingError=0x145c38e0 "The operation couldn’t be completed. Operation not permitted"}
     */
    NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request fromFile:requestBodyFileURL];
    [task resume];
    
    // Dismiss the extension now that our request is on its way
    [self.extensionContext completeRequestReturningItems:nil completionHandler:nil];
}

@end
