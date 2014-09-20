//
//  BeckonCell.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/05/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
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
        CGFloat heightOfCellInTableView = 65.0;
        
        CGRect rectForCustomSubView = CGRectMake(self.contentView.frame.origin.x - 12.0,
                                                 self.contentView.frame.origin.y + 9.0,
                                                 self.contentView.frame.size.width +24.0,
                                                 heightOfCellInTableView);
        self.customBeckonCellView = [[UIView alloc] initWithFrame:rectForCustomSubView];
        self.customBeckonCellView.backgroundColor = [UIColor colorWithRed:93.0/255.0 green:119.0/255.0 blue:55.0/255.0 alpha:0.8];
        
        self.customBeckonCellView.layer.shadowColor = [UIColor blackColor].CGColor;
         self.customBeckonCellView.layer.shadowOffset = CGSizeMake(0, 1);
         self.customBeckonCellView.layer.shadowOpacity = 0.5;
         self.customBeckonCellView.layer.shadowRadius = 4.0;
        
        // Initialization of subviews in contentview
        CGFloat startingPointOfSubViewOnX = self.customBeckonCellView.bounds.origin.x + 10.0;
        
        //Create referencepoints
        CGFloat startingPointofLabels = startingPointOfSubViewOnX;

        //Create UILabel for imageView
        /*CGRect frameOfImageView = CGRectMake(startingPointofLabels, startingPointOfSubviewOnY, 44.0, 44.0);
        self.beckonIconImage = [[UIImageView alloc] initWithFrame:frameOfImageView];
        self.beckonIconImage.layer.shadowColor = [UIColor blackColor].CGColor;
        self.beckonIconImage.layer.shadowOffset = CGSizeMake(0, 1);
        self.beckonIconImage.layer.shadowOpacity = 1;
        self.beckonIconImage.layer.shadowRadius = 1.0;
        [self.beckonIconImage.layer setBorderColor:[[UIColor whiteColor] CGColor]];
        [self.beckonIconImage.layer setBorderWidth:1.5];*/

    
        
        //referencepoints
        CGFloat referencepointOnX = startingPointofLabels;
        CGFloat referencepointOnY = 5.0;
        CGFloat hightOfNameOfEventLabel = 20.0;
        CGFloat widthOfEventLabel = 165.0;
        
        //Create UILabel for nameOfEvents
        CGRect placeMentOfNameOfEventLabel = CGRectMake(referencepointOnX, referencepointOnY, widthOfEventLabel, hightOfNameOfEventLabel);
        self.nameOfEventLabel = [[UILabel alloc] initWithFrame:placeMentOfNameOfEventLabel];
        self.nameOfEventLabel.font = [UIFont boldSystemFontOfSize:16];
        self.nameOfEventLabel.backgroundColor = [UIColor clearColor];
        self.nameOfEventLabel.textColor = [UIColor whiteColor];
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
        self.placeOfEventLabel.textColor = [UIColor whiteColor];
        self.placeOfEventLabel.backgroundColor = [UIColor clearColor];
        self.placeOfEventLabel.textAlignment = UIControlContentHorizontalAlignmentLeft;
        self.placeOfEventLabel.textAlignment = UIControlContentVerticalAlignmentCenter;
        
        //Update referncepoints on Y
        referencepointOnY = (referencepointOnY + heightOfPlaceOfEventLabel);
        
        
        //add timeofeventLabel
        CGRect placementofTimeOfEventLabel = CGRectMake(referencepointOnX, referencepointOnY, widthOfEventLabel, 15.0);
        self.timeOfEventLabel = [[UILabel alloc] initWithFrame:placementofTimeOfEventLabel];
        self.timeOfEventLabel.backgroundColor = [UIColor clearColor];
        self.timeOfEventLabel.textColor = [UIColor whiteColor];
        self.timeOfEventLabel.font = [UIFont italicSystemFontOfSize:12];
        self.timeOfEventLabel.textAlignment = UIControlContentVerticalAlignmentCenter;
        //self.timeOfEventLabel.textAlignment = UIControlContentHorizontalAlignmentLeft;
        
        //adjust referencepoints
        referencepointOnX = referencepointOnX + widthOfEventLabel;
       
        /*self.timerLabel.layer.shadowColor = [UIColor blackColor].CGColor;
         self.timerLabel.layer.shadowOffset = CGSizeMake(0, 1);
         self.timerLabel.layer.shadowOpacity = 1;
         self.timerLabel.layer.shadowRadius = 1.0;*/
        
        // set statuslabel
        
        
        self.chatImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.customBeckonCellView.frame.size.width - 25, 25, 15, 15)];
        self.chatImageView.image = [UIImage imageNamed:@"chatbubble.png"];
        
        CGFloat widthOfStatuslabel = 90;
        
        CGRect frameOfStatusLabel = CGRectMake((self.customBeckonCellView.frame.size.width - widthOfStatuslabel - 10), referencepointOnY, widthOfStatuslabel, 15);
        self.statusLabel = [[UILabel alloc] initWithFrame:frameOfStatusLabel];
        self.statusLabel.textColor = [UIColor whiteColor];
        self.statusLabel.font = [UIFont italicSystemFontOfSize:12];
        self.statusLabel.backgroundColor = [UIColor clearColor];
        self.statusLabel.textAlignment = UIControlContentHorizontalAlignmentRight;

        //Create UILabel for countdowntimer
        CGRect frameOfTimerLabel = CGRectMake((self.customBeckonCellView.frame.size.width - widthOfStatuslabel - 10), 5.0, widthOfStatuslabel, hightOfNameOfEventLabel);
        self.timerLabel = [[UILabel alloc] initWithFrame:frameOfTimerLabel];
        self.timerLabel.textColor = [UIColor whiteColor];
        self.timerLabel.font = [UIFont boldSystemFontOfSize:14];
        self.timerLabel.backgroundColor = [UIColor clearColor];
        self.timerLabel.textAlignment = UIControlContentHorizontalAlignmentRight;
        
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
        [self.customBeckonCellView addSubview:self.statusLabel];
        
        
        [self startTimer];
    }
    return self;
}

- (void) activateChatIndicator{
    [self.customBeckonCellView addSubview:self.chatImageView];
}

- (void) deactivateChatIndicator{
    [self.chatImageView removeFromSuperview];
}

- (void) setCellColor:(UIColor*)color{
    self.customBeckonCellView.backgroundColor = color;
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
