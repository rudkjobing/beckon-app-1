//
//  FriendCell.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 18/05/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import "FriendCell.h"

@implementation FriendCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //Add new custom subview. Relates to heightforRowAtIndexPath in FriendsVC
        CGFloat heightOfCellInTableView = 55.0;
        
        CGRect rectForCustomSubView = CGRectMake(self.contentView.frame.origin.x,
                                                 self.contentView.frame.origin.y + 5.0,
                                                 self.contentView.frame.size.width,
                                                 heightOfCellInTableView);
        self.customSubview = [[UIView alloc] initWithFrame:rectForCustomSubView];
        self.customSubview.backgroundColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.7];
        
        
        // Initialization of subviews in contentview
        CGFloat startingPointOfSubViewOnX = self.customSubview.bounds.origin.x + 10.0;
        CGFloat startingPointOfSubviewOnY = self.customSubview.bounds.origin.y + 5.0;
        
        //add Image of Friend
        CGFloat heightOfFriendImage = 45.0;
        CGFloat widthOfFriendImage = 45.0;
        
        CGRect frameOfFriendImage = CGRectMake(startingPointOfSubViewOnX, startingPointOfSubviewOnY, widthOfFriendImage, heightOfFriendImage);
        self.pictureOfFriend = [[UIImageView alloc] initWithFrame:frameOfFriendImage];
        self.pictureOfFriend.layer.shadowColor = [UIColor blackColor].CGColor;
        self.pictureOfFriend.layer.shadowOffset = CGSizeMake(0, 1);
        self.pictureOfFriend.layer.shadowOpacity = 1;
        self.pictureOfFriend.layer.shadowRadius = 1.0;
        [self.pictureOfFriend.layer setBorderColor:[[UIColor whiteColor] CGColor]];
        [self.pictureOfFriend.layer setBorderWidth:1.5];
        
        //Update Referencepoints for next subviews
        startingPointOfSubViewOnX = widthOfFriendImage + startingPointOfSubViewOnX + 10.0;
        startingPointOfSubviewOnY = startingPointOfSubviewOnY - 3;
        
        //add NickName Label
        CGFloat nickNameLabelHeight = 20.0;
        CGFloat nickNameLabelWidth = 200.0;
        
        CGRect frameOfNickNameLabel = CGRectMake(startingPointOfSubViewOnX, startingPointOfSubviewOnY, nickNameLabelWidth, nickNameLabelHeight);
        self.nickNameOfFriend = [[UILabel alloc] initWithFrame:frameOfNickNameLabel];
        self.nickNameOfFriend.backgroundColor = [UIColor clearColor];
        self.nickNameOfFriend.font = [UIFont boldSystemFontOfSize:16];
        self.nickNameOfFriend.textAlignment = UIControlContentHorizontalAlignmentLeft;
        self.nickNameOfFriend.textAlignment = UIControlContentVerticalAlignmentCenter;
        self.nickNameOfFriend.textColor = [UIColor blackColor];
        
        /*self.nickNameOfFriend.layer.shadowColor = [UIColor grayColor].CGColor;
         self.nickNameOfFriend.layer.shadowOffset = CGSizeMake(0, 1);
         self.nickNameOfFriend.layer.shadowOpacity = 1;
         self.nickNameOfFriend.layer.shadowRadius = 0.6;*/
        
        
        //Update referencepoints for next subviews
        startingPointOfSubviewOnY = startingPointOfSubviewOnY + nickNameLabelHeight;
        
        //add label for name of friend
        CGFloat nameofFriendLabelHeight = 15;
        
        CGRect frameOfNameLabel = CGRectMake(startingPointOfSubViewOnX, startingPointOfSubviewOnY, nickNameLabelWidth, nameofFriendLabelHeight);
        self.nameOfFriend = [[UILabel alloc] initWithFrame:frameOfNameLabel];
        self.nameOfFriend.backgroundColor = [UIColor clearColor];
        self.nameOfFriend.font = [UIFont systemFontOfSize:12];
        self.nameOfFriend.textColor = [UIColor blackColor];
        self.nameOfFriend.textAlignment = UIControlContentVerticalAlignmentCenter;
        
        //Update referencepoint of next subview
        startingPointOfSubviewOnY = startingPointOfSubviewOnY + nameofFriendLabelHeight;
        
        //add label for emailOfFriend
        CGFloat emailLabelheight = 15.0;
        
        CGRect frameOfEmailLabel = CGRectMake(startingPointOfSubViewOnX, startingPointOfSubviewOnY, nickNameLabelWidth, emailLabelheight);
        self.emailOfFriend = [[UILabel alloc] initWithFrame:frameOfEmailLabel];
        self.emailOfFriend.backgroundColor = [UIColor clearColor];
        self.emailOfFriend.font = [UIFont italicSystemFontOfSize:12];
        self.emailOfFriend.textColor = [UIColor blackColor];
        self.emailOfFriend.textAlignment = UIControlContentHorizontalAlignmentLeft;
        self.emailOfFriend.textAlignment = UIControlContentVerticalAlignmentCenter;
        
        self.contentView.backgroundColor = [UIColor clearColor];
        //Customize cellboarder
        [self.customSubview.layer setBorderColor:[UIColor clearColor].CGColor];
        [self.customSubview.layer setBorderWidth:1.0f];
        
        //add subviews to cell
        [self.contentView addSubview:self.customSubview];
        [self.customSubview addSubview:self.pictureOfFriend];
        [self.customSubview addSubview:self.nickNameOfFriend];
        [self.customSubview addSubview:self.nameOfFriend];
        [self.customSubview addSubview:self.emailOfFriend];
        
        self.backgroundColor = [UIColor clearColor];
        
        
    }
    return self;
}


//set width of cells contentview

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

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
