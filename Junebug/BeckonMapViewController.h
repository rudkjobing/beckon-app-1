//
//  BeckonMapViewController.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 01/09/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface BeckonMapViewController : UIViewController <CLLocationManagerDelegate>

- (void)updateButtonState;

@end
