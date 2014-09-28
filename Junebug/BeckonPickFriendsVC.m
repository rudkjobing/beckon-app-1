//
//  BeckonPickFriendsVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/05/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import "BeckonPickFriendsVC.h"
#import "GradientLayers.h"
#import "BeckonPickLocationVC.h"

@interface BeckonPickFriendsVC ()

@property (weak, nonatomic) IBOutlet UITableView *beckonFriendsTable;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation BeckonPickFriendsVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.beckonFriendsTable registerClass:[FriendCell class] forCellReuseIdentifier:@"FriendCell"];

    self.beckonFriendsTable.backgroundColor =   [UIColor clearColor];
    UIBarButtonItem *previousButton         =   [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(previousStep)];
    UIBarButtonItem *nextButton             =   [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextStep)];
    previousButton.tintColor                =   [UIColor blackColor];
    nextButton.tintColor                    =   [UIColor blackColor];
    self.navigationItem.leftBarButtonItem   =   previousButton;
    self.navigationItem.rightBarButtonItem  =   nextButton;
    AppDelegate *appDelegate                =   (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.friends                            =   appDelegate.appState.friends;
    self.beckonFriendsTable.delegate        =   self;
    self.beckonFriendsTable.dataSource      =   self;
    self.progressView.progress              =   0.50;
}

- (void) viewDidAppear:(BOOL)animated{
    [self.beckonFriendsTable reloadData];
}

- (void)nextStep{
    [self performSegueWithIdentifier:@"selectLocation" sender:self];
}

- (void)previousStep{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
    Friend *friend              =   [self.friends.friends objectAtIndex:indexPath.row];
    cell.nameOfFriend.text      =   [[friend.firstName stringByAppendingString:@" "] stringByAppendingString:friend.lastName];
    cell.emailOfFriend.text     =   friend.email;
    cell.nickNameOfFriend.text  =   friend.nickname;
    
    if([self.beckon.friends containsObject:friend.id]){
        [cell setActivated];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendCell *cell    =   (FriendCell *)[tableView cellForRowAtIndexPath:indexPath];
    Friend *friend      =   [self.friends.friends objectAtIndex:indexPath.row];

    if(cell.isActivated){
        [cell setDeactivated];
        [self.beckon.friends removeObject:friend.id];
    }
    else{
        [cell setActivated];
        [self.beckon.friends addObject:friend.id];
    }
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"selectLocation"]){
        BeckonPickFriendsVC *targetVC   =   [segue destinationViewController];
        targetVC.beckon                 =   self.beckon;
    }
}

- (Beckon *) _beckon{
    if(!_beckon){
        _beckon = [[Beckon alloc] init];
    }
    return _beckon;
}

@end
