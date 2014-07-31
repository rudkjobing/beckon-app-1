//
//  Converstions.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 31/07/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Convertions : NSObject

+(NSDate *)dateFromString:(NSString *)string;
+(NSString *)stringFromTimeInterval:(NSTimeInterval)interval;
@end
