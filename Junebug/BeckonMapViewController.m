//
//  BeckonMapViewController.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 01/09/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import "BeckonMapViewController.h"
#import "BeckonDetailPageVC.h"
#import <CoreLocation/CoreLocation.h>

@interface BeckonMapViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@property (weak, nonatomic) IBOutlet UIButton *declineButton;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation BeckonMapViewController

MKCoordinateRegion currentRegion;
int locationRuns;

- (void)viewDidLoad {
    [super viewDidLoad];
    locationRuns                        = 0;
    BeckonDetailPageVC *parentVC        = (BeckonDetailPageVC *)self.parentViewController;
    self.titleLabel.text                = parentVC.beckon.title;
    self.locationLabel.text             = parentVC.beckon.locationString;
    currentRegion.center.latitude       = [parentVC.beckon.latitude doubleValue];
    currentRegion.center.longitude      = [parentVC.beckon.longitude doubleValue];
    currentRegion.span.latitudeDelta    = 0.008388 / 2;
    currentRegion.span.longitudeDelta   = 0.016243 / 2;
    [self.map setRegion:currentRegion animated:NO];
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(currentRegion.center.latitude, currentRegion.center.longitude) addressDictionary:nil];
    [self.map addAnnotation:placemark];
    
    
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager    =   [[CLLocationManager alloc] init];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
            [self.locationManager requestAlwaysAuthorization];
            [self.locationManager requestWhenInUseAuthorization];
        }
        self.locationManager.delegate   =   self;
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        //        [self.locationManager setDesiredAccuracy:kCLDistanceFilterNone];
        [self.locationManager startUpdatingLocation];
    }
    
    [self updateButtonState];
    
    //<3 = true
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    if(locationRuns < 6){
        for(CLLocation *location in locations){
            
            BeckonDetailPageVC *parentVC = (BeckonDetailPageVC *)self.parentViewController;
            MKCoordinateRegion mapRegion;

            mapRegion.center.latitude = (location.coordinate.latitude + [parentVC.beckon.latitude doubleValue]) / 2;
            mapRegion.span.latitudeDelta = fabs(location.coordinate.latitude - [parentVC.beckon.latitude doubleValue]) * 1.8;
            
            mapRegion.center.longitude = (location.coordinate.longitude + [parentVC.beckon.longitude doubleValue]) / 2;
            mapRegion.span.longitudeDelta = fabs(location.coordinate.longitude - [parentVC.beckon.longitude doubleValue]) * 1.3;
            
            MKCoordinateRegion beckonPosition;
            beckonPosition.center.latitude = [parentVC.beckon.latitude doubleValue];
            beckonPosition.center.longitude = [parentVC.beckon.longitude doubleValue];
            [self.map setRegion:mapRegion animated:YES];
            currentRegion = mapRegion;
            break;
        }
        locationRuns++;
    }
    else{
        [self.locationManager stopUpdatingLocation];
    }
}

- (IBAction)acceptButtonAction:(UIButton *)sender {
    [self.activityIndicator startAnimating];
    BeckonDetailPageVC *parentVC = (BeckonDetailPageVC *)self.parentViewController;
    [parentVC.beckon acceptBeckon];
}

- (IBAction)declineButtonAction:(UIButton *)sender {
    [self.activityIndicator startAnimating];
    BeckonDetailPageVC *parentVC = (BeckonDetailPageVC *)self.parentViewController;
    if([sender.titleLabel.text isEqualToString:@"Delete"]){
        [parentVC.beckon deleteBeckon];
    }
    else{
        [parentVC.beckon rejectBeckon];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self.activityIndicator stopAnimating];
    [self updateButtonState];
}

- (void) viewWillAppear:(BOOL)animated{
    BeckonDetailPageVC *parentVC = (BeckonDetailPageVC *)self.parentViewController;
    [parentVC.beckon addObserver:self forKeyPath:@"status" options:0 context:nil];
    [self.map setRegion:currentRegion animated:NO];
}

- (void) viewWillDisappear:(BOOL)animated{
    [self.activityIndicator stopAnimating];
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
        [self.declineButton setTitle:@"Delete" forState:UIControlStateNormal];
        [self.declineButton setAlpha:1.0];
        [self.declineButton setEnabled:YES];
        
        [self.acceptButton setTitle:@"Accept" forState:UIControlStateNormal];
        [self.acceptButton setAlpha:0.5];
        [self.acceptButton setEnabled:YES];
    }
    else if([parentVC.beckon.status isEqualToString:@"DELETED"]){
        BeckonDetailPageVC *parentVC = (BeckonDetailPageVC *)self.parentViewController;
        [parentVC dismissViewControllerAnimated:YES completion:nil];
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
