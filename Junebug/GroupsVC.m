//
//  GroupsVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "GroupsVC.h"
#import "AppDelegate.h"

@interface GroupsVC ()

@property (weak, nonatomic) IBOutlet UITableView *groupTableView;

@end

@implementation GroupsVC


- (IBAction)addGroup:(id)sender {

    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Add a group" message:@"Please enter a name for the group" delegate:self cancelButtonTitle:@"Add" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeEmailAddress;
    alertTextField.placeholder = @"Name";
    [alert show];

}

- (void)fetchGroups: (NSNotification*) notification{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.appState.groups getAllGroups];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(updateTableView:)
     name:@"GroupsFetched"
     object:nil];
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(fetchGroups:)
     name:@"GroupAdded"
     object:nil];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.groupTableView.dataSource = appDelegate.appState.groups;
    self.groupTableView.delegate = appDelegate.appState.groups;
    [appDelegate.appState.groups getAllGroups];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.appState.groups addGroup:[alertView textFieldAtIndex:0].text];
}

- (void) updateTableView: (NSNotification*) notification{
    
    [self.groupTableView reloadData];
}

@end
