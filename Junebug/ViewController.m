//
//  ViewController.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 25/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Yay");
    	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [self performSegueWithIdentifier:@"EntryToSignIn" sender:self];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
