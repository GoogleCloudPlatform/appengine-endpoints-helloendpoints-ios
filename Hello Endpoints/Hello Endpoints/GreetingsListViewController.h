//
//  GreetingsListViewController.h
//  Hello Endpoints
//
//  Created by Paul Rashidi on 9/20/13.
//  Copyright (c) 2013 Google Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GreetingsListViewController : UITableViewController

@property (strong, atomic) NSArray *greetingsToDisplay;

- (void) refeshTableView;

@end
