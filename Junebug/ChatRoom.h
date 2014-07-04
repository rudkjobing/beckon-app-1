//
//  ChatRoom.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 30/06/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatRoomVC.h"
#import "ChatMessage.h"

@interface ChatRoom : NSObject

@property (strong, nonatomic) NSMutableArray *chatMessages;
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) ChatRoomVC *chatRoomVC;

- (ChatRoom*) initWithId: (NSString*)id;
- (void) sync;
- (void) recieveMessage: (ChatMessage *)chatMessage;

@end
