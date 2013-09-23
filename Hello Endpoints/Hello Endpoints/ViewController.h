//
//  ViewController.h
//  Hello Endpoints
//
//  Created by Paul Rashidi on 9/9/13.
//  Copyright (c) 2013 Google Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTMOAuth2ViewControllerTouch.h"
#import "GTMHTTPFetcherLogging.h"
#import "GTLHelloworld.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *getGreetingButton;
@property (weak, nonatomic) IBOutlet UIButton *listGreetingsButton;
@property (weak, nonatomic) IBOutlet UIButton *mulitplyGreetingButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *signInButton;
@property (weak, nonatomic) IBOutlet UILabel *signInLabel;
@property (weak, nonatomic) IBOutlet UITextField *getGreetingIDField;
@property (weak, nonatomic) IBOutlet UITextField *multiplyGreetingMessageField;
@property (weak, nonatomic) IBOutlet UITextField *multiplyGreetingCountField;

@property (strong, atomic) GTLServiceHelloworld *service;
@property (strong, atomic) NSArray *greetingsRetrievedFromAPI;

// Remote API handling.
- (GTLServiceHelloworld *)helloworldService;

@end
