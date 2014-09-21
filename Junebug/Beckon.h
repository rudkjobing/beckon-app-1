//
//  Beckon.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 27/05/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Server.h"
#import "ChatRoom.h"

@interface Beckon : NSObject

@property (strong, nonatomic) NSNumber *id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *beckonDescription;
@property (strong, nonatomic) NSString *locationString;
@property (strong, nonatomic) NSString *chatRoomId;
@property (strong, nonatomic) NSMutableArray *friends;
@property (strong, nonatomic) NSDate *begins;
@property (strong, nonatomic) NSDate *ends;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) Server *server;
@property (strong, nonatomic) ChatRoom *chatRoom;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSMutableArray *members;
@property (strong, nonatomic) NSNumber *hasUnreadMessages;
@property (strong, nonatomic) NSNumber *invited;
@property (strong, nonatomic) NSNumber *accepted;
@property (assign) BOOL isInFocus;//To tell if a viewController is presenting data from this beckon;

- (void) flush;
- (void) acceptBeckon;
- (void) rejectBeckon;
- (void) deleteBeckon;

@end
