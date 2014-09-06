//
//  FriendCell.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 18/05/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface FriendCell : UITableViewCell

@property (strong, nonatomic) UILabel *nickNameOfFriend;
@property(strong, nonatomic) UILabel *nameOfFriend;
@property(strong, nonatomic) UILabel *emailOfFriend;
@property(strong, nonatomic) UIView *customSubview;
@property(strong, nonatomic) UIImageView *pictureOfFriend;

@end
