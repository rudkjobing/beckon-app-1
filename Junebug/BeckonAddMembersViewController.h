//
//  BeckonAddMembersViewController.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 03/10/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Beckon.h"

@interface BeckonAddMembersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) Beckon *beckon;

@end
