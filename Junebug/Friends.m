//
//  Friends.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import "Friends.h"

@implementation Friends

- (void) getAllFriends{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [[NSDictionary alloc] init];
        /*This is where we have a json string that can be sent over the interwebs*/
        NSDictionary *result = [self.server queryServerDomain:@"friend" WithCommand:@"getFriends" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"status"] isEqualToNumber:@(1)]){
                NSArray *payload = [[result objectForKey:@"payload"] objectForKey:@"friends"];
                [self loadData:payload];
            }
            else{

            }
        });
    });
}

- (void) loadData: (NSArray*) data{
    [self.friends removeAllObjects];
    for(NSDictionary *child in data){
        Friend *friend      = [[Friend alloc] init];
        friend.id           = [child objectForKey:@"id"];
        friend.firstName    = [[child objectForKey:@"user"] objectForKey:@"firstName"];
        friend.lastName     = [[child objectForKey:@"user"] objectForKey:@"lastName"];
        friend.email        = [[child objectForKey:@"user"] objectForKey:@"emailAddress"];
        friend.nickname     = [child objectForKey:@"nickname"];
        friend.user         = [[User alloc] init];
//        friend.user.id      = [[NSNumber alloc] initWithInt:[[[child objectForKey:@"user"] objectForKey:@"id"] intValue]];
        friend.user.id      = [[child objectForKey:@"user"] objectForKey:@"id"];
        [self.friends addObject:friend];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadFriendTableView" object:self];
}

- (void) getPendingFriendRequests{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [[NSDictionary alloc] init];
        /*This is where we have a json string that can be sent over the interwebs*/
        NSDictionary *result = [self.server queryServerDomain:@"friend" WithCommand:@"getPending" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"success"] isEqualToString:@"1"]){
                NSDictionary *payload = [result objectForKey:@"payload"];
                if(payload){
                    NSDictionary *badge = [[NSDictionary alloc] initWithObjectsAndKeys:[[NSString alloc] initWithFormat:@"%lu", (unsigned long)payload.count], @"badge",nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"PendingFriendRequests" object:self userInfo:result];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateFriendRequestsBadge" object:self userInfo:badge];
                }
            }
            else{
                NSString *message = [result objectForKey:@"message"];
                if([message isEqualToString:@"You have no pending friend requests"]){
                    NSDictionary *badge = badge = [[NSDictionary alloc] initWithObjectsAndKeys:@"0", @"badge",nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateFriendRequestsBadge" object:self userInfo:badge];
                }
            }
        });
    });
}

- (void) addFriend:(NSString *)friendEmailAddress{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:friendEmailAddress, @"friendEmailAddress", nil];
        /*This is where we have a json string that can be sent over the interwebs*/
        NSDictionary *result = [self.server queryServerDomain:@"friend" WithCommand:@"addFriend" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"status"] isEqualToNumber:@(1)]){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"FriendAdded" object:self];
            }
            else{
                
            }
        });
    });
}

- (void) acceptFriendRequest:(NSString *)friendEmail{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:friendEmail, @"friend_email", nil];
        /*This is where we have a json string that can be sent over the interwebs*/
        NSDictionary *result = [self.server queryServerDomain:@"friend" WithCommand:@"accept" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"success"] isEqualToString:@"1"]){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"FriendRequestAccepted" object:self];
            }
            else{
                
            }
        });
    });
}

- (void) removeFriend:(NSString *)friendEmail{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:friendEmail, @"friend_email", nil];
        /*This is where we have a json string that can be sent over the interwebs*/
        NSDictionary *result = [self.server queryServerDomain:@"friend" WithCommand:@"remove" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"success"] isEqualToString:@"1"]){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"FriendRemoved" object:self];
            }
            else{
                
            }
        });
    });
}

- (Friend *) getFriendWithID: (NSString *)id{
    Friend *result = [[Friend alloc]init];
    for(Friend *f in self.friends){
        if([f.id isEqualToString:id]){
            return f;
        }
    }
    return result;
}

- (NSMutableArray *)friends{
    if(!_friends){
        _friends = [[NSMutableArray alloc] init];
    }
    return _friends;
}

@end
