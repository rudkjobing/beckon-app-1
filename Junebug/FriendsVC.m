
//
//  FriendsVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import "FriendsVC.h"
#import "Friends.h"
#import "AppDelegate.h"
#import "GradientLayers.h"
#import "FriendCell.h"

@interface FriendsVC()

@property NSString *requestEmail;
@property (strong, nonatomic) Friends *friends;
@property (weak, nonatomic) IBOutlet UITableView *friendsTableView;

@end

@implementation FriendsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*CAGradientLayer * bgLayer = [GradientLayers appBlueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];*/
    self.friendsTableView.backgroundColor = [UIColor clearColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView:) name:@"ReloadFriendTableView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentPendingFriendRequestsAlert:) name:@"PendingFriendRequests" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(FriendRequestAccepted:) name:@"FriendRequestAccepted" object:nil];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.friends = appDelegate.appState.friends;
    self.friendsTableView.dataSource = self;
    self.friendsTableView.delegate = self;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFriend)];
    addButton.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = addButton;
    
    [self.friendsTableView registerClass:[FriendCell class] forCellReuseIdentifier:@"FriendCell"];
}

-(void)viewWillAppear:(BOOL)animated{
    [[self tabBarItem] setBadgeValue: nil];
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) FriendRequestAccepted: (NSNotification*) notification{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.appState.friends getAllFriends];
}

- (void) updateTableView: (NSNotification*) notification{
    [self.friendsTableView reloadData];
}

- (void) presentPendingFriendRequestsAlert: (NSNotification*) notification{
    if (self.isViewLoaded && self.view.window) {
        NSDictionary *pendingRequests = [notification.userInfo objectForKey:@"payload"];
        NSEnumerator *requests = [pendingRequests objectEnumerator];
        NSDictionary *request = [requests nextObject];
        NSString *name = [[[request objectForKey:@"firstname"] stringByAppendingString:@" "] stringByAppendingString:[request objectForKey:@"lastname"]];
        self.requestEmail =[request objectForKey:@"email"];
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Friend request pending" message:[name stringByAppendingString:@" has invited you to be friends"] delegate:self   cancelButtonTitle:@"Accept" otherButtonTitles:@"Refuse", nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
    }
}

- (IBAction)addFriend{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Add a friend" message:@"Please enter your friend's email" delegate:self cancelButtonTitle:@"Add" otherButtonTitles:@"Cancel", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeEmailAddress;
    alertTextField.placeholder = @"Email address";
    [alert show];
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.friendsTableView setEditing:editing animated:animated];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if([[alertView title] isEqualToString:@"Add a friend"] && buttonIndex == 0){
        [appDelegate.appState.friends addFriend:[alertView textFieldAtIndex:0].text];
    }
    else if ([[alertView title] isEqualToString:@"Friend request pending"]){
        [appDelegate.appState.friends acceptFriendRequest:self.requestEmail];
    }
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
    cell.nameOfFriend.text = [[friend.firstName stringByAppendingString:@" "] stringByAppendingString:friend.lastName];
    cell.emailOfFriend.text = friend.email;
    cell.nickNameOfFriend.text = friend.nickname;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        Friend *friend = [self.friends.friends objectAtIndex:indexPath.row];
        [self.friends.friends removeObjectAtIndex:indexPath.row];
        [self.friends removeFriend:friend.email];//Change this to use ID instead, must be changed on server aswell
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    /*if([segue.identifier isEqualToString:@"FriendsToChat"]){
        FriendChatVC *detailVC = [segue destinationViewController];
        detailVC.hidesBottomBarWhenPushed = YES;
    }*/
}

@end
