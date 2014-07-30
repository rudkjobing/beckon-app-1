//
//  GradientLayers.m
//  Junebug
//
//  Created by Bertil Andersen on 30/07/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "GradientLayers.h"

@implementation GradientLayers


+(CAGradientLayer *) greyGradient{
    UIColor *colorOne = [UIColor colorWithWhite:0.9 alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.85 alpha:1.0];
    UIColor *colorThree = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.4 alpha:1.0];
    UIColor *colorFour = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.2 alpha:1.0];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor,colorTwo.CGColor,colorThree.CGColor, colorFour.CGColor, nil];
    
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:0.02];
    NSNumber *stopThree = [NSNumber numberWithFloat:0.99];
    NSNumber *stopFour = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo,stopThree, stopFour, nil];
    
    CAGradientLayer *headerlayer = [CAGradientLayer layer];
    headerlayer.colors = colors;
    headerlayer.locations = locations;
    
    return headerlayer;    
}

+(CAGradientLayer *) appBlueGradient{
    UIColor *colorOne = [UIColor colorWithRed:(69/255.0) green:(212/255.0) blue:(253/255.0) alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithRed:(13/255.0) green:(95/255.0) blue:(187/255.0) alpha:1.0];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor,colorTwo.CGColor, nil];
    
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne,stopTwo, nil];
    
    CAGradientLayer *headerlayer = [CAGradientLayer layer];
    headerlayer.colors = colors;
    headerlayer.locations = locations;
    
    return headerlayer;
}


@end
