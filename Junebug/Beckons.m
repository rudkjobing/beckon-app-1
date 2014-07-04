//
//  Beckons.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "Beckons.h"
#import "ChatRoom.h"
#import "AppDelegate.h"

@implementation Beckons


- (void) getAllBeckons{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [[NSDictionary alloc] init];
        NSDictionary *result = [self.server queryServerDomain:@"beckon" WithCommand:@"getAll" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"status"] isEqualToNumber:@(1)]){
                NSArray *payload = [[result objectForKey:@"payload"] objectForKey:@"beckons"];
                [self loadData:payload];
            }
            else{
                
            }
        });
    });
}

- (void) loadData:(NSArray*)data{
    [self.beckons removeAllObjects];
    for(NSDictionary *child in data){
        Beckon *beckon = [[Beckon alloc] init];
        beckon.id = [child objectForKey:@"id"];
        beckon.title = [child objectForKey:@"title"];
        beckon.chatRoomId = [[child objectForKey:@"chatRoom"] objectForKey:@"id"];
        beckon.server = self.server;
        beckon.chatRoom = [[ChatRoom alloc] initWithId: beckon.chatRoomId];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.appState.chatRooms setObject:beckon.chatRoom forKey:beckon.chatRoomId];
        [self.beckons addObject: beckon];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadBeckonTableView" object:self];
}

- (void) addBeckon:(Beckon*)beckon{
    [self.beckons addObject: beckon];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadBeckonTableView" object:self];
}

- (NSMutableArray *)beckons{
    if(!_beckons){
        _beckons = [[NSMutableArray alloc] init];
    }
    return _beckons;
}

@end
