//
//  Friends.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Server.h"
#import "CustomCell.h"

@interface Friends : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) Server *server;
@property (strong, nonatomic) NSMutableArray *friends;

- (void) getAllFriends;
- (void) addFriend: (NSString *)friendEmail;

@end
