//
//  FriendCell.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 18/05/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "FriendCell.h"

@implementation FriendCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGFloat startingPointOfSubViewOnX = 10.0;
        CGFloat startingPointOfSubviewOnY = 5.0;
        
        //add Image of Friend
        CGFloat heightOfFriendImage = 45.0;
        CGFloat widthOfFriendImage = 45.0;
        
        CGRect frameOfFriendImage = CGRectMake(startingPointOfSubViewOnX, startingPointOfSubviewOnY, widthOfFriendImage, heightOfFriendImage);
        self.pictureOfFriend = [[UIImageView alloc] initWithFrame:frameOfFriendImage];
        
        //Update Referencepoints for next subviews
        startingPointOfSubViewOnX = widthOfFriendImage + startingPointOfSubViewOnX;
        
        //add NickName Label
        CGFloat nickNameLabelHeight = 20.0;
        CGFloat nickNameLabelWidth = 150.0;
        
        CGRect frameOfNickNameLabel = CGRectMake(startingPointOfSubViewOnX, startingPointOfSubviewOnY, nickNameLabelWidth, nickNameLabelHeight);
        self.nickNameOfFriend = [[UILabel alloc] initWithFrame:frameOfNickNameLabel];
        self.nickNameOfFriend.backgroundColor = [UIColor redColor];
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
        self.nameOfFriend.backgroundColor = [UIColor grayColor];
        self.nameOfFriend.font = [UIFont systemFontOfSize:12];
        self.nameOfFriend.textColor = [UIColor whiteColor];
        self.nameOfFriend.textAlignment = UIControlContentVerticalAlignmentCenter;
        self.nameOfFriend.textAlignment = UIControlContentHorizontalAlignmentLeft;
        
        //Update referencepoint of next subview
        startingPointOfSubviewOnY = startingPointOfSubviewOnY + nameofFriendLabelHeight;
        
        //add label for emailOfFriend
        CGFloat emailLabelheight = 15.0;
        
        CGRect frameOfEmailLabel = CGRectMake(startingPointOfSubViewOnX, startingPointOfSubviewOnY, nickNameLabelWidth, emailLabelheight);
        self.emailOfFriend = [[UILabel alloc] initWithFrame:frameOfEmailLabel];
        self.emailOfFriend.backgroundColor = [UIColor greenColor];
        self.emailOfFriend.font = [UIFont italicSystemFontOfSize:12];
        self.emailOfFriend.textColor = [UIColor whiteColor];
        self.emailOfFriend.textAlignment = UIControlContentHorizontalAlignmentLeft;
        self.emailOfFriend.textAlignment = UIControlContentVerticalAlignmentCenter;
        
        
        //add subviews to cell
        [self.contentView addSubview:self.pictureOfFriend];
        [self.contentView addSubview:self.nickNameOfFriend];
        [self.contentView addSubview:self.nameOfFriend];
        [self.contentView addSubview:self.emailOfFriend];
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
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
