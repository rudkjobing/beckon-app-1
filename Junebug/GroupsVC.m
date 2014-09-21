//
//  GroupsVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import "GroupsVC.h"
#import "Group.h"
#import "GroupDetailVC.h"
#import "AppDelegate.h"
#import "GroupCell.h"
#import "Friend.h"
#import "GradientLayers.h"

@interface GroupsVC ()

@property (weak, nonatomic) IBOutlet UITableView *groupTableView;
@property (strong, nonatomic) Groups *groups;

@end

@implementation GroupsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    CAGradientLayer * bgLayer = [GradientLayers appBlueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    self.groupTableView.backgroundColor = [UIColor clearColor];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.groups = appDelegate.appState.groups;
    self.groupTableView.dataSource = self;
    self.groupTableView.delegate = self;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGroup)];
    self.navigationItem.rightBarButtonItem = addButton;
    [self.groups addObserver:self forKeyPath:@"newestGroupPointer" options:0 context:nil];
}

- (void) updateTableView: (NSNotification*) notification{
    [self.groupTableView reloadData];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self.groupTableView reloadData];
}

- (IBAction)addGroup {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Add a group" message:@"Please enter a name for the group" delegate:self cancelButtonTitle:@"Add" otherButtonTitles:@"Cancel", nil];
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        Group *group = [[Group alloc] init];
        group.name = [alertView textFieldAtIndex:0].text;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        group.server = appDelegate.appState.server;
        [group flush];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groups.groups.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =@"GroupCell";
    GroupCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[GroupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    Group *group = [self.groups.groups objectAtIndex:indexPath.row];
    cell.textLabel.text = group.name;
    return cell;
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        Group *group = [self.groups.groups objectAtIndex:indexPath.row];
        [group delete];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"GroupsToMembers"]){
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSIndexPath *index = [self.groupTableView indexPathForSelectedRow];
        GroupDetailVC *detailVC = [segue destinationViewController];
        detailVC.group = [appDelegate.appState.groups.groups objectAtIndex:index.row];
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.groupTableView deselectRowAtIndexPath:index animated:NO];
        
    }
}

//Methods for detail view



@end
