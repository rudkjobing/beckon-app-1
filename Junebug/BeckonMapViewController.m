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

@end

@implementation BeckonMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BeckonDetailPageVC *parentVC = [self parentViewController];
    MKCoordinateRegion myPosition;
    myPosition.center.latitude = [parentVC.beckon.latitude doubleValue];
    myPosition.center.longitude = [parentVC.beckon.longitude doubleValue];
    myPosition.span.latitudeDelta = 0.008388;
    myPosition.span.longitudeDelta = 0.016243;
    [self.map setRegion:myPosition animated:NO];
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(myPosition.center.latitude, myPosition.center.longitude) addressDictionary:nil];
    [self.map addAnnotation:placemark];

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
