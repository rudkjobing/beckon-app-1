//
//  BeckonCreateVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "BeckonCreateVC.h"

@interface BeckonCreateVC ()
@property (weak, nonatomic) IBOutlet UITextField *beckonName;
@property (weak, nonatomic) IBOutlet UIDatePicker *beckonDate;
@property (weak, nonatomic) IBOutlet MKMapView *beckonLocation;
@end

@implementation BeckonCreateVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.beckon = [[Beckon alloc] init];
}

- (IBAction)FlushBeckon:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@ , %@", self.beckonName.text, self.beckonDate.date.description);
    for(Friend *f in self.beckon.friends){
        NSLog(@"%@", f);
    }
    self.beckon.title = self.beckonName.text;
    self.beckon.ends = self.beckonDate.date.description;
    [self.beckon flush];
}
- (IBAction)DiscardBeckon:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"BeckonCreateToFriends"]){
        BeckonPickFriendsVC *friendVC = [segue destinationViewController];
        friendVC.beckon = self.beckon;
    }
}

- (IBAction)EndEditing:(id)sender {
    [self resignFirstResponder];
}



@end
