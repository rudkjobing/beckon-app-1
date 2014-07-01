//
//  FriendChatVC.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 01/06/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "SOMessagingViewController.h"
#import "ChatRoom.h"

@interface ChatRoomVC : SOMessagingViewController

@property (strong, nonatomic)ChatRoom *chatRoom;

@end
