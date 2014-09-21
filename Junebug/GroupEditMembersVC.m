//
//  GroupEditMembersVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 19/05/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import "GroupEditMembersVC.h"
#import "FriendCell.h"
#import "Friend.h"
#import "AppDelegate.h"
#import "GradientLayers.h"

@interface GroupEditMembersVC ()

@property (weak, nonatomic) IBOutlet UITableView *memberTableView;

@end

@implementation GroupEditMembersVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*CAGradientLayer * bgLayer = [GradientLayers appBlueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];*/
    self.memberTableView.backgroundColor = [UIColor clearColor];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.friends = appDelegate.appState.friends;
    self.memberTableView.dataSource = self;
    self.memberTableView.delegate = self;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameOfFriend.text = [[friend.firstName stringByAppendingString:@" "] stringByAppendingString:friend.lastName];
    cell.emailOfFriend.text = friend.email;
    cell.nickNameOfFriend.text = friend.nickname;
    cell.pictureOfFriend.image = [UIImage imageNamed:@"squirrel.jpg"];
    if([self.group.members containsObject:[self.friends.friends objectAtIndex:indexPath.row]]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    Friend *friend = [self.friends.friends objectAtIndex:indexPath.row];
    if(cell.accessoryType == UITableViewCellAccessoryCheckmark){
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.group removeMember:friend.id];
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.group addMember:friend.id];
    }
}


@end
