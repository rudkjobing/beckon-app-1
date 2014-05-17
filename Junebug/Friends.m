//
//  Friends.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "Friends.h"

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
                    NSString *firstName = [child objectForKey:@"firstname"];
                    NSString *lastName = [child objectForKey:@"lastname"];
                    NSString *name = [[firstName stringByAppendingString:@" "] stringByAppendingString:lastName];
                    [self.friends addObject:name];
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"FriendsFetched" object:self];
            }
            else{
                
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
    static NSString *cellIdentifier =@"Cell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.labelInCell.text = [self.friends objectAtIndex:indexPath.row];
    return cell;
}

- (NSMutableArray *)friends{
    if(!_friends){
        _friends = [[NSMutableArray alloc] init];
    }
    return _friends;
}

@end
