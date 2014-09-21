//
//  BeckonCreateVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import "BeckonCreateVC.h"
#import "GradientLayers.h"
#import "BeckonCreatNavigationVC.h"
#import "Beckon.h"
#import "BeckonPickFriendsVC.h"

@interface BeckonCreateVC ()

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UITextField *beckonDescription;
@property (weak, nonatomic) IBOutlet UITextField *beckonTitle;
@property (strong, nonatomic) Beckon* beckon;

@end

@implementation BeckonCreateVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *previousButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(previousStep)];
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextStep)];
    previousButton.tintColor = [UIColor blackColor];
    nextButton.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = previousButton;
    self.navigationItem.rightBarButtonItem = nextButton;
    self.progressView.progress = 0.25;
    self.beckon = [[Beckon alloc] init];
    [self.beckonTitle becomeFirstResponder];
}

- (void)nextStep{
    self.beckon.title = self.beckonTitle.text;
    self.beckon.beckonDescription = self.beckonDescription.text;
    [self performSegueWithIdentifier:@"selectFriends" sender:self];
}

- (void)previousStep{
    [self.beckonTitle resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)DiscardBeckon:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)EndEditing:(id)sender {
    [self resignFirstResponder];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"selectFriends"]){
        BeckonPickFriendsVC *targetVC = [segue destinationViewController];
        targetVC.beckon = self.beckon;
    }
}

- (Beckon *) _beckon{
    if(!_beckon){
        _beckon = [[Beckon alloc] init];
    }
    return _beckon;
}


@end
