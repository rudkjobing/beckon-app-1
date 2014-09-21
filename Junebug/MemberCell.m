//
//  MemberCell.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 20/05/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import "MemberCell.h"

@implementation MemberCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        //Add new custom subview. Relates to heightforRowAtIndexPath in FriendsVC
        CGFloat heightOfCellInTableView = 40.0;
        
        
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(self.contentView.frame.origin.x,
                                                                      self.contentView.frame.origin.y,
                                                                      self.contentView.frame.size.width,
                                                                      heightOfCellInTableView)];
        
      
        self.subContainerView = [[UIView alloc] initWithFrame:CGRectMake(self.containerView.frame.origin.x + 2,
                                                                         self.containerView.frame.origin.y + 2,
                                                                         self.containerView.frame.size.width -4,
                                                                         heightOfCellInTableView -4)];
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(self.subContainerView.frame.origin.x, self.subContainerView.frame.origin.y, 220, 30)];
        self.name.font = [UIFont boldSystemFontOfSize:22];
        self.name.backgroundColor = [UIColor clearColor];
        self.name.textColor = [UIColor whiteColor];
        self.name.textAlignment = UIControlContentHorizontalAlignmentLeft;
        
        self.creatorIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.containerView.frame.size.width - 25, self.subContainerView.frame.origin.y + 8, 20, 20)];
        self.creatorIconImageView.image = [UIImage imageNamed:@"creatoricon.png"];
        
        //Set cell opague
        self.backgroundColor = [UIColor clearColor];
        
//        [self.customBeckonCellView.layer setBorderColor:[UIColor clearColor].CGColor];
//        [self.customBeckonCellView.layer setBorderWidth:1.0f];
        
        //add the subviews to contentview of cell
        [self.contentView addSubview:self.containerView];
        [self.containerView addSubview:self.subContainerView];
        [self.self.subContainerView addSubview:self.name];
    }
    return self;
}

- (void) activateCreatorIndicator{
    [self.containerView addSubview:self.creatorIconImageView];
}

- (void) deactivateCreatorIndicator{
    [self.creatorIconImageView removeFromSuperview];
}

- (void) setCellColor:(UIColor*)color{
    self.subContainerView.backgroundColor = color;
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
