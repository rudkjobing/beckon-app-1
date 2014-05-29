//
//  Beckon.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 27/05/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "Beckon.h"

@implementation Beckon
/*
- (void) addBeckonTitle:(NSString *)title Description: (NSString *)description{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:name, @"group_name", nil];
        This is where we have a json string that can be sent over the interwebs
        NSDictionary *result = [self.server queryServerDomain:@"group" WithCommand:@"add" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"success"] isEqualToString:@"1"]){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"GroupAdded" object:self];
            }
            else{
                
            }
        });
    });
}
*/
@end
