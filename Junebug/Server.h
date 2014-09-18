//
//  Server.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Server : NSObject


@property (strong, nonatomic) NSString *cookieId;
@property (strong, nonatomic) NSString *cookie;

-(NSDictionary *) queryServerDomain:(NSString*)domain WithCommand:(NSString *)command andData:(NSDictionary *)data;
-(void) startIndicator;
-(void) stopIndicator;

@end
