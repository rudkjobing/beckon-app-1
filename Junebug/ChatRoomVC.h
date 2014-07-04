//
//  FriendChatVC.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 01/06/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "SOMessagingViewController.h"


@interface ChatRoomVC : SOMessagingViewController

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSString *chatRoomId;
@property (strong, nonatomic) NSString *clientId;
@property (strong, nonatomic) NSString *senderId;

@end
