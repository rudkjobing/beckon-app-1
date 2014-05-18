//
//  MainTabVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 18/05/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "MainTabVC.h"
#import "AppDelegate.h"
#import "Friends.h"

@interface MainTabVC ()

@end

@implementation MainTabVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(setFriendsBadge:)
     name:@"PendingFriendRequests"
     object:nil];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.appState.friends getPendingFriendRequests];

}

- (void) setFriendsBadge: (NSNotification*) notification{
    NSDictionary *pendingReqeusts = [notification.userInfo objectForKey:@"payload"];
    NSUInteger cnt = pendingReqeusts.count;
    NSLog(@"%u", cnt);
    [[[[self viewControllers] objectAtIndex: 2] tabBarItem] setBadgeValue:[[NSString alloc] initWithFormat:@"%u", cnt]];
}

@end
