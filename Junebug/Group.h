//
//  Group.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 19/05/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Server.h"

@interface Group : NSObject

@property (strong, nonatomic) Server *server;
@property (strong, nonatomic) NSMutableArray *members;
@property (strong, nonatomic) NSNumber *id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSData *thumbnail;

- (void) getGroupMembers;
- (void) addMember: (NSString *)memberID;
- (void) removeMember: (NSString* )memberID;
- (void) flush;
- (void) delete;

@end
