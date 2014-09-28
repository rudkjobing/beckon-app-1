//
//  SignUpVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import "SignUpVC.h"
#import "AppDelegate.h"
#import "GradientLayers.h"

@interface SignUpVC ()

@property (weak, nonatomic) IBOutlet UITextField *signUpFirstname;
@property (weak, nonatomic) IBOutlet UITextField *signUpSecondname;
@property (weak, nonatomic) IBOutlet UITextField *signUpEmail;
@property (weak, nonatomic) IBOutlet UITextField *signUpPassword;
@property (weak, nonatomic) IBOutlet UITextField *signUpConfirmedPassword;

@property (weak, nonatomic) IBOutlet UIButton *signUpButton;


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
    //added backgroundLayer
   
    self.title = @"Sign up for Beckon";
    
    //customize signupFirstName textfield
    self.signUpFirstname.textColor = [UIColor blackColor];
    self.signUpFirstname.font = [UIFont systemFontOfSize:14];
    
    //Customize signUpsecondName textfield
    self.signUpSecondname.textColor = [UIColor blackColor];
    
    //Customize signUpEmail textfield
    self.signUpEmail.textColor = [UIColor blackColor];
    
    //customize signupPassword textField
    self.signUpPassword.textColor = [UIColor blackColor];
    
    //Customize signUpConfirmedPassword textfield
    self.signUpConfirmedPassword.textColor = [UIColor blackColor];
    
    
    //Customize SignupButton
    self.signUpButton.backgroundColor = [UIColor clearColor];
    self.signUpButton.tintColor = [UIColor whiteColor];
    self.signUpButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.signUpButton.titleLabel.textAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(signUpComplete)
     name:@"UserSignedUp"
     object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(switchScene)
     name:@"AppStateReady"
     object:nil];
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
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.appState signUpWithEmail:self.signUpEmail.text Password:self.signUpPassword.text Firstname:self.signUpFirstname.text Lastname:self.signUpSecondname.text];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password incorrect" message:@"passwords did not match" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void) signUpComplete{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.appState signInUsingEmail:self.signUpEmail.text AndPassword:self.signUpPassword.text];
}

- (void) switchScene{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) signUpFailedWithMessage: (NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Signup failed" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end
