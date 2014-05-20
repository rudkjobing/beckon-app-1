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
