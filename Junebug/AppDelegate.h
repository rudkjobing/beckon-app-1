//
//  AppDelegate.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 25/04/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppState.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AppState *appState;

@end
