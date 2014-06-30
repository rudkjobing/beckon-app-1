//
//  Groups.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Server.h"
#import "Group.h"

@interface Groups : NSObject

@property (strong, nonatomic) Server *server;
@property (strong, nonatomic) NSMutableArray *groups;

- (void) getAllGroups;
- (void) addGroup: (Group *)name;
- (void) loadData: (NSArray *)data;
- (void) removeGroup: (Group*)group;

@end
