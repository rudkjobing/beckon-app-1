//
//  BeckonPickLocationVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 02/08/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import "BeckonPickLocationVC.h"
#import "BeckonPickDateVC.h"
#import <AddressBook/AddressBook.h>

@interface BeckonPickLocationVC ()

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet MKMapView *beckonMap;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSString *locationString;
@property (weak, nonatomic) IBOutlet UITableView *searchResultsTableView;
@property (strong, nonatomic) NSArray *searchResults;

@end

@implementation BeckonPickLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationString                     =   @"Undefined";
    UIBarButtonItem *previousButton         =   [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(previousStep)];
    UIBarButtonItem *nextButton             =   [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextStep)];
    previousButton.tintColor                =   [UIColor blackColor];
    nextButton.tintColor                    =   [UIColor blackColor];
    self.navigationItem.leftBarButtonItem   =   previousButton;
    self.navigationItem.rightBarButtonItem  =   nextButton;
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager    =   [[CLLocationManager alloc] init];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
            [self.locationManager requestAlwaysAuthorization];
            [self.locationManager requestWhenInUseAuthorization];
        }
        self.locationManager.delegate   =   self;
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [self.locationManager setDesiredAccuracy:kCLDistanceFilterNone];
        [self.locationManager startUpdatingLocation];
    }
    self.progressView.progress = 0.75;
    self.searchResultsTableView.dataSource      =   self;
    self.searchResultsTableView.delegate        =   self;
    self.searchResultsTableView.layer.hidden    =   YES;
}

- (IBAction)locationSearchChanged:(UITextField *)sender {
    MKLocalSearchRequest* request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = sender.text;
    request.region = MKCoordinateRegionMakeWithDistance(self.beckonMap.userLocation.location.coordinate, 300, 300);
   
    MKLocalSearch* search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        self.searchResults = response.mapItems;
        for(MKMapItem *item in response.mapItems){
            for(NSString *add in item.placemark.addressDictionary){
                NSLog(@"%@, %@", add, item.placemark.addressDictionary[add]);
//            NSLog(@"%@, %@, %@", item.name, item.placemark.addressDictionary[@"Street"], item.phoneNumber);
            }
        }
        [self.searchResultsTableView reloadData];
    }];
}

- (IBAction)locationEnteredAction:(UITextField *)sender{
//    MKLocalSearchRequest* request = [[MKLocalSearchRequest alloc] init];
//    request.naturalLanguageQuery = sender.text;
//    request.region = MKCoordinateRegionMakeWithDistance(self.beckonMap.userLocation.location.coordinate, 120701, 120701);
//    
//    MKLocalSearch* search = [[MKLocalSearch alloc] initWithRequest:request];
//    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
//        for(MKMapItem *item in response.mapItems){
//            self.latitude = [[NSNumber alloc] initWithDouble:item.placemark.coordinate.latitude];
//            self.longitude = [[NSNumber alloc] initWithDouble:item.placemark.coordinate.longitude];
//            self.locationString = item.name;
//            
//            //Set new center for the map
//            MKCoordinateRegion region;
//            region.center.latitude = [self.latitude doubleValue];
//            region.center.longitude = [self.longitude doubleValue];
//
//            //Set zoom of map
//            MKCoordinateSpan span;
//            double radius = [(CLCircularRegion*)item.placemark.region radius] / 100; // convert to km
//            span.latitudeDelta = radius / 112.0;
//            region.span = span;
//            
//            //Remove annotations and place the new one
//            [self.beckonMap removeAnnotations:self.beckonMap.annotations];
//            MKPlacemark *placemarkForAnnotation = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]) addressDictionary:nil];
//            [self.beckonMap addAnnotation:placemarkForAnnotation];
//            [self.beckonMap setRegion:region animated:YES];
//            
//            //Log stuff
//            NSLog(@"%@, %@", item.name ,item.phoneNumber);
//            NSLog(@"%f, %f", item.placemark.coordinate.latitude, item.placemark.coordinate.longitude);
//            break;
//        }
//    }];
}

- (IBAction)locationSearchBegin:(id)sender {
    self.searchResultsTableView.layer.hidden = NO;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    for(CLLocation *location in locations){
        //Get the initial location
        MKCoordinateRegion myPosition;
        myPosition.center.latitude = location.coordinate.latitude;
        myPosition.center.longitude = location.coordinate.longitude;
        self.latitude = [[NSNumber alloc] initWithDouble:location.coordinate.latitude];
        self.longitude = [[NSNumber alloc] initWithDouble:location.coordinate.longitude];
        myPosition.span.latitudeDelta = 0.008388;
        myPosition.span.longitudeDelta = 0.016243;
        [self.beckonMap setRegion:myPosition animated:NO];
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude) addressDictionary:nil];
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
        annotation.coordinate = placemark.coordinate;
        [self.beckonMap addAnnotation:annotation];
        
        //Get the initial address
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [self.beckon.server startIndicator];
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            [self.beckon.server stopIndicator];
            if (error == nil && [placemarks count] > 0) {
                MKPlacemark *placemark = [placemarks lastObject];
                self.addressTextField.text = [NSString stringWithFormat:@"%@", placemark.name];
                self.locationString = placemark.name;
            } else {
                NSLog(@"%@", error.debugDescription);
            }
        } ];
    }
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@", error);
}

- (void)nextStep{
    self.beckon.latitude = self.latitude;
    self.beckon.longitude = self.longitude;
    self.beckon.locationString = self.locationString;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResults.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =   @"MapSearchCell";
    UITableViewCell *cell           =   (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell                        =   [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    MKMapItem *item                 =   [self.searchResults objectAtIndex:indexPath.row];
    
    cell.textLabel.text             =   item.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MKMapItem *item = [self.searchResults objectAtIndex:indexPath.row];
    self.latitude = [[NSNumber alloc] initWithDouble:item.placemark.coordinate.latitude];
    self.longitude = [[NSNumber alloc] initWithDouble:item.placemark.coordinate.longitude];
    self.locationString = item.name;
    
    //Set new center for the map
    MKCoordinateRegion region;
    region.center.latitude = [self.latitude doubleValue];
    region.center.longitude = [self.longitude doubleValue];
    
    //Set zoom of map
    MKCoordinateSpan span;
    double radius = [(CLCircularRegion*)item.placemark.region radius] / 100; // convert to km
    span.latitudeDelta = radius / 112.0;
    region.span = span;
    
    //Remove annotations and place the new one
    [self.beckonMap removeAnnotations:self.beckonMap.annotations];
    MKPlacemark *placemarkForAnnotation = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]) addressDictionary:nil];
    [self.beckonMap addAnnotation:placemarkForAnnotation];
    [self.beckonMap setRegion:region animated:YES];
    [self.view endEditing:YES];
    self.searchResultsTableView.layer.hidden = YES;
    
}


- (Beckon *) _beckon{
    if(!_beckon){
        _beckon = [[Beckon alloc] init];
    }
    return _beckon;
}

@end
