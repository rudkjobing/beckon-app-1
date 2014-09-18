//
//  ChatRoomCell.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 03/06/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import "ChatRoomCell.h"

@implementation ChatRoomCell

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
