//
//  BeckonPickFriendsVC.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/05/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friends.h"
#import "Beckon.h"
#import "FriendCell.h"
#import "AppDelegate.h"

@interface BeckonPickFriendsVC : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) Friends *friends;
@property (strong, nonatomic) Beckon *beckon;

@end
