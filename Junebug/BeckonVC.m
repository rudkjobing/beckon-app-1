//
//  BeckonVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "BeckonVC.h"
#import "AppDelegate.h"
#import "Beckon.h"
#import "Beckons.h"
#import "BeckonCell.h"

@interface BeckonVC ()
@property (weak, nonatomic) IBOutlet UITableView *beckonTableView;
@property (strong, nonatomic) Beckons *beckons;
@end

@implementation BeckonVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createBeckon)];
    self.navigationItem.rightBarButtonItem = addButton;
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(updateTableView:)
     name:@"ReloadBeckonTableView"
     object:nil];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.beckons = appDelegate.appState.beckons;
    self.beckonTableView.dataSource = self;
    self.beckonTableView.delegate = self;
}

- (void) viewWillAppear:(BOOL)animated{
    [[self tabBarItem] setBadgeValue: nil];
}

- (void) updateTableView: (NSNotification*) notification{
    [self.beckonTableView reloadData];
}

- (void)createBeckon{
    [self performSegueWithIdentifier:@"BeckonToCreate" sender:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.beckons.beckons.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =@"BeckonCell";
    BeckonCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[BeckonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    Beckon *beckon = [self.beckons.beckons objectAtIndex:indexPath.row];
    cell.textLabel.text = beckon.title;
    return cell;
}

@end
