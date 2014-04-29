//
//  SignInVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "SignInVC.h"

@interface SignInVC ()
@property (weak, nonatomic) IBOutlet UITextField *singInEmail;
@property (weak, nonatomic) IBOutlet UITextField *signInPassword;


@end

@implementation SignInVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)signUpPressed:(id)sender {

    [self performSegueWithIdentifier:@"SignInToSignUp" sender:self];
}
- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}
- (IBAction)signInTabbed:(id)sender {
    if ([self.singInEmail.text isEqualToString:@""] || [self.signInPassword.text isEqualToString:@""]) {
        UIAlertView *noMailorPassword = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Failed to log in due to missing Password or Email" delegate:self cancelButtonTitle:@"Try again" otherButtonTitles: nil];
        [noMailorPassword show]; 
        
    }else{
    [self performSegueWithIdentifier:@"SignInToTabbed" sender:self]; 
    }
    }

@end
