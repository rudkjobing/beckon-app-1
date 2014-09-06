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
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@end

@implementation BeckonAcceptDeclineViewController

- (IBAction)acceptButtonAction:(UIButton *)sender {
    BeckonDetailPageVC *parentVC = [self parentViewController];
    [parentVC.beckon acceptBeckon];
}

- (IBAction)declineButtonAction:(UIButton *)sender {
    BeckonDetailPageVC *parentVC = [self parentViewController];
    [parentVC.beckon rejectBeckon];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
