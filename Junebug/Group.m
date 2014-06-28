//
//  Group.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 19/05/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "Group.h"
#import "Friend.h"
#import "MemberCell.h"
#import "AppDelegate.h"

@implementation Group

- (void) getGroupMembers{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:self.id, @"group_id", nil];
        /*This is where we have a json string that can be sent over the interwebs*/
        NSDictionary *result = [self.server queryServerDomain:@"group" WithCommand:@"getMembers" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"success"] isEqualToString:@"1"]){
                NSArray *payload = [result objectForKey:@"payload"];
                [self.members removeAllObjects];
                for(NSDictionary *child in payload){
                    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    [self.members addObject:[appDelegate.appState.friends getFriendWithID:[child objectForKey:@"id"]]];
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"GroupFetched" object:self];
            }
            else{
                [self.members removeAllObjects];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"GroupFetched" object:self];
            }
        });
    });
}

- (void) addMember: (NSString *)memberID{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:memberID, @"friend_id", self.id, @"group_id", nil];
        /*This is where we have a json string that can be sent over the interwebs*/
        NSDictionary *result = [self.server queryServerDomain:@"group" WithCommand:@"addMember" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"success"] isEqualToString:@"1"]){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"GroupRemoved" object:self];
            }
            else{
                
            }
        });
    });
}

- (void) removeMember: (NSString* )memberID{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:memberID, @"friend_id", self.id, @"group_id", nil];
        /*This is where we have a json string that can be sent over the interwebs*/
        NSDictionary *result = [self.server queryServerDomain:@"group" WithCommand:@"removeMember" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"success"] isEqualToString:@"1"]){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"GroupRemoved" object:self];
            }
            else{
                
            }
        });
    });
}

- (NSMutableArray *)members{
    if(!_members){
        _members = [[NSMutableArray alloc] init];
    }
    return _members;
}

@end
