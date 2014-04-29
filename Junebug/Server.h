//
//  Server.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Server : NSObject

+(Server *)sharedInstance;
-(NSDictionary *) fetchDataFromDestination:(NSString *)destination WithData:(NSDictionary *)data;

@end
