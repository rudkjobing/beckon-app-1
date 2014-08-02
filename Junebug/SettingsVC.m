//
//  SettingsVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "SettingsVC.h"
#import "AppDelegate.h"
#import "AppState.h"
#import "GradientLayers.h"

@interface SettingsVC ()

@property (weak, nonatomic) IBOutlet UIButton *signOutButton;

@end

@implementation SettingsVC

- (IBAction)signOutAction:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.appState signOut];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(signOutComplete)
     name:@"UserSignOutSuccess"
     object:nil];
    CAGradientLayer * bgLayer = [GradientLayers appBlueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
}

- (IBAction)signOutComplete {
    [self performSegueWithIdentifier:@"settingsToSignIn" sender:self];
}

@end
