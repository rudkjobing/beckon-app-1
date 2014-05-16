//
//  Friends.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Server.h"

@interface Friends : NSObject

@property (strong, nonatomic) Server *server;
@property (strong, nonatomic) NSMutableArray *friends;

@end
