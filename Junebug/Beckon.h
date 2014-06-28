//
//  Beckon.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 27/05/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Server.h"

@interface Beckon : NSObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSMutableArray *friends;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) Server *server;

- (void) flush;

@end
