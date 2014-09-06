//
//  Beckon.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 27/05/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Server.h"
#import "ChatRoom.h"

@interface Beckon : NSObject

@property (strong, nonatomic) NSNumber *id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *beckonDescription;
@property (strong, nonatomic) NSString *chatRoomId;
@property (strong, nonatomic) NSMutableArray *friends;
@property (strong, nonatomic) NSDate *begins;
@property (strong, nonatomic) NSDate *ends;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) Server *server;
@property (strong, nonatomic) ChatRoom *chatRoom;
@property (strong, nonatomic) NSString *status;

- (void) flush;
- (void) acceptBeckon;
- (void) rejectBeckon;
@end
