//
//  BeckonPickDateVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 02/08/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "BeckonPickDateVC.h"
#import "GradientLayers.h"
#import "BeckonCreatNavigationVC.h"

@interface BeckonPickDateVC ()

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIDatePicker *date;

@end

@implementation BeckonPickDateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    CAGradientLayer * bgLayer = [GradientLayers appBlueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    UIBarButtonItem *previousButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(previousStep)];
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    self.navigationItem.leftBarButtonItem = previousButton;
    self.navigationItem.rightBarButtonItem = nextButton;
    self.progressView.progress = 1.0;
}

- (void)done{      
    self.beckon.ends = self.date.date.description;
    [self.beckon flush];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)previousStep{
    [self.navigationController popViewControllerAnimated:YES];
}

- (Beckon *) _beckon{
    if(!_beckon){
        _beckon = [[Beckon alloc] init];
    }
    return _beckon;
}

@end
