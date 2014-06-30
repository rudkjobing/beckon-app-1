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
#import "FriendsVC.h"

@interface MainTabVC ()

@end

@implementation MainTabVC

- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(goToSignIn:)
     name:@"AppStateNotReady"
     object:nil];
}

- (void) viewDidAppear:(BOOL)animated{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.appState getState];
}

- (void) goToSignIn:(NSNotification*) notification{
    [self performSegueWithIdentifier:@"MainToLogin" sender:self];
}

@end
