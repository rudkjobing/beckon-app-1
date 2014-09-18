//
//  Groups.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Server.h"
#import "Group.h"

@interface Groups : NSObject

@property (strong, nonatomic) Server *server;
@property (strong, nonatomic) NSMutableArray *groups;
@property (strong, nonatomic) NSNumber *newestGroupPointer;

- (void) getAllGroups;
- (void) addGroup: (Group *)name;
- (void) loadData: (NSArray *)data;
- (void) removeGroup: (Group*)group;

@end
