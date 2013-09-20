//
//  ViewController.m
//  Hello Endpoints
//
//  Created by Paul Rashidi on 9/9/13.
//  Copyright (c) 2013 Google Inc. All rights reserved.
//

#import "ViewController.h"
#import "GTLHelloworld.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize getGreetingButton;
@synthesize listGreetingsButton;
@synthesize mulitplyGreetingButton;

// Remote API handling.

// Instatiate a handle to the service if it doesn't exist yet.
- (GTLServiceHelloworld *)helloworldService {
    static GTLServiceHelloworld *service = nil;
    if (!service) {
        service = [[GTLServiceHelloworld alloc] init];
        
        // Have the service object set tickets to retry temporary error conditions
        // automatically
        service.retryEnabled = YES;
        
        [GTMHTTPFetcher setLoggingEnabled:YES];
    }
    return service;
}

// End Remote API handling.

// Begin Button actions.
- (IBAction)listGreetings:(id)sender {
    NSLog(@"Listing greetings");
    GTLServiceHelloworld *service = [self helloworldService];
    GTLQueryHelloworld *query = [GTLQueryHelloworld queryForGreetingsListGreeting];
    [service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, GTLHelloworldGreetingCollection *object, NSError *error) {
        NSArray *greetings = [object items];
        for (GTLHelloworldGreeting *greeting in greetings) {
                NSLog(@"%@", greeting.message);
        }
    }];
}

// End Button actions.



- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
