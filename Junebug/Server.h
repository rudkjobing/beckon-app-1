//
//  Server.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Server : NSObject


@property (strong, nonatomic) NSString *cookieId;
@property (strong, nonatomic) NSString *cookie;
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *auth_key;
@property (strong, nonatomic) NSString *device_key;

-(NSDictionary *) queryServerDomain:(NSString*)domain WithCommand:(NSString *)command andData:(NSDictionary *)data;

@end
