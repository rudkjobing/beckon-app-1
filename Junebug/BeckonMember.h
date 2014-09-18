//
//  BeckonMember.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 10/09/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface BeckonMember : NSObject

@property (strong, nonatomic) NSNumber *id;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSString *status;

@end
