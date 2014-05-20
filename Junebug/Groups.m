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
        NSDictionary *result = [self.server queryServerDomain:@"group" WithCommand:@"getAll" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"success"] isEqualToString:@"1"]){
                NSArray *payload = [result objectForKey:@"payload"];
                [self.groups removeAllObjects];
                for(NSDictionary *child in payload){
                    Group *group = [[Group alloc] init];
                    group.name = [child objectForKey:@"name"];
                    group.server = self.server;
                    [self.groups addObject: group];
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"GroupsFetched" object:self];
            }
            else{
                
            }
        });
    });
}

- (void) addGroup:(NSString *)name{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:name, @"group_name", nil];
        /*This is where we have a json string that can be sent over the interwebs*/
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

- (void) removeGroup:(NSString *)name{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:name, @"group_name", nil];
        /*This is where we have a json string that can be sent over the interwebs*/
        NSDictionary *result = [self.server queryServerDomain:@"group" WithCommand:@"remove" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"success"] isEqualToString:@"1"]){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"GroupRemoved" object:self];
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
    return self.groups.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =@"GroupCell";
    GroupCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[GroupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    Group *group = [self.groups objectAtIndex:indexPath.row];
    cell.textLabel.text = group.name;
    return cell;
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        Group *group = [self.groups objectAtIndex:indexPath.row];
        [self.groups removeObjectAtIndex:indexPath.row];
        [self removeGroup:group.name];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

- (NSMutableArray *)groups{
    if(!_groups){
        _groups = [[NSMutableArray alloc] init];
    }
    return _groups;
}


@end
