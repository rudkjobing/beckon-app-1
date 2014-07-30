//
//  BeckonCell.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/05/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "BeckonCell.h"

@implementation BeckonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        //Create referencepoints
        CGFloat startingPointofLabels = 5.0;

        //Create UILabel for countdowntimer
        CGRect frameOfTimerLabel = CGRectMake(startingPointofLabels, 0.0, 44.0, 55.0);
        self.timerLabel = [[UILabel alloc] initWithFrame:frameOfTimerLabel];
        self.timerLabel.textColor = [UIColor whiteColor];
        self.timerLabel.font = [UIFont boldSystemFontOfSize:16];
        self.timerLabel.backgroundColor = [UIColor clearColor];
        self.timerLabel.textAlignment = UIControlContentHorizontalAlignmentCenter;
        self.timerLabel.textAlignment = UIControlContentVerticalAlignmentCenter;
        
        //referencepoints
        CGFloat referencepointOnX = (self.timerLabel.frame.size.width + startingPointofLabels);
        CGFloat referencepointOnY = 5.0;
        CGFloat hightOfNameOfEventLabel = 20.0;
        CGFloat widthOfEventLabel = 150.0;
        
        //Create UILabel for nameOfEvents
        CGRect placeMentOfNameOfEventLabel = CGRectMake(referencepointOnX, referencepointOnY, widthOfEventLabel, hightOfNameOfEventLabel);
        self.nameOfEventLabel = [[UILabel alloc] initWithFrame:placeMentOfNameOfEventLabel];
        self.nameOfEventLabel.font = [UIFont boldSystemFontOfSize:12];
        self.nameOfEventLabel.backgroundColor = [UIColor clearColor];
        self.nameOfEventLabel.textColor = [UIColor clearColor];
        self.nameOfEventLabel.textAlignment = UIControlContentHorizontalAlignmentLeft;
        self.nameOfEventLabel.textAlignment = UIControlContentVerticalAlignmentCenter;
        
        //Update referencepoints on X and Y
        referencepointOnX = (referencepointOnX + widthOfEventLabel);
        referencepointOnY = (referencepointOnY + hightOfNameOfEventLabel);
        
        //add placeOfeventLabel
        CGFloat heightOfPlaceOfEventLabel = 15.0;
        
        CGRect placementOfPlaceOfEventLabel = CGRectMake(referencepointOnX, referencepointOnY, widthOfEventLabel, heightOfPlaceOfEventLabel);
        self.placeOfEventLabel = [[UILabel alloc] initWithFrame:placementOfPlaceOfEventLabel];
        self.placeOfEventLabel.font = [UIFont systemFontOfSize:10];
        self.placeOfEventLabel.textColor = [UIColor whiteColor];
        self.placeOfEventLabel.backgroundColor = [UIColor clearColor];
        self.placeOfEventLabel.textAlignment = UIControlContentHorizontalAlignmentLeft;
        self.placeOfEventLabel.textAlignment = UIControlContentVerticalAlignmentCenter;
        
        //Update referncepoints on Y
        referencepointOnY = (referencepointOnY + heightOfPlaceOfEventLabel);
        
        CGRect placementofTimeOfEventLabel = CGRectMake(referencepointOnX, referencepointOnY, widthOfEventLabel, 15.0);
        self.timeOfEventLabel = [[UILabel alloc] initWithFrame:placementofTimeOfEventLabel];
        self.timeOfEventLabel.backgroundColor = [UIColor clearColor];
        self.timeOfEventLabel.textColor = [UIColor whiteColor];
        self.timeOfEventLabel.font = [UIFont italicSystemFontOfSize:10];
        self.placeOfEventLabel.textAlignment = UIControlContentVerticalAlignmentCenter;
        self.placeOfEventLabel.textAlignment = UIControlContentHorizontalAlignmentLeft;
        
        //Set cell opague
        self.backgroundColor = [UIColor clearColor];
        
        //add the subviews to contentview of cell
        [self.contentView addSubview:self.nameOfEventLabel];
        [self.contentView addSubview:self.timerLabel];
        [self.contentView addSubview:self.placeOfEventLabel];
        [self.contentView addSubview:self.timeOfEventLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
