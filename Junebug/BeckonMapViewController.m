//
//  BeckonMapViewController.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 01/09/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "BeckonMapViewController.h"
#import "BeckonDetailPageVC.h"

@interface BeckonMapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@property (weak, nonatomic) IBOutlet UIButton *declineButton;

@end

@implementation BeckonMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BeckonDetailPageVC *parentVC = (BeckonDetailPageVC *)self.parentViewController;
    self.titleLabel.text = parentVC.beckon.title;
    MKCoordinateRegion myPosition;
    myPosition.center.latitude = [parentVC.beckon.latitude doubleValue];
    myPosition.center.longitude = [parentVC.beckon.longitude doubleValue];
    myPosition.span.latitudeDelta = 0.008388 / 2;
    myPosition.span.longitudeDelta = 0.016243 / 2;
    [self.map setRegion:myPosition animated:NO];
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(myPosition.center.latitude, myPosition.center.longitude) addressDictionary:nil];
    [self.map addAnnotation:placemark];
    [parentVC.beckon addObserver:self forKeyPath:@"status" options:0 context:nil];
    [self updateButtonState];
    //<3 = true
}

- (IBAction)acceptButtonAction:(UIButton *)sender {
    BeckonDetailPageVC *parentVC = (BeckonDetailPageVC *)self.parentViewController;
    [parentVC.beckon acceptBeckon];
}

- (IBAction)declineButtonAction:(UIButton *)sender {
    BeckonDetailPageVC *parentVC = (BeckonDetailPageVC *)self.parentViewController;
    [parentVC.beckon rejectBeckon];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self updateButtonState];
}

- (void) viewWillDisappear:(BOOL)animated{
    BeckonDetailPageVC *parentVC = (BeckonDetailPageVC *)self.parentViewController;
    [parentVC.beckon removeObserver:self forKeyPath:@"status"];
}

- (void)updateButtonState {
    BeckonDetailPageVC *parentVC = (BeckonDetailPageVC *)self.parentViewController;
    if([parentVC.beckon.status isEqualToString:@"ACCEPTED"]){
        [self.acceptButton setTitle:@"Accepted" forState:UIControlStateNormal];
        [self.acceptButton setAlpha:1.0];
        [self.acceptButton setEnabled:NO];
        
        [self.declineButton setTitle:@"Decline" forState:UIControlStateNormal];
        [self.declineButton setAlpha:0.5];
        [self.declineButton setEnabled:YES];
    }
    else if ([parentVC.beckon.status isEqualToString:@"REJECTED"]){
        [self.declineButton setTitle:@"Declined" forState:UIControlStateNormal];
        [self.declineButton setAlpha:1.0];
        [self.declineButton setEnabled:NO];
        
        [self.acceptButton setTitle:@"Accept" forState:UIControlStateNormal];
        [self.acceptButton setAlpha:0.5];
        [self.acceptButton setEnabled:YES];
    }
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
