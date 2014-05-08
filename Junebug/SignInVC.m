//
//  SignInVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "SignInVC.h"
#import "SignUpVC.h"

@interface SignInVC ()
@property (weak, nonatomic) IBOutlet UITextField *singInEmail;
@property (weak, nonatomic) IBOutlet UITextField *signInPassword;


@end

@implementation SignInVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) userValidated{
    [self performSegueWithIdentifier:@"SignInToTabbed" sender:self];
}

- (void) userFailedValidationWithMessage:(NSString *)message{
    UIAlertView *noMailorPassword = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:message delegate:self cancelButtonTitle:@"Try again" otherButtonTitles: nil];
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
        [self.user setSignInDelegate:self];
        [self.user loginWithEmail:self.singInEmail.text andPassword:self.signInPassword.text];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    /*if ([segue.identifier isEqualToString:@"EntryToSignIn"]) {
     TabViewController *destViewController = segue.destinationViewController;
     FriendViewController *friendViewcontroller=[destViewController.viewControllers objectAtIndex:0];
     friendViewcontroller.user = self.user;
     }*/
    if ([segue.identifier isEqualToString:@"SignInToSignUp"]) {
        SignUpVC *destController = segue.destinationViewController;
        destController.user = self.user;
    }
}

@end
