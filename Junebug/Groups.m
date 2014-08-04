//
//  Groups.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "Groups.h"
#import "Group.h"
#import "GroupCell.h"

@implementation Groups

- (void) getAllGroups{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [[NSDictionary alloc] init];
        /*This is where we have a json string that can be sent over the interwebs*/
        NSDictionary *result = [self.server queryServerDomain:@"group" WithCommand:@"getGroups" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"status"] isEqualToNumber:@(1)]){
                NSArray *groups = [[result objectForKey:@"payload"] objectForKey:@"groups"];
                [self loadData:groups];
            }
            else{
                
            }
        });
    });
}

- (void) addGroup:(Group*)group{
    [self.groups addObject: group];
    if(group.id > self.newestGroupPointer){
        self.newestGroupPointer = group.id;//Notify observer
    }
    else{
        self.newestGroupPointer = self.newestGroupPointer;//Notify observer
    }
}

- (void) removeGroup:(Group*)group{
    [self.groups removeObject:group];
    self.newestGroupPointer = self.newestGroupPointer;//Notify observer
}

- (void) loadData: (NSArray*) data{
    [self.groups removeAllObjects];
    for(NSDictionary *child in data){
        Group *group = [[Group alloc] init];
        group.id = [child objectForKey:@"id"];
        group.name = [child objectForKey:@"name"];
        group.server = self.server;
        [self.groups addObject:group];
        if([self.newestGroupPointer integerValue] < [group.id integerValue]){
            self.newestGroupPointer = group.id;//Notify observer
        }
    }
}

- (NSMutableArray *)groups{
    if(!_groups){
        _groups = [[NSMutableArray alloc] init];
    }
    return _groups;
}

- (NSNumber *)newestGroupPointer{
    if(!_newestGroupPointer){
        _newestGroupPointer = [[NSNumber alloc] initWithInt:0];
    }
    return _newestGroupPointer;
}

@end
