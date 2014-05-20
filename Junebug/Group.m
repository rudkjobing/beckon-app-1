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

@implementation Group

- (void) getGroupMembers{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:self.name, @"group_name", nil];
        /*This is where we have a json string that can be sent over the interwebs*/
        NSDictionary *result = [self.server queryServerDomain:@"group" WithCommand:@"getMembers" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"success"] isEqualToString:@"1"]){
                NSArray *payload = [result objectForKey:@"payload"];
                [self.members removeAllObjects];
                for(NSDictionary *child in payload){
                    Friend *friend = [[Friend alloc] init];
                    friend.firstName = [child objectForKey:@"first_name"];
                    friend.lastName = [child objectForKey:@"last_name"];
                    friend.nickname = [child objectForKey:@"nickname"];
                    friend.email = [child objectForKey:@"email"];
                    [self.members addObject:friend];
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"GroupFetched" object:self];
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
    return self.members.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =@"GroupCell";
    MemberCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[MemberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    Friend *friend = [self.members objectAtIndex:indexPath.row];
    cell.textLabel.text = friend.nickname;
    return cell;
}

- (NSMutableArray *)members{
    if(!_members){
        _members = [[NSMutableArray alloc] init];
    }
    return _members;
}

@end
