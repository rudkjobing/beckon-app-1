//
//  BeckonCell.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/05/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "BeckonCell.h"
#import "Convertions.h"

@implementation BeckonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        //Add new custom subview. Relates to heightforRowAtIndexPath in FriendsVC
        CGFloat heightOfCellInTableView = 55.0;
        
        CGRect rectForCustomSubView = CGRectMake(self.contentView.frame.origin.x,
                                                 self.contentView.frame.origin.y + 5.0,
                                                 self.contentView.frame.size.width,
                                                 heightOfCellInTableView);
        self.customBeckonCellView = [[UIView alloc] initWithFrame:rectForCustomSubView];
        self.customBeckonCellView.backgroundColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.9];
        
        self.customBeckonCellView.layer.shadowColor = [UIColor blackColor].CGColor;
         self.customBeckonCellView.layer.shadowOffset = CGSizeMake(0, 1);
         self.customBeckonCellView.layer.shadowOpacity = 0.3;
         self.customBeckonCellView.layer.shadowRadius = 3.0;
        
        // Initialization of subviews in contentview
        CGFloat startingPointOfSubViewOnX = self.customBeckonCellView.bounds.origin.x + 10.0;
        CGFloat startingPointOfSubviewOnY = self.customBeckonCellView.bounds.origin.y + 5.0;
        
        //Create referencepoints
        CGFloat startingPointofLabels = startingPointOfSubViewOnX;

        //Create UILabel for imageView
        CGRect frameOfImageView = CGRectMake(startingPointofLabels, startingPointOfSubviewOnY, 44.0, 44.0);
        self.beckonIconImage = [[UIImageView alloc] initWithFrame:frameOfImageView];
        self.beckonIconImage.layer.shadowColor = [UIColor blackColor].CGColor;
        self.beckonIconImage.layer.shadowOffset = CGSizeMake(0, 1);
        self.beckonIconImage.layer.shadowOpacity = 1;
        self.beckonIconImage.layer.shadowRadius = 1.0;
        [self.beckonIconImage.layer setBorderColor:[[UIColor whiteColor] CGColor]];
        [self.beckonIconImage.layer setBorderWidth:1.5];

    
        
        //referencepoints
        CGFloat referencepointOnX = ((self.beckonIconImage.frame.size.width + startingPointofLabels) + 10.0);
        CGFloat referencepointOnY = 5.0;
        CGFloat hightOfNameOfEventLabel = 20.0;
        CGFloat widthOfEventLabel = 165.0;
        
        //Create UILabel for nameOfEvents
        CGRect placeMentOfNameOfEventLabel = CGRectMake(referencepointOnX, referencepointOnY, widthOfEventLabel, hightOfNameOfEventLabel);
        self.nameOfEventLabel = [[UILabel alloc] initWithFrame:placeMentOfNameOfEventLabel];
        self.nameOfEventLabel.font = [UIFont boldSystemFontOfSize:16];
        self.nameOfEventLabel.backgroundColor = [UIColor clearColor];
        self.nameOfEventLabel.textColor = [UIColor blackColor];
        self.nameOfEventLabel.textAlignment = UIControlContentHorizontalAlignmentLeft;
        self.nameOfEventLabel.textAlignment = UIControlContentVerticalAlignmentCenter;
        
        /*self.nameOfEventLabel.layer.shadowColor = [UIColor blackColor].CGColor;
        self.nameOfEventLabel.layer.shadowOffset = CGSizeMake(0, 1);
        self.nameOfEventLabel.layer.shadowOpacity = 1;
        self.nameOfEventLabel.layer.shadowRadius = 1.0;*/
        
        //Update referencepoints on X and Y
        referencepointOnY = (referencepointOnY + hightOfNameOfEventLabel);
        
        //add placeOfeventLabel
        CGFloat heightOfPlaceOfEventLabel = 15.0;
        
        CGRect placementOfPlaceOfEventLabel = CGRectMake(referencepointOnX, referencepointOnY, widthOfEventLabel, heightOfPlaceOfEventLabel);
        self.placeOfEventLabel = [[UILabel alloc] initWithFrame:placementOfPlaceOfEventLabel];
        self.placeOfEventLabel.font = [UIFont systemFontOfSize:12];
        self.placeOfEventLabel.textColor = [UIColor blackColor];
        self.placeOfEventLabel.backgroundColor = [UIColor clearColor];
        self.placeOfEventLabel.textAlignment = UIControlContentHorizontalAlignmentLeft;
        self.placeOfEventLabel.textAlignment = UIControlContentVerticalAlignmentCenter;
        
        //Update referncepoints on Y
        referencepointOnY = (referencepointOnY + heightOfPlaceOfEventLabel);
        
        
        //add timeofeventLabel
        CGRect placementofTimeOfEventLabel = CGRectMake(referencepointOnX, referencepointOnY, widthOfEventLabel, 15.0);
        self.timeOfEventLabel = [[UILabel alloc] initWithFrame:placementofTimeOfEventLabel];
        self.timeOfEventLabel.backgroundColor = [UIColor clearColor];
        self.timeOfEventLabel.textColor = [UIColor blackColor];
        self.timeOfEventLabel.font = [UIFont italicSystemFontOfSize:12];
        self.timeOfEventLabel.textAlignment = UIControlContentVerticalAlignmentCenter;
        //self.timeOfEventLabel.textAlignment = UIControlContentHorizontalAlignmentLeft;
        
        //adjust referencepoints
        referencepointOnX = referencepointOnX + widthOfEventLabel;
        
        //Create UILabel for countdowntimer
        CGRect frameOfTimerLabel = CGRectMake(referencepointOnX, 5.0, 44.0, hightOfNameOfEventLabel);
        self.timerLabel = [[UILabel alloc] initWithFrame:frameOfTimerLabel];
        self.timerLabel.textColor = [UIColor blackColor];
        self.timerLabel.font = [UIFont boldSystemFontOfSize:14];
        self.timerLabel.backgroundColor = [UIColor clearColor];
        self.timerLabel.textAlignment = UIControlContentHorizontalAlignmentCenter;
        self.timerLabel.textAlignment = UIControlContentVerticalAlignmentCenter;
        
        /*self.timerLabel.layer.shadowColor = [UIColor blackColor].CGColor;
         self.timerLabel.layer.shadowOffset = CGSizeMake(0, 1);
         self.timerLabel.layer.shadowOpacity = 1;
         self.timerLabel.layer.shadowRadius = 1.0;*/
        
        //Set cell opague
        self.backgroundColor = [UIColor clearColor];
        
        [self.customBeckonCellView.layer setBorderColor:[UIColor clearColor].CGColor];
        [self.customBeckonCellView.layer setBorderWidth:1.0f];
        
        //add the subviews to contentview of cell
        [self.contentView addSubview:self.customBeckonCellView];
        [self.customBeckonCellView addSubview:self.beckonIconImage];
        [self.customBeckonCellView addSubview:self.nameOfEventLabel];
        [self.customBeckonCellView addSubview:self.timerLabel];
        [self.customBeckonCellView addSubview:self.placeOfEventLabel];
        [self.customBeckonCellView addSubview:self.timeOfEventLabel];
        
        [self startTimer];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    
    frame.origin.x += 20;
    frame.size.width -= 2 * 20;
    [super setFrame:frame];
}


- (void)layoutSubviews
{
    self.contentView.bounds = CGRectMake(self.bounds.origin.x,
                                         self.bounds.origin.y,
                                         self.bounds.size.width - 50,
                                         self.bounds.size.height);
    
    [super layoutSubviews];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:NO];
    // Configure the view for the selected state
    
}

- (void) startTimer{
    [self updateLabel];
    NSTimer *timer = [[NSTimer alloc] init];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
    
}

- (void) updateLabel{
    if(self.begins){
        NSTimeInterval ti = [self.begins timeIntervalSinceDate:[[NSDate alloc] init]];
        NSString *stringTi = [Convertions stringFromTimeInterval:ti];
        self.timerLabel.text = stringTi;
    }
}

@end
