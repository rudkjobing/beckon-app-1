
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

@implementation FriendsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(updateTableView:)
     name:@"FriendsFetched"
     object:nil];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.appState.friends getAllFriends];
    self.friendsTableView.dataSource = appDelegate.appState.friends;
    self.friendsTableView.delegate = appDelegate.appState.friends;
   
}

- (void) updateTableView: (NSNotification*) notification{

    [self.friendsTableView reloadData];
}

- (IBAction)addFriend:(UIButton *)sender {
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Add a friend" message:@"Please enter your friend's email" delegate:self cancelButtonTitle:@"Add" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeEmailAddress;
    alertTextField.placeholder = @"Email address";
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.appState.friends addFriend:[alertView textFieldAtIndex:0].text];
}

@end
