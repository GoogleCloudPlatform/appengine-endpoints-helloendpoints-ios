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

// Remote API handling.
- (GTLServiceHelloworld *)helloworldService;

@end
