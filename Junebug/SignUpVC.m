//
//  SignUpVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "SignUpVC.h"

@interface SignUpVC ()

@property (weak, nonatomic) IBOutlet UITextField *signUpFirstname;
@property (weak, nonatomic) IBOutlet UITextField *signUpSecondname;
@property (weak, nonatomic) IBOutlet UITextField *signUpEmail;
@property (weak, nonatomic) IBOutlet UITextField *signUpPassword;
@property (weak, nonatomic) IBOutlet UITextField *signUpConfirmedPassword;

@end

@implementation SignUpVC

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
- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}
- (IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
    
}
- (IBAction)signUpButtonTabbed:(id)sender {
    if ([self.signUpPassword.text isEqualToString:self.signUpConfirmedPassword.text]) {

    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password incorrect" message:@"passwords did not match" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void) signUpComplete{
    [self performSegueWithIdentifier:@"SignUpToTabbed" sender:self];
}

- (void) signUpFailedWithMessage: (NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Signup failed" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end
