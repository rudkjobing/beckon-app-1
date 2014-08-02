//
//  BeckonPickLocationVC.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 02/08/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Beckon.h"

@interface BeckonPickLocationVC : UIViewController<CLLocationManagerDelegate>

@property (strong, nonatomic) Beckon *beckon;

@end
