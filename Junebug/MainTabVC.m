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
     name:@"UpdateFriendRequestsBadge"
     object:nil];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.appState.friends getPendingFriendRequests];

}

- (void) setFriendsBadge: (NSNotification*) notification{
    NSString *pendingReqeusts = [notification.userInfo objectForKey:@"badge"];
    if([pendingReqeusts isEqualToString:@"0"]){
        [[[[self viewControllers] objectAtIndex: 2] tabBarItem] setBadgeValue:nil];
    }
    else{
        [[[[self viewControllers] objectAtIndex: 2] tabBarItem] setBadgeValue:pendingReqeusts];
    }
}

@end
