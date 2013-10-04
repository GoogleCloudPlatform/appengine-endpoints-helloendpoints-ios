//
//  ViewController.m
//  Hello Endpoints
//
//  Created by Paul Rashidi on 9/9/13.
//  Copyright (c) 2013 Google Inc. All rights reserved.
//

#import "ViewController.h"
#import "GreetingsListViewController.h"
#import "GTLHelloworld.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - UI Elements
@synthesize getGreetingButton;
@synthesize listGreetingsButton;
@synthesize mulitplyGreetingButton;
@synthesize signInButton;
@synthesize getGreetingIDField;
@synthesize multiplyGreetingMessageField;
@synthesize multiplyGreetingCountField;
@synthesize signInLabel;

#pragma mark - Class members
@synthesize greetingsRetrievedFromAPI;
@synthesize service;
BOOL signedIn;

#pragma mark - Remote API handling

// Instatiate a handle to the service if it doesn't exist yet.
- (GTLServiceHelloworld *)helloworldService {
    if (!service) {
        service = [[GTLServiceHelloworld alloc] init];
        
        // Have the service object set tickets to retry temporary error
        // conditions automatically.
        service.retryEnabled = YES;
        
        [GTMHTTPFetcher setLoggingEnabled:YES];
    }
    return service;
}

- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)auth
                 error:(NSError *)error {
    [self dismissModalViewControllerAnimated:YES];
    
    if (error != nil) {
        // Authentication failed
        [signInLabel setText:@"not signed in"];
        [signInButton setTitle:@"Sign In"];
        signedIn = FALSE;
    } else {
        // Authentication succeeded
        [[self helloworldService] setAuthorizer:auth];
        //auth.authorizationTokenKey = [auth ]
        //auth.authorizationTokenKey = @"id_token";
        NSLog(@"Auth token type: %@", auth.tokenType);
        
        [signInLabel setText:@"something@gmail.com"];
        [signInButton setTitle:@"Sign out"];
        signedIn = TRUE;
        // Make some API calls
    }
    [signInButton setEnabled:TRUE];
    signedIn = TRUE;
}

#pragma mark - Storyboard invoked methods

- (IBAction)getGreeting:(id)sender {
    NSLog(@"Get greeting");
    NSString *greetingIDString = [[self getGreetingIDField] text];
    if (greetingIDString) {
        NSInteger greetingID = [greetingIDString intValue];
        GTLServiceHelloworld *apiService = [self helloworldService];
        GTLQueryHelloworld *query = [GTLQueryHelloworld
                                     queryForGreetingsGetGreetingWithIdentifier:greetingID];
        [apiService executeQuery:query completionHandler:^(GTLServiceTicket *ticket,
                                                           GTLHelloworldHelloGreeting *object,
                                                           NSError *error) {
            NSArray *greetings = [NSArray arrayWithObjects: object, nil];
            greetingsRetrievedFromAPI = greetings;
            [self performSegueWithIdentifier: @"DisplayGreetings" sender: self];
        }];
    }
}

- (IBAction)listGreetings:(id)sender {
    NSLog(@"Listing greetings");
    GTLServiceHelloworld *apiService = [self helloworldService];
    GTLQueryHelloworld *query = [GTLQueryHelloworld queryForGreetingsListGreeting];
    [apiService executeQuery:query completionHandler:^(GTLServiceTicket *ticket,
                                                       GTLHelloworldHelloGreetingCollection *object,
                                                       NSError *error) {
        NSArray *greetings = [object items];
        greetingsRetrievedFromAPI = greetings;
        [self performSegueWithIdentifier: @"DisplayGreetings" sender: self];
    }];
}

- (IBAction)multiplyGreetings:(id)sender {
    NSLog(@"Multiply greetings");
    GTLServiceHelloworld *apiService = [self helloworldService];
    GTLHelloworldHelloGreeting *greeting = [GTLHelloworldHelloGreeting new];
    greeting.message = [multiplyGreetingMessageField text];
    NSInteger multiplyGreetingCount = [[multiplyGreetingCountField text] intValue];
    
    GTLQueryHelloworld *query = [GTLQueryHelloworld
                                 queryForGreetingsMultiplyWithObject:greeting
                                                               times:multiplyGreetingCount];
    [apiService executeQuery:query completionHandler:^(GTLServiceTicket *ticket,
                                                       GTLHelloworldHelloGreeting *object,
                                                       NSError *error) {
        NSArray *greetings = [NSArray arrayWithObjects: object, nil];
        greetingsRetrievedFromAPI = greetings;
        [self performSegueWithIdentifier: @"DisplayGreetings" sender: self];
    }];
}

- (IBAction)getAuthenticatedGreeting:(id)sender {
    NSLog(@"Get authenticated greeting");
    GTLServiceHelloworld *apiService = [self helloworldService];
    GTLQueryHelloworld *query = [GTLQueryHelloworld queryForGreetingsAuthed];
    [apiService executeQuery:query completionHandler:^(GTLServiceTicket *ticket,
                                                       GTLHelloworldHelloGreeting *object,
                                                       NSError *error) {
        NSArray *greetings = [NSArray arrayWithObjects: object, nil];
        greetingsRetrievedFromAPI = greetings;
        [self performSegueWithIdentifier: @"DisplayGreetings" sender: self];
    }];
}

- (IBAction)signIn:(id)sender {
    // Sign out if already signed in.
    if (signedIn) {
        [signInLabel setText:@"not signed in"];
        [signInButton setTitle:@"Sign In"];
        [signInButton setEnabled:TRUE];
        service = nil;
        signedIn = FALSE;
        return;
    }
    
    // Otherwise signin.
    NSLog(@"Signing In");
#error Update iOS app name here.
    static NSString *const kKeychainItemName = @"your iOS app name";
#error Update iOS app client id from the Developer console. This must be created as a native app.
    NSString *kMyClientID = @"your iOS app client id";
#error Update iOS app client secret from the Developer console.
    NSString *kMyClientSecret = @"your iOS app client secret";
    NSString *scope = @"https://www.googleapis.com/auth/userinfo.email"; // scope for email
    
    GTMOAuth2ViewControllerTouch *viewController;
    viewController = [[GTMOAuth2ViewControllerTouch alloc] initWithScope:scope
                                                                clientID:kMyClientID
                                                            clientSecret:kMyClientSecret
                                                        keychainItemName:kKeychainItemName
                                                                delegate:self
                                                        finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    [self presentModalViewController:viewController
                            animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSArray *selectedData = greetingsRetrievedFromAPI;
    GreetingsListViewController *destViewController = [segue destinationViewController];
    [destViewController setGreetingsToDisplay:selectedData];
    [destViewController refeshTableView];
}

#pragma mark - Utility methods

- (void)printGreetings {
    if (greetingsRetrievedFromAPI) {
        for (GTLHelloworldHelloGreeting *greeting in greetingsRetrievedFromAPI) {
            NSLog(@"%@", [greeting message]);
        }
    }
}

#pragma mark - Controller methods

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
