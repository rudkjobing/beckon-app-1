//
//  GroupsVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "GroupsVC.h"
#import "GroupDetailVC.h"
#import "AppDelegate.h"

@interface GroupsVC ()

@property (weak, nonatomic) IBOutlet UITableView *groupTableView;

@end

@implementation GroupsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(updateTableView:)
     name:@"GroupsFetched"
     object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(fetchGroups:)
     name:@"GroupAdded"
     object:nil];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.groupTableView.dataSource = appDelegate.appState.groups;
    self.groupTableView.delegate = appDelegate.appState.groups;
    [appDelegate.appState.groups getAllGroups];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGroup)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void) updateTableView: (NSNotification*) notification{
    [self.groupTableView reloadData];
}

- (IBAction)addGroup {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Add a group" message:@"Please enter a name for the group" delegate:self cancelButtonTitle:@"Add" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeEmailAddress;
    alertTextField.placeholder = @"Name";
    [alert show];
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.groupTableView setEditing:editing animated:animated];
}

- (void)fetchGroups: (NSNotification*) notification{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.appState.groups getAllGroups];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.appState.groups addGroup:[alertView textFieldAtIndex:0].text];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"GroupsToMembers"]){
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSIndexPath *index = [self.groupTableView indexPathForSelectedRow];
        GroupDetailVC *detailVC = [segue destinationViewController];
        detailVC.group = [appDelegate.appState.groups.groups objectAtIndex:index.row];
    }
}

//Methods for detail view



@end
