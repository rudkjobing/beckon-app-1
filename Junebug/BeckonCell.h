//
//  BeckonCell.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/05/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeckonCell : UITableViewCell

@property (strong, nonatomic) UIView *customBeckonCellView;
@property(strong,nonatomic) UILabel *nameOfEventLabel;
@property(strong,nonatomic) UILabel *placeOfEventLabel;
@property(strong,nonatomic) UILabel *timeOfEventLabel;
@property(strong,nonatomic) UILabel *timerLabel;
@property(strong,nonatomic) NSDate *begins;
@property(strong, nonatomic) UIImageView *beckonIconImage;
@property (strong, nonatomic) UILabel *statusLabel;
@property (strong, nonatomic) UIImageView *chatImageView;
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) UIView *subContainerView;

- (void) setCellColor:(UIColor*)color;
- (void) startTimer;
- (void) updateLabel;
- (void) activateChatIndicator;
- (void) deactivateChatIndicator;


@end
