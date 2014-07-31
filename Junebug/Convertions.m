//
//  Converstions.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 31/07/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "Convertions.h"

@implementation Convertions

+(NSDate *)dateFromString:(NSString *)string
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSTimeZone *tz = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormat setTimeZone:tz];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date1 = [dateFormat dateFromString:string];
    if(!date1) date1= [NSDate date];
    
    return date1;
}

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)interval
{
    if(interval > 60*60*24){
        NSInteger ti = (NSInteger)interval;
        NSInteger days = ti/60/60/24;
        return [NSString stringWithFormat:@"%02liD", (long)days];
    }
    else if (interval > 60*60 && interval <= 60*60*24){
        NSInteger ti = (NSInteger)interval;
        NSInteger hours = ti/60/60;
        return [NSString stringWithFormat:@"%02liH", (long)hours];
    }
    else if (interval <= 60*60 && interval > 0){
        NSInteger ti = (NSInteger)interval;
        NSInteger minutes = ti/60;
        return [NSString stringWithFormat:@"%02liM", (long)minutes];
    }
//    NSInteger ti = (NSInteger)interval;
//    NSInteger seconds = ti % 60;
//    NSInteger minutes = (ti / 60) % 60;
//    NSInteger hours = (ti / 3600);
//    return [NSString stringWithFormat:@"%02li:%02li:%02li", (long)hours, (long)minutes, (long)seconds];
    return @"NOW";
}

@end
