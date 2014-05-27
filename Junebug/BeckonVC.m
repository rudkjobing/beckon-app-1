//
//  BeckonVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "BeckonVC.h"
#import "AppDelegate.h"

@interface BeckonVC ()
@property (weak, nonatomic) IBOutlet UITableView *beckonTableView;

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
     name:@"BeckonsFetched"
     object:nil];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.beckonTableView.dataSource = appDelegate.appState.beckons;
    self.beckonTableView.delegate = appDelegate.appState.beckons;
    [appDelegate.appState.beckons getAllBeckons];
}

- (void) viewWillAppear:(BOOL)animated{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.appState.beckons getAllBeckons];
}

- (void) updateTableView: (NSNotification*) notification{
    [self.beckonTableView reloadData];
}

- (void)createBeckon{
    [self performSegueWithIdentifier:@"BeckonToCreate" sender:self];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
