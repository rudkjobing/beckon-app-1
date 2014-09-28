//
//  GroupCell.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 17/05/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupCell : UITableViewCell

@property(strong, nonatomic) UILabel *nameOfGroup;
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) UIView *subContainerView;
@property (assign) BOOL isActivated;

- (void)setActivated;
- (void)setDeactivated;

@end
