//
//  Friend.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 19/05/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Friend : NSObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *nickname;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSData *thumbnail;
@property (strong, nonatomic) User *user;

@end
