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
        CGFloat heightOfCellInTableView = 75.0;
        
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(self.contentView.frame.origin.x,
                                                                      self.contentView.frame.origin.y,
                                                                      self.contentView.frame.size.width,
                                                                      heightOfCellInTableView)];
        
        
        self.subContainerView = [[UIView alloc] initWithFrame:CGRectMake(self.containerView.frame.origin.x + 3,
                                                                         self.containerView.frame.origin.y + 4,
                                                                         self.containerView.frame.size.width -6,
                                                                         heightOfCellInTableView -8)];
    
        self.subContainerView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.subContainerView.layer.shadowOffset = CGSizeMake(0, 1);
        self.subContainerView.layer.shadowOpacity = 0.6;
        self.subContainerView.layer.shadowRadius = 4.0;
        
        // Initialization of subviews in contentview
        CGFloat startingPointOfSubViewOnX = self.subContainerView.bounds.origin.x + 5;
        
        //Create referencepoints
        CGFloat startingPointofLabels = startingPointOfSubViewOnX;
        
        //referencepoints
        CGFloat referencepointOnX = startingPointofLabels;
        CGFloat referencepointOnY = 5.0;
        CGFloat hightOfNameOfEventLabel = 20.0;
        CGFloat widthOfEventLabel = 195.0;
        
        //Create UILabel for nameOfEvents
        CGRect placeMentOfNameOfEventLabel = CGRectMake(referencepointOnX, referencepointOnY, widthOfEventLabel, hightOfNameOfEventLabel);
        self.nameOfEventLabel = [[UILabel alloc] initWithFrame:placeMentOfNameOfEventLabel];
        self.nameOfEventLabel.font = [UIFont boldSystemFontOfSize:16];
        self.nameOfEventLabel.backgroundColor = [UIColor clearColor];
        self.nameOfEventLabel.textColor = [UIColor whiteColor];
        self.nameOfEventLabel.textAlignment = UIControlContentHorizontalAlignmentLeft;
        self.nameOfEventLabel.textAlignment = UIControlContentVerticalAlignmentCenter;
       
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
        
        
        self.chatImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.subContainerView.frame.size.width - 28, 23, 18, 18)];
        self.chatImageView.image = [UIImage imageNamed:@"chatbubble.png"];
        
        CGFloat widthOfStatuslabel = 150;
        
        CGRect frameOfStatusLabel = CGRectMake((self.subContainerView.frame.size.width - widthOfStatuslabel - 10), referencepointOnY, widthOfStatuslabel, 15);
        self.statusLabel = [[UILabel alloc] initWithFrame:frameOfStatusLabel];
        self.statusLabel.textColor = [UIColor whiteColor];
        self.statusLabel.font = [UIFont italicSystemFontOfSize:12];
        self.statusLabel.backgroundColor = [UIColor clearColor];
        self.statusLabel.textAlignment = UIControlContentHorizontalAlignmentRight;

        //Create UILabel for countdowntimer
        CGRect frameOfTimerLabel = CGRectMake((self.subContainerView.frame.size.width - widthOfStatuslabel - 10), 5.0, widthOfStatuslabel, hightOfNameOfEventLabel);
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
        [self.contentView addSubview:self.containerView];
        [self.containerView addSubview:self.subContainerView];
        [self.subContainerView addSubview:self.nameOfEventLabel];
        [self.subContainerView addSubview:self.timerLabel];
        [self.subContainerView addSubview:self.placeOfEventLabel];
        [self.subContainerView addSubview:self.timeOfEventLabel];
        [self.subContainerView addSubview:self.statusLabel];
        
        
        [self startTimer];
    }
    return self;
}

- (void) activateChatIndicator{
    [self.subContainerView addSubview:self.chatImageView];
}

- (void) deactivateChatIndicator{
    [self.chatImageView removeFromSuperview];
}

- (void) setCellColor:(UIColor*)color{
    self.subContainerView.backgroundColor = color;
}

- (void)layoutSubviews
{
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
