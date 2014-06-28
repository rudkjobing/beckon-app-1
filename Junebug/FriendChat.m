//
//  FriendChat.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 31/05/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "FriendChat.h"

@implementation FriendChat

- (void) getMessages{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [[NSDictionary alloc] init];
        /*This is where we have a json string that can be sent over the interwebs*/
        NSDictionary *result = [self.server queryServerDomain:@"friend" WithCommand:@"getMessages" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"success"] isEqualToString:@"1"]){
                
            }
            else{
                
            }
        });
    });
}

- (void) putMessage: (NSString *)message{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:self.recipient.id, @"recipient_id", message , @"message", nil];
        /*This is where we have a json string that can be sent over the interwebs*/
        NSDictionary *result = [self.server queryServerDomain:@"friend" WithCommand:@"putMessage" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"success"] isEqualToString:@"1"]){
                
            }
            else{
                
            }
        });
    });
}

@end
