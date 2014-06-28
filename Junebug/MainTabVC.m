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
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(goToMenu:)
     name:@"AppStateReady"
     object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(goToSignIn:)
     name:@"AppStateNotReady"
     object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(performUpdate:) name:@"Update" object:nil];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.appState getState];
}

- (void) goToMenu:(NSNotification*) notification{
    //Remove loading screen and spinner etc
}

- (void) goToSignIn:(NSNotification*) notification{
    [self performSegueWithIdentifier:@"MainToLogin" sender:self];
}

- (void) performUpdate: (NSNotification*) notification{
    NSDictionary *parameters = [notification.userInfo objectForKey:@"prm"];
    NSLog(@"%@", parameters);
   if([parameters objectForKey:@"freq"]){//Friend request
        NSString *parameterValue = [parameters objectForKey:@"freq"];
       NSLog(@"%@", parameterValue);
        UIViewController *target = [[self viewControllers] objectAtIndex: 2];
        if(target.isViewLoaded && target.view.window){
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate.appState.friends getPendingFriendRequests];
        }
        else{
            if([[target tabBarItem] badgeValue]){
                long currentBadgeValue = [[[target tabBarItem] badgeValue] integerValue];
                long newBadgeValue = currentBadgeValue + 1;
                NSString *badgeValue = [[NSString alloc] initWithFormat:@"%ld", newBadgeValue];
                [[target tabBarItem] setBadgeValue:badgeValue];
            }
            else{
                [[target tabBarItem] setBadgeValue:@"1"];
            }
        }
    }
}

@end
