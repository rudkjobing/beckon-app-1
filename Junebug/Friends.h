//
//  Friends.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Server.h"
#import "CustomCell.h"
#import "Friend.h"
#import "FriendCell.h"

@interface Friends : NSObject

@property (strong, nonatomic) Server *server;
@property (strong, nonatomic) NSMutableArray *friends;

- (void) getAllFriends;
- (void) removeFriend:(NSString *)friendEmail;
- (void) addFriend: (NSString *)friendEmail;
- (void) getPendingFriendRequests;
- (void) acceptFriendRequest:(NSString *)friendEmail;
- (Friend *) getFriendWithID: (NSString *)id;
@end
