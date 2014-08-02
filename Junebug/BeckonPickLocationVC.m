//
//  BeckonPickLocationVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 02/08/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "BeckonPickLocationVC.h"
#import "BeckonPickDateVC.h"
#import <MapKit/MapKit.h>

@interface BeckonPickLocationVC ()

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet MKMapView *beckonMap;

@end

@implementation BeckonPickLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *previousButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(previousStep)];
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextStep)];
    self.navigationItem.leftBarButtonItem = previousButton;
    self.navigationItem.rightBarButtonItem = nextButton;
    self.progressView.progress = 0.75;
    self.beckonMap.showsUserLocation = YES;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.beckonMap.userLocation.location.coordinate, 2000, 2000);
    [self.beckonMap setRegion:region animated:NO];
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
