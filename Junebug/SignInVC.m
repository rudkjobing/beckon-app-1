//
//  SignInVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import "SignInVC.h"
#import "SignUpVC.h"
#import "AppDelegate.h"

@interface SignInVC ()
@property (weak, nonatomic) IBOutlet UITextField *singInEmail;
@property (weak, nonatomic) IBOutlet UITextField *signInPassword;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;


@end

@implementation SignInVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    //custom buttons and textfields
//    self.singInEmail.textColor = [UIColor blackColor];
//    self.signInPassword.textColor = [UIColor blackColor];
//    
//    self.signInButton.backgroundColor = [UIColor clearColor];
//    self.signInButton.tintColor = [UIColor whiteColor];
//    self.signInButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
//    self.signInButton.titleLabel.textAlignment = UIControlContentHorizontalAlignmentLeft;
//    
//    self.signUpButton.backgroundColor = [UIColor clearColor];
//    self.signUpButton.tintColor = [UIColor whiteColor];
//    self.signUpButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
//    self.signUpButton.titleLabel.textAlignment = UIControlContentHorizontalAlignmentLeft;

    
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(goToMenu:)
     name:@"SignInSuccess"
     object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(loginFailed:)
     name:@"SignInFailure"
     object:nil];
    // Do any additional setup after loading the view.
}

- (void) goToMenu:(NSNotification*) notification{
    UIApplication *application = [UIApplication sharedApplication];
    UIRemoteNotificationType noteficationTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound;
    [application registerForRemoteNotificationTypes:noteficationTypes];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.appState getState];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) loginFailed:(NSNotification*) notification{
    UIAlertView *noMailorPassword = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:[notification.userInfo objectForKey:@"message"] delegate:self cancelButtonTitle:@"Try again" otherButtonTitles: nil];
    [noMailorPassword show];
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
        [appDelegate.appState signInUsingEmail:self.singInEmail.text AndPassword:self.signInPassword.text];
    }
}



@end
