//
//  SignUpVC.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "GradientLayers.h"

@interface SignUpVC : UIViewController

@property (strong, nonatomic) User* user;
- (IBAction)textFieldReturn:(id)sender;
@end
