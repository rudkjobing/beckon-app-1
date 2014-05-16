//
//  SignInVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "SignInVC.h"
#import "SignUpVC.h"
#import "AppDelegate.h"

@interface SignInVC ()
@property (weak, nonatomic) IBOutlet UITextField *singInEmail;
@property (weak, nonatomic) IBOutlet UITextField *signInPassword;


@end

@implementation SignInVC

- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(goToMenu:)
     name:@"AppState_Ready"
     object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(loginFailed:)
     name:@"AppState_NotReady"
     object:nil];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) goToMenu:(NSNotification*) notification{
    [self performSegueWithIdentifier:@"SignInToTabbed" sender:self];
}

- (void) loginFailed:(NSNotification*) notification{
    UIAlertView *noMailorPassword = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:[notification.userInfo objectForKey:@"message"] delegate:self cancelButtonTitle:@"Try again" otherButtonTitles: nil];
    [noMailorPassword show];
}

- (IBAction)signUpPressed:(id)sender {
    [self performSegueWithIdentifier:@"SignInToSignUp" sender:self];
}
- (IBAction)textFieldReturn:(id)sender{
    [self resignFirstResponder];
}
- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}
- (IBAction)signInTabbed:(id)sender {
    if ([self.singInEmail.text isEqualToString:@""] || [self.signInPassword.text isEqualToString:@""]) {
        UIAlertView *noMailorPassword = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Failed to log in due to missing Password or Email" delegate:self cancelButtonTitle:@"Try again" otherButtonTitles: nil];
        [noMailorPassword show]; 
        
    }
    else{
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.appState registerDeviceUsingEmail:self.singInEmail.text AndPassword:self.signInPassword.text];
    }
}



@end
