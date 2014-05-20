//
//  GroupDetailVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "GroupDetailVC.h"

@interface GroupDetailVC ()

@property (weak, nonatomic) IBOutlet UITableView *memberTableView;

@end

@implementation GroupDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"LOADED MEMBERS");
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(updateTableView:)
     name:@"GroupFetched"
     object:nil];
    if(self.group){
        self.memberTableView.dataSource = self.group;
        self.memberTableView.delegate = self.group;
        [self.group getGroupMembers];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    
}

- (void) updateTableView: (NSNotification*) notification{
    [self.memberTableView reloadData];
}

@end
