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
        
        [self.locationManager startMonitoringSignificantLocationChanges];
    }
    self.progressView.progress = 0.75;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    for(CLLocation *location in locations){
        MKCoordinateRegion myPosition;
        myPosition.center.latitude = location.coordinate.latitude;
        myPosition.center.longitude = location.coordinate.longitude;
        myPosition.span.latitudeDelta = 0.008388;
        myPosition.span.longitudeDelta = 0.016243;
        [self.beckonMap setRegion:myPosition animated:YES];
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude) addressDictionary:nil];
        [self.beckonMap addAnnotation:placemark];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@", error);
}

- (void)nextStep{
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
