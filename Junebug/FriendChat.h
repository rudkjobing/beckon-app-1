//
//  FriendChat.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 31/05/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Friend.h"
#import "Server.h"

@interface FriendChat : NSObject

@property (strong, nonatomic) Server *server;
@property (strong, nonatomic) Friend *recipient;
@property (strong, nonatomic) NSMutableArray *messages;

@end
