//
//  GroupDetailVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import "GroupDetailVC.h"
#import "GroupEditMembersVC.h"
#import "FriendCell.h"
#import "GradientLayers.h"

@interface GroupDetailVC ()

@property (weak, nonatomic) IBOutlet UITableView *memberTableView;

@end

@implementation GroupDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(updateTableView:)
     name:@"GroupFetched"
     object:nil];
    /*CAGradientLayer * bgLayer = [GradientLayers appBlueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];*/
    self.memberTableView.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *manageButton = [[UIBarButtonItem alloc] initWithTitle:@"Manage" style:UIBarButtonItemStylePlain target:self action:@selector(manageGroup)];
    self.navigationItem.rightBarButtonItem = manageButton;
    self.memberTableView.dataSource = self;
    self.memberTableView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
    [self.group getGroupMembers];
}

- (void) updateTableView: (NSNotification*) notification{
    [self.memberTableView reloadData];
}

- (void) manageGroup{
    [self performSegueWithIdentifier:@"GroupMembersToEdit" sender:self];
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
    return self.group.members.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"FriendCell";
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[FriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    Friend *friend = [self.group.members objectAtIndex:indexPath.row];
    cell.nameOfFriend.text = [[friend.firstName stringByAppendingString:@" "] stringByAppendingString:friend.lastName];
    cell.emailOfFriend.text = friend.email;
    cell.nickNameOfFriend.text = friend.nickname;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"GroupMembersToEdit"]){
        GroupEditMembersVC *memberVC = [segue destinationViewController];
        memberVC.group = self.group;
        
    }
}

@end
