//
//  User.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Server.h"

@protocol SignUpDelegate <NSObject>

-(void) signUpComplete;
-(void) signUpFailedWithMessage: (NSString *)message;

@end

@protocol AuthenticationDelegate <NSObject>

-(void) validUser;
-(void) invalidUser;

@end

@protocol SignInDelegate <NSObject>

-(void) userValidated;
-(void) userFailedValidationWithMessage: (NSString *)message;

@end

@interface User : NSObject{
    id <AuthenticationDelegate> _authentication_delegate;
    id <SignInDelegate> _signin_delegate;
    id <SignUpDelegate> _signup_delegate;
}

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *auth_key;
@property (strong, nonatomic) NSString *device_key;

-(void) setSignInDelegate:(id<SignInDelegate>)signin_delegate;
-(void) setSignUpDelegate:(id<SignUpDelegate>)signup_delegate;
-(void) setAuthenticationDelegate:(id<AuthenticationDelegate>)authentication_delegate;

-(void) loginWithEmail:(NSString *)email andPassword:(NSString *)password;
-(void) isAuthenticWithEmail: (NSString * )email andAuthKey: (NSString *)authkey andDeviceKey: (NSString *)devicekey;
- (void)signupUserWithEmail:(NSString *)email AndFirstname:(NSString *)firstname AndLastname:(NSString *)lastname AndPassword:(NSString *)password;

@end
