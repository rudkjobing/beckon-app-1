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
        CGFloat heightOfCellInTableView = 65.0;
        
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(self.contentView.frame.origin.x,
                                                                      self.contentView.frame.origin.y,
                                                                      self.contentView.frame.size.width,
                                                                      heightOfCellInTableView)];
        
        
        self.subContainerView = [[UIView alloc] initWithFrame:CGRectMake(self.containerView.frame.origin.x + 3,
                                                                         self.containerView.frame.origin.y + 2,
                                                                         self.containerView.frame.size.width -6,
                                                                         heightOfCellInTableView -4)];
    
        self.subContainerView.backgroundColor = [UIColor colorWithRed:80.0/255.0 green:122.0/255.0 blue:154.0/255.0 alpha:1.00];
        self.backgroundColor = [UIColor clearColor];
        
        // Initialization of subviews in contentview
        CGFloat startingPointOfSubViewOnX = self.subContainerView.bounds.origin.x + 8.0;
        CGFloat startingPointOfSubviewOnY = self.subContainerView.bounds.origin.y + 5.0;
        
        //add NickName Label
        CGFloat nickNameLabelHeight = 20.0;
        CGFloat nickNameLabelWidth = 230.0;
        
        CGRect frameOfNickNameLabel = CGRectMake(startingPointOfSubViewOnX, startingPointOfSubviewOnY, nickNameLabelWidth, nickNameLabelHeight);
        self.nickNameOfFriend = [[UILabel alloc] initWithFrame:frameOfNickNameLabel];
        self.nickNameOfFriend.backgroundColor = [UIColor clearColor];
        self.nickNameOfFriend.font = [UIFont boldSystemFontOfSize:16];
        self.nickNameOfFriend.textAlignment = UIControlContentHorizontalAlignmentLeft;
        self.nickNameOfFriend.textAlignment = UIControlContentVerticalAlignmentCenter;
        self.nickNameOfFriend.textColor = [UIColor whiteColor];
       
        //Update referencepoints for next subviews
        startingPointOfSubviewOnY = startingPointOfSubviewOnY + nickNameLabelHeight;
        
        //add label for name of friend
        CGFloat nameofFriendLabelHeight = 15;
        
        CGRect frameOfNameLabel = CGRectMake(startingPointOfSubViewOnX, startingPointOfSubviewOnY, nickNameLabelWidth, nameofFriendLabelHeight);
        self.nameOfFriend = [[UILabel alloc] initWithFrame:frameOfNameLabel];
        self.nameOfFriend.backgroundColor = [UIColor clearColor];
        self.nameOfFriend.font = [UIFont systemFontOfSize:12];
        self.nameOfFriend.textColor = [UIColor whiteColor];
        self.nameOfFriend.textAlignment = UIControlContentVerticalAlignmentCenter;
        
        //Update referencepoint of next subview
        startingPointOfSubviewOnY = startingPointOfSubviewOnY + nameofFriendLabelHeight;
        
        //add label for emailOfFriend
        CGFloat emailLabelheight = 15.0;
        
        CGRect frameOfEmailLabel = CGRectMake(startingPointOfSubViewOnX, startingPointOfSubviewOnY, nickNameLabelWidth, emailLabelheight);
        self.emailOfFriend = [[UILabel alloc] initWithFrame:frameOfEmailLabel];
        self.emailOfFriend.backgroundColor = [UIColor clearColor];
        self.emailOfFriend.font = [UIFont italicSystemFontOfSize:12];
        self.emailOfFriend.textColor = [UIColor whiteColor];
        self.emailOfFriend.textAlignment = UIControlContentHorizontalAlignmentLeft;
        self.emailOfFriend.textAlignment = UIControlContentVerticalAlignmentCenter;
        
        self.contentView.backgroundColor = [UIColor clearColor];
        //Customize cellboarder
        [self.subContainerView.layer setBorderColor:[UIColor clearColor].CGColor];
        [self.subContainerView.layer setBorderWidth:1.0f];
        
        //add subviews to cell
        [self.containerView addSubview:self.subContainerView];
        [self.contentView addSubview:self.containerView];
        
//        [self.customSubview addSubview:self.pictureOfFriend];
        [self.subContainerView addSubview:self.nickNameOfFriend];
        [self.subContainerView addSubview:self.nameOfFriend];
        [self.subContainerView addSubview:self.emailOfFriend];
      
        self.isActivated = NO;
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setActivated{
    self.subContainerView.backgroundColor = [UIColor colorWithRed:36.0/255.0 green:192.0/255.0 blue:154.0/255.0 alpha:1.00];
    self.isActivated = YES;
}

- (void)setDeactivated{
    self.subContainerView.backgroundColor = [UIColor colorWithRed:80.0/255.0 green:122.0/255.0 blue:154.0/255.0 alpha:1.00];
    self.isActivated = NO;
}

@end
