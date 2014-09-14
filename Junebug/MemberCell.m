//
//  MemberCell.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 20/05/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "MemberCell.h"

@implementation MemberCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        //Add new custom subview. Relates to heightforRowAtIndexPath in FriendsVC
        CGFloat heightOfCellInTableView = 65.0;
        
        CGRect rectForContainerView = CGRectMake(self.contentView.frame.origin.x,
                                                 self.contentView.frame.origin.y,
                                                 self.contentView.frame.size.width,
                                                 heightOfCellInTableView);
        
        
        self.containerView = [[UIView alloc] initWithFrame:rectForContainerView];
        
        CGRect rectForSubContainerView = CGRectMake(self.containerView.frame.origin.x +5,
                                                 self.containerView.frame.origin.y + 5,
                                                 self.containerView.frame.size.width -10,
                                                 heightOfCellInTableView);
        
        self.subContainerView = [[UIView alloc] initWithFrame:rectForSubContainerView];
        
        self.subContainerView.backgroundColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.8];
        
//        self.subContainerView.layer.shadowColor = [UIColor blackColor].CGColor;
//        self.subContainerView.layer.shadowOffset = CGSizeMake(0, 1);
//        self.subContainerView.layer.shadowOpacity = 0.3;
//        self.subContainerView.layer.shadowRadius = 3.0;
        
        
        
        CGRect placeMentOfNameOfEventLabel = CGRectMake(self.subContainerView.frame.origin.x + 5, self.subContainerView.frame.origin.x + 5, 180, 20);
        self.firstName = [[UILabel alloc] initWithFrame:placeMentOfNameOfEventLabel];
        self.firstName.font = [UIFont boldSystemFontOfSize:16];
        self.firstName.backgroundColor = [UIColor clearColor];
        self.firstName.textColor = [UIColor blackColor];
        self.firstName.textAlignment = UIControlContentHorizontalAlignmentLeft;
        
        //Set cell opague
        self.backgroundColor = [UIColor clearColor];
        
//        [self.customBeckonCellView.layer setBorderColor:[UIColor clearColor].CGColor];
//        [self.customBeckonCellView.layer setBorderWidth:1.0f];
        
        //add the subviews to contentview of cell
        [self.contentView addSubview:self.containerView];
        [self.containerView addSubview:self.subContainerView];
        [self.self.subContainerView addSubview:self.firstName];
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
