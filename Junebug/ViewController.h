//
//  ViewController.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 25/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Server.h"
#import "User.h"

@interface ViewController : UIViewController<AuthenticationDelegate>

@property (strong, nonatomic) User *user;

@end
