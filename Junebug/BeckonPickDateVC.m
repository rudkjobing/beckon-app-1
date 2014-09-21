//
//  BeckonPickDateVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 02/08/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import "BeckonPickDateVC.h"
#import "GradientLayers.h"
#import "BeckonCreatNavigationVC.h"

@interface BeckonPickDateVC ()

@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UISlider *durationSlider;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIDatePicker *date;

@end

@implementation BeckonPickDateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *previousButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(previousStep)];
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    previousButton.tintColor = [UIColor blackColor];
    nextButton.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = previousButton;
    self.navigationItem.rightBarButtonItem = nextButton;
    
    [self.durationSlider addTarget:self action:@selector(updateDuration) forControlEvents:UIControlEventValueChanged];
    
    self.progressView.progress = 1.0;
}

- (void) updateDuration{;
    int sliderData = self.durationSlider.value;
    if(sliderData == 1){
        self.durationLabel.text = [[NSString alloc] initWithFormat:@"%i Hour", sliderData];
    }
    else if(sliderData < 24){
        self.durationLabel.text = [[NSString alloc] initWithFormat:@"%i Hours", sliderData];
    }
    else if (sliderData == 24){
        self.durationLabel.text = [[NSString alloc] initWithFormat:@"%i Day", sliderData - 23];
    }
    else if(sliderData > 24 && sliderData < 30){
        self.durationLabel.text = [[NSString alloc] initWithFormat:@"%i Days", sliderData - 23];
    }
    else if(sliderData == 30){
        self.durationLabel.text = [[NSString alloc] initWithFormat:@"%i Week", sliderData - 23 - 6];
    }
    else if(sliderData > 30){
        self.durationLabel.text = [[NSString alloc] initWithFormat:@"%i Weeks", sliderData - 23 - 6];
    }
}

- (void)done{
    int duration = self.durationSlider.value;
    self.beckon.begins = self.date.date;
    if(duration < 24){
        self.beckon.ends = [self.date.date dateByAddingTimeInterval: duration * 60 * 60];
    }
    else if(duration > 23 && duration < 30){
        self.beckon.ends = [self.date.date dateByAddingTimeInterval: (duration - 23) * 60 * 60 * 24];
    }
    else if(duration > 29 ){
        self.beckon.ends = [self.date.date dateByAddingTimeInterval: (duration - 23 - 6)  * 60 * 60 * 24 * 7];
    }
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
