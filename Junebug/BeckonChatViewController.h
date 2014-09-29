//
//  BeckonChatViewController.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 28/09/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOMessagingViewController.h"
@class ChatRoom;

@interface BeckonChatViewController : SOMessagingViewController

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) ChatRoom *chatRoom;
@property (strong, nonatomic) NSString *clientId;
@property (strong, nonatomic) NSString *senderId;

@end