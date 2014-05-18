//
//  Friends.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "Friends.h"
#import "FriendCell.h"

@implementation Friends

- (void) getAllFriends{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [[NSDictionary alloc] init];
        /*This is where we have a json string that can be sent over the interwebs*/
        NSDictionary *result = [self.server queryServerDomain:@"friend" WithCommand:@"getAll" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"success"] isEqualToString:@"1"]){
                NSArray *payload = [result objectForKey:@"payload"];
                [self.friends removeAllObjects];
                for(NSDictionary *child in payload){
                    NSString *email = [child objectForKey:@"email"];
                    [self.friends addObject:email];
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"FriendsFetched" object:self];
            }
            else{
                
            }
        });
    });
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
                NSDictionary *badge;
                if(payload){
                    badge = [[NSDictionary alloc] initWithObjectsAndKeys:[[NSString alloc] initWithFormat:@"%u", payload.count], @"badge",nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"PendingFriendRequests" object:self userInfo:result];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateFriendRequestsBadge" object:self userInfo:badge];
                }
            }
            else{
                NSString *message = [result objectForKey:@"payload"];
                if([message isEqualToString:@"You have no pending friend requests"]){
                    NSDictionary *badge = badge = [[NSDictionary alloc] initWithObjectsAndKeys:@"0", @"badge",nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateFriendRequestsBadge" object:self userInfo:badge];
                }
            }
        });
    });
}

- (void) addFriend:(NSString *)friendEmail{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:friendEmail, @"friend_email", nil];
        /*This is where we have a json string that can be sent over the interwebs*/
        NSDictionary *result = [self.server queryServerDomain:@"friend" WithCommand:@"add" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"success"] isEqualToString:@"1"]){
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.friends.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[FriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [self.friends objectAtIndex:indexPath.row];
    return cell;
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        NSString *email = [self.friends objectAtIndex:indexPath.row];
        [self.friends removeObjectAtIndex:indexPath.row];
        [self removeFriend:email];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

- (NSMutableArray *)friends{
    if(!_friends){
        _friends = [[NSMutableArray alloc] init];
    }
    return _friends;
}

@end
