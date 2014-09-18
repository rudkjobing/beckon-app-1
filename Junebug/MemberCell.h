//
//  MemberCell.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 20/05/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberCell : UITableViewCell

@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) UIView *subContainerView;
@property (strong,nonatomic) UILabel *firstName;
@property (strong,nonatomic) UILabel *lastName;
@property (strong, nonatomic) UILabel *statusLabel;

@end
