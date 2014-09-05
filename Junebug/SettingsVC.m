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

@end

@implementation SettingsVC

- (IBAction)signOutAction:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.appState signOut];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *previousButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = previousButton;
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)signOutComplete {
    [self performSegueWithIdentifier:@"settingsToSignIn" sender:self];
}

@end
