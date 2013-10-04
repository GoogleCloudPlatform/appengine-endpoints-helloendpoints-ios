//
//  GreetingsListViewController.m
//  Hello Endpoints
//
//  Created by Paul Rashidi on 9/20/13.
//  Copyright (c) 2013 Google Inc. All rights reserved.
//

#import "GreetingsListViewController.h"
#import "GTLHelloworld.h"

@interface GreetingsListViewController ()

@end

@implementation GreetingsListViewController

// Class members.
@synthesize greetingsToDisplay;

- (void) refeshTableView {
    [[self tableView] reloadData];
}

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Only 1 section.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Only 1 section which is the greeting list section.
    if (section == 0) {
        return [greetingsToDisplay count];
    } else {
        NSLog(@"No rows returned");
        return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // No headers.
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"GreetingTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    NSInteger greetingIndex = [indexPath indexAtPosition:1];
    GTLHelloworldHelloGreeting *greeting = [greetingsToDisplay objectAtIndex:greetingIndex];
    UILabel *messageLabel = (UILabel *) [cell viewWithTag:1];
    [messageLabel setText:[greeting message]];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
