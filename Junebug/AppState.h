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
#import "Beckons.h"

@interface AppState : NSObject

@property (strong, nonatomic) Server *server;

@property (strong, nonatomic) Friends *friends;
@property (strong, nonatomic) Groups *groups;
@property (strong, nonatomic) Beckons *beckons;
@property (strong, nonatomic) NSMutableDictionary *chatRooms;
@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSNumber *userId;

- (void) signUpWithEmail: (NSString *)email Password: (NSString *)password Firstname: (NSString *)firstname Lastname: (NSString *)lastname;
- (void) signInUsingEmail: (NSString *) email AndPassword: (NSString *) password;
- (void) updateNotificationToken;
- (void) getState;
- (void) handleNotification: (NSDictionary *)userInfo;
- (void) signOut;

@end
