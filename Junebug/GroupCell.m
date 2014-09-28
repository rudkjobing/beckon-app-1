//
//  GroupCell.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 17/05/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import "GroupCell.h"

@implementation GroupCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat heightOfCellInTableView = 45.0;
        
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
        
        CGRect frame = CGRectMake(self.subContainerView.frame.origin.x,
                                  self.subContainerView.frame.origin.y,
                                  self.subContainerView.frame.size.width,
                                  35);
        self.nameOfGroup = [[UILabel alloc] initWithFrame:frame];
        self.nameOfGroup.backgroundColor = [UIColor clearColor];
        self.nameOfGroup.font = [UIFont boldSystemFontOfSize:20];
        self.nameOfGroup.textAlignment = NSTextAlignmentCenter;
        self.nameOfGroup.textColor = [UIColor whiteColor];
        
        self.isActivated = NO;
        
        //add subviews to cell
        [self.containerView addSubview:self.subContainerView];
        [self.contentView addSubview:self.containerView];
        
        [self.subContainerView addSubview:self.nameOfGroup];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{

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
