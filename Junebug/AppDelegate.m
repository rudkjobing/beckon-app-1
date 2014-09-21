//
//  AppDelegate.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 25/04/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import "Convertions.h"
#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    application.applicationIconBadgeNumber = 0;
    _appState = [[AppState alloc] init];
    // Override point for customization after application launch.
    
    //Change tab bar color to transluscent
    //[[UITabBar appearance] setBarTintColor:[UIColor clearColor]];
    
    
    return YES;
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.appState.token = token;
    NSLog(@"%@", token);
    [self.appState updateNotificationToken];
}

- (void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    self.appState.token = @"";
    [self.appState updateNotificationToken];
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    application.applicationIconBadgeNumber = 0;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
        [self.appState handleNotification:userInfo];
    } else {
        NSLog(@"Offline Message recieved");
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    for(Beckon *beckon in self.appState.beckons.beckons){
        if([[[[NSDate alloc] init]dateByAddingTimeInterval: + 60*60] laterDate:beckon.begins] == beckon.begins){
            UILocalNotification *notification15 = [[UILocalNotification alloc] init];
            notification15.fireDate = [beckon.begins dateByAddingTimeInterval:-60*60];
            notification15.alertBody = [@"1 Hour: " stringByAppendingString:beckon.title];
            [[UIApplication sharedApplication] scheduleLocalNotification:notification15];
        }
        if([beckon.begins laterDate:[[NSDate alloc] init]] == beckon.begins){
            UILocalNotification *notificationNow = [[UILocalNotification alloc] init];
            notificationNow.fireDate = beckon.begins;
            notificationNow.alertBody = [@"Now: " stringByAppendingString:beckon.title];
            [[UIApplication sharedApplication] scheduleLocalNotification:notificationNow];
        }
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
//REMOVE THIS ON PRODUCTION
@implementation NSURLRequest(DataController)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}
@end
