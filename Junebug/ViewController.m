//
//  ViewController.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 25/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "ViewController.h"
#import "SignInVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (User *) user{
    if(!_user){
        _user = [[User alloc]init];
        [_user setAuthenticationDelegate:self];
    }
    return _user;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults stringForKey:@"email"] && ![defaults stringForKey:@"device_key"] && ![defaults stringForKey:@"auth_key"]){
        [self performSegueWithIdentifier:@"EntryToSignIn" sender:self];
    }
    else{
        [self.user isAuthenticWithEmail:[defaults stringForKey:@"email"] andAuthKey:[defaults stringForKey:@"auth_key"] andDeviceKey:[defaults stringForKey:@"device_key"]];
    }
}

- (void) validUser{
    NSLog(@"valid");
    [self performSegueWithIdentifier:@"EntryToTabbed" sender:self];
}

- (void) invalidUser{
    NSLog(@"invalid");
    [self performSegueWithIdentifier:@"EntryToSignIn" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    /*if ([segue.identifier isEqualToString:@"EntryToSignIn"]) {
        TabViewController *destViewController = segue.destinationViewController;
        FriendViewController *friendViewcontroller=[destViewController.viewControllers objectAtIndex:0];
        friendViewcontroller.user = self.user;
    }*/
    if ([segue.identifier isEqualToString:@"EntryToSignIn"]) {
        UINavigationController *navController = segue.destinationViewController;
        SignInVC *destController = [navController.viewControllers objectAtIndex:0];
        destController.user = self.user;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
