//
//  Converstions.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 31/07/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import "Convertions.h"

@implementation Convertions

+(NSDate *)dateFromString:(NSString *)string
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSTimeZone *tz = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormat setTimeZone:tz];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeInterval interval = 0 * 60 * 60;
    
    NSDate *date1 = [dateFormat dateFromString:string];
    date1 = [date1 dateByAddingTimeInterval:interval];
    
    return date1;
}

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)interval
{
    if(interval > 60*60*24){
        NSInteger ti = (NSInteger)interval;
        NSInteger days = ti/60/60/24;
        if(days == 1){
                return [NSString stringWithFormat:@"%li Day", (long)days];
        }
        return [NSString stringWithFormat:@"%li Days", (long)days];
    }
    else if (interval > 60*60 && interval <= 60*60*24){
        NSInteger ti = (NSInteger)interval;
        NSInteger hours = ti/60/60;
        if(hours == 1){
           return [NSString stringWithFormat:@"%li Hour", (long)hours];
        }
        return [NSString stringWithFormat:@"%li Hours", (long)hours];
    }
    else if (interval <= 60*60 && interval > 0){
        NSInteger ti = (NSInteger)interval;
        NSInteger minutes = ti/60;
        if(minutes == 1){
            return [NSString stringWithFormat:@"%li Minute", (long)minutes];
        }
        return [NSString stringWithFormat:@"%li Minutes", (long)minutes];
    }
//    NSInteger ti = (NSInteger)interval;
//    NSInteger seconds = ti % 60;
//    NSInteger minutes = (ti / 60) % 60;
//    NSInteger hours = (ti / 3600);
//    return [NSString stringWithFormat:@"%02li:%02li:%02li", (long)hours, (long)minutes, (long)seconds];
    return @"NOW";
}

@end
