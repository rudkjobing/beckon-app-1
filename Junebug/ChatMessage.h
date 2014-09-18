//
//  ChatMessage.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 30/06/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOMessage.h"

@interface ChatMessage : SOMessage

@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *from;

- (ChatMessage*) initWithChatRoomId: (NSString*)id andMessage: (NSString*) message;
- (void) flush;

@end
