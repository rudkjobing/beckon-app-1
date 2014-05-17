//
//  AppState.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 12/05/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Server.h"
#import "Friends.h"
#import "Groups.h"

@interface AppState : NSObject

@property (strong, nonatomic) Server *server;
@property (strong, nonatomic) Friends *friends;
@property (strong, nonatomic) Groups *groups;

- (void) registerDeviceUsingEmail: (NSString *) email AndPassword: (NSString *) password;
- (void) applicationReady;

@end
