//
//  BeckonAddMembersViewController.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 03/10/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "Friend.h"
#import "FriendCell.h"
#import "BeckonAddMembersViewController.h"
#import "AppDelegate.h"
#import "BeckonMember.h"
#import "User.h"

@interface BeckonAddMembersViewController ()

@property (weak, nonatomic) IBOutlet UITableView *memberTableView;
@property (strong, nonatomic) NSMutableArray *eligibleFriends;
@property (strong, nonatomic) NSMutableArray *friendsToAdd;
@property (strong, nonatomic) NSMutableArray *allFriends;

@end

@implementation BeckonAddMembersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.memberTableView registerClass:[FriendCell class] forCellReuseIdentifier:@"FriendCell"];
    
    UIBarButtonItem *previousButton         =   [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
    UIBarButtonItem *nextButton             =   [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneAction)];
    previousButton.tintColor                =   [UIColor blackColor];
    nextButton.tintColor                    =   [UIColor blackColor];
    self.navigationItem.leftBarButtonItem   =   previousButton;
    self.navigationItem.rightBarButtonItem  =   nextButton;
    AppDelegate *appDelegate                =   (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.allFriends                         =   appDelegate.appState.friends.friends;
    self.eligibleFriends                    =   [appDelegate.appState.friends.friends mutableCopy];
    self.friendsToAdd                       =   [[NSMutableArray alloc] init];
    self.memberTableView.dataSource         =   self;
    self.memberTableView.delegate           =   self;
    
    if(self.beckon){
        for(Friend *frnd in self.allFriends){
            for(BeckonMember *mbr in self.beckon.members){
                if([frnd.user.id intValue] == [mbr.user.id intValue]){
                    [self.eligibleFriends removeObject:frnd];
                    break;
                }
            }
        }
        [self.memberTableView reloadData];
    }
    

}

- (void)cancelAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doneAction{
    if(self.friendsToAdd.count > 0){
        [self.beckon addBeckonMembers:self.friendsToAdd withCallback:^void(){
            [self cancelAction];
        }];
    }
    else{
        [self cancelAction];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *cellIdentifier = @"FriendCell";
        FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[FriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        Friend *friend              =   [self.eligibleFriends objectAtIndex:indexPath.row];
        cell.nameOfFriend.text      =   [[friend.firstName stringByAppendingString:@" "] stringByAppendingString:friend.lastName];
        cell.emailOfFriend.text     =   friend.email;
        cell.nickNameOfFriend.text  =   friend.nickname;
        
        if([self.friendsToAdd containsObject:friend.id]){
            [cell setActivated];
        }
        return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        FriendCell *cell    =   (FriendCell *)[tableView cellForRowAtIndexPath:indexPath];
        Friend *friend      =   [self.eligibleFriends objectAtIndex:indexPath.row];
        
        if(cell.isActivated){
            [cell setDeactivated];
            [self.friendsToAdd removeObject:friend.id];
        }
        else{
            [cell setActivated];
            [self.friendsToAdd addObject:friend.id];
        }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.eligibleFriends.count;
}

@end
