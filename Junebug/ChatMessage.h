//
//  ChatMessage.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 30/06/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOMessage.h"

@interface ChatMessage : SOMessage

@property (strong, nonatomic) NSString *message;

@end
