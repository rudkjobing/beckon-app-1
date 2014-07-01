//
//  ChatRoom.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 30/06/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatRoom : NSObject

@property (strong, nonatomic) NSMutableArray *chatMessages;
@property (strong, nonatomic) NSString *id;

- (ChatRoom*) initWithId: (NSString*)id;
- (void) sync;

@end
