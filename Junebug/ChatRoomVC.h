//
//  FriendChatVC.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 01/06/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import "SOMessagingViewController.h"
@class ChatRoom;

@interface ChatRoomVC : SOMessagingViewController

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) ChatRoom *chatRoom;
@property (strong, nonatomic) NSString *clientId;
@property (strong, nonatomic) NSString *senderId;

@end
