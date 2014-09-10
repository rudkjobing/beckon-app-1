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
    myPosition.span.latitudeDelta = 0.008388;
    myPosition.span.longitudeDelta = 0.016243;
    [self.map setRegion:myPosition animated:NO];
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(myPosition.center.latitude, myPosition.center.longitude) addressDictionary:nil];
    [self.map addAnnotation:placemark];

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
