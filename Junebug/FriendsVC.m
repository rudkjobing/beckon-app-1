
//
//  FriendsVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "FriendsVC.h"
#import "Friends.h"
#import "AppDelegate.h"

@interface FriendsVC()

@property NSString *requestEmail;

@end

@implementation FriendsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(updateTableView:)
     name:@"FriendsFetched"
     object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(presentPendingFriendRequestsAlert:)
     name:@"PendingFriendRequests"
     object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(FriendRequestAccepted:)
     name:@"FriendRequestAccepted"
     object:nil];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.appState.friends getAllFriends];
    self.friendsTableView.dataSource = appDelegate.appState.friends;
    self.friendsTableView.delegate = appDelegate.appState.friends;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFriend)];
    self.navigationItem.rightBarButtonItem = addButton;
}

-(void)viewDidAppear:(BOOL)animated{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.appState.friends getPendingFriendRequests];
}

- (void) FriendRequestAccepted: (NSNotification*) notification{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.appState.friends getAllFriends];
    [appDelegate.appState.friends getPendingFriendRequests];
}

- (void) updateTableView: (NSNotification*) notification{
    [self.friendsTableView reloadData];
}

- (void) presentPendingFriendRequestsAlert: (NSNotification*) notification{
    NSDictionary *pendingRequests = [notification.userInfo objectForKey:@"payload"];
    NSEnumerator *requests = [pendingRequests objectEnumerator];
    NSDictionary *request = [requests nextObject];
    NSString *name = [[[request objectForKey:@"firstname"] stringByAppendingString:@" "] stringByAppendingString:[request objectForKey:@"lastname"]];
    self.requestEmail =[request objectForKey:@"email"];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Friend request pending" message:[name stringByAppendingString:@" has invited you to be friends"] delegate:self cancelButtonTitle:@"Accept" otherButtonTitles:@"Refuse", nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];
}

- (IBAction)addFriend{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Add a friend" message:@"Please enter your friend's email" delegate:self cancelButtonTitle:@"Add" otherButtonTitles:nil];
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
    if([[alertView title] isEqualToString:@"Add a friend"]){
        [appDelegate.appState.friends addFriend:[alertView textFieldAtIndex:0].text];
    }
    else if ([[alertView title] isEqualToString:@"Friend request pending"]){
        [appDelegate.appState.friends acceptFriendRequest:self.requestEmail];
    }
}

@end
