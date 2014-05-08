//
//  SignUpVC.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface SignUpVC : UIViewController<SignUpDelegate>

@property (strong, nonatomic) User* user;
- (IBAction)textFieldReturn:(id)sender;
@end
