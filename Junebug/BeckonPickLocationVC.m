//
//  BeckonPickLocationVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 02/08/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "BeckonPickLocationVC.h"
#import "BeckonPickDateVC.h"

@interface BeckonPickLocationVC ()

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet MKMapView *beckonMap;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;

@end

@implementation BeckonPickLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *previousButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(previousStep)];
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextStep)];
    self.navigationItem.leftBarButtonItem = previousButton;
    self.navigationItem.rightBarButtonItem = nextButton;
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
            [self.locationManager requestAlwaysAuthorization];
            [self.locationManager requestWhenInUseAuthorization];
        }
        self.locationManager.delegate = self;
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [self.locationManager setDesiredAccuracy:kCLDistanceFilterNone];
        
        [self.locationManager startUpdatingLocation];
    }
    self.progressView.progress = 0.75;
}

- (IBAction)addressEnteredAction:(UITextField *)sender {
    [self.addressTextField resignFirstResponder];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.addressTextField.text completionHandler:^(NSArray *placemarks, NSError *error) {
        //Error checking
        
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        MKCoordinateRegion region;
     
        region.center.latitude = placemark.location.coordinate.latitude;
        region.center.longitude = placemark.location.coordinate.longitude;
        self.latitude = [[NSNumber alloc] initWithDouble:region.center.latitude];
        self.longitude = [[NSNumber alloc] initWithDouble:region.center.longitude];
        MKCoordinateSpan span;
        double radius = [(CLCircularRegion*)placemark.region radius] / 100; // convert to km
        span.latitudeDelta = radius / 112.0;
        region.span = span;
        [self.beckonMap removeAnnotations:self.beckonMap.annotations];
        MKPlacemark *placemarkForAnnotation = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]) addressDictionary:nil];
        [self.beckonMap addAnnotation:placemarkForAnnotation];
        [self.beckonMap setRegion:region animated:YES];
    }];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    for(CLLocation *location in locations){
        MKCoordinateRegion myPosition;
        myPosition.center.latitude = location.coordinate.latitude;
        myPosition.center.longitude = location.coordinate.longitude;
        self.latitude = [[NSNumber alloc] initWithDouble:location.coordinate.latitude];
        self.longitude = [[NSNumber alloc] initWithDouble:location.coordinate.longitude];
        myPosition.span.latitudeDelta = 0.008388;
        myPosition.span.longitudeDelta = 0.016243;
        [self.beckonMap setRegion:myPosition animated:NO];
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude) addressDictionary:nil];
        [self.beckonMap addAnnotation:placemark];
    }
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@", error);
}

- (void)nextStep{
    self.beckon.latitude = self.latitude;
    self.beckon.longitude = self.longitude;
    [self performSegueWithIdentifier:@"selectDate" sender:self];
}

- (void)previousStep{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"selectDate"]){
        BeckonPickDateVC *targetVC = [segue destinationViewController];
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
