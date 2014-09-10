//
//  BeckonAcceptDeclineViewController.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 05/09/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "BeckonAcceptDeclineViewController.h"
#import "BeckonDetailPageVC.h"

@interface BeckonAcceptDeclineViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@property (weak, nonatomic) IBOutlet UIButton *declineButton;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@end

@implementation BeckonAcceptDeclineViewController

- (IBAction)acceptButtonAction:(UIButton *)sender {
    BeckonDetailPageVC *parentVC = (BeckonDetailPageVC *)self.parentViewController;
    [parentVC.beckon acceptBeckon];
}

- (IBAction)declineButtonAction:(UIButton *)sender {
    BeckonDetailPageVC *parentVC = (BeckonDetailPageVC *)self.parentViewController;
    [parentVC.beckon rejectBeckon];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    BeckonDetailPageVC *parentVC = (BeckonDetailPageVC *)self.parentViewController;
    self.titleLabel.text = parentVC.beckon.title;
    self.descriptionLabel.text = parentVC.beckon.beckonDescription;
//    if([parentVC.beckon.status isEqualToString:@"ACCEPTED"]){
//        self.acceptButton.titleLabel.text = @"Accepted";
//    }
//    else if([parentVC.beckon.status isEqualToString:@"REJECTED"]){
//        self.acceptButton.titleLabel.text = @"Declined";
//    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
