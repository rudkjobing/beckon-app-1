//
//  BeckonCell.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/05/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeckonCell : UITableViewCell

@property(strong,nonatomic) UILabel *nameOfEventLabel;
@property(strong,nonatomic) UILabel *placeOfEventLabel;
@property(strong,nonatomic) UILabel *timeOfEventLabel;
@property(strong,nonatomic) UILabel *timerLabel;
@property(strong,nonatomic) NSDate *begins;

- (void) startTimer;

@end
