//
//  ViewController.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 25/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated{
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
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.appState applicationReady];
}

- (void) goToMenu:(NSNotification*) notification{
    [self performSegueWithIdentifier:@"EntryToTabbed" sender:self];
}

- (void) goToSignIn:(NSNotification*) notification{
    [self performSegueWithIdentifier:@"EntryToSignIn" sender:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]
     removeObserver:self];
}

@end
