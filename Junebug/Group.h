//
//  Group.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 19/05/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Server.h"

@interface Group : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) Server *server;
@property (strong, nonatomic) NSMutableArray *members;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSData *thumbnail;

- (void) getGroupMembers;

@end
