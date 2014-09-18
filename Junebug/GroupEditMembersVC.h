//
//  GroupEditMembersVC.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 19/05/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"
#import "Friends.h"

@interface GroupEditMembersVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) Group *group;
@property (strong, nonatomic) Friends *friends;



@end
