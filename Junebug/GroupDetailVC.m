//
//  GroupDetailVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "GroupDetailVC.h"
#import "GroupEditMembersVC.h"
#import "MemberCell.h"

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
    UIBarButtonItem *manageButton = [[UIBarButtonItem alloc] initWithTitle:@"Manage" style:UIBarButtonItemStyleBordered target:self action:@selector(manageGroup)];
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
    return 55;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.group.members.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =@"GroupCell";
    MemberCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[MemberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    Friend *friend = [self.group.members objectAtIndex:indexPath.row];
    cell.textLabel.text = friend.nickname;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"GroupMembersToEdit"]){
        GroupEditMembersVC *memberVC = [segue destinationViewController];
        memberVC.group = self.group;
    }
}

@end
