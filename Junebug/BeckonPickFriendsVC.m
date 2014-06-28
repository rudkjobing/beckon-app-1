//
//  BeckonPickFriendsVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/05/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "BeckonPickFriendsVC.h"

@interface BeckonPickFriendsVC ()

@property (weak, nonatomic) IBOutlet UITableView *beckonFriendsTable;

@end

@implementation BeckonPickFriendsVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.friends = appDelegate.appState.friends;
    self.beckonFriendsTable.delegate = self;
    self.beckonFriendsTable.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.friends.friends.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"FriendCell";
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[FriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    Friend *friend = [self.friends.friends objectAtIndex:indexPath.row];
    cell.textLabel.text = friend.nickname;
    if([self.beckon.friends containsObject:[self.friends.friends objectAtIndex:indexPath.row]]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    Friend *friend = [self.friends.friends objectAtIndex:indexPath.row];
    if(cell.accessoryType == UITableViewCellAccessoryCheckmark){
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.beckon.friends removeObject:friend.id];
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.beckon.friends addObject:friend.id];
    }
}

@end
