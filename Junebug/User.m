//
//  User.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "User.h"

@implementation User

-(void) setAuthenticationDelegate:(id<AuthenticationDelegate>)authentication_delegate{
    _authentication_delegate = authentication_delegate;
}
-(void) setSignInDelegate:(id<SignInDelegate>)signin_delegate{
    _signin_delegate = signin_delegate;
}
-(void) setSignUpDelegate:(id<SignUpDelegate>)signup_delegate{
    _signup_delegate = signup_delegate;
}

-(void) loginWithEmail:(NSString *)email andPassword:(NSString *)password{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults stringForKey:@"device_key"]){
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:email, @"email", password, @"password", @"IPhone 5S", @"device_type", @"IOS 7", @"device_os", nil];
            NSDictionary *result = [[Server sharedInstance] queryServerDomain:@"user" WithCommand:@"registerDevice" andData:data];
        
            dispatch_async(dispatch_get_main_queue(), ^{
                if([[result objectForKey:@"success"] isEqualToString:@"1"]){
                    NSDictionary *payload = [result objectForKey:@"payload"];
                    self.email = [payload objectForKey:@"email"];
                    self.auth_key = [payload objectForKey:@"auth_key"];
                    self.device_key = [payload objectForKey:@"device_key"];
                    [_signin_delegate performSelector:@selector(userValidated)];
                }
                else{
                    [_signin_delegate performSelector:@selector(userFailedValidationWithMessage:) withObject:[result objectForKey:@"message"]];
                }
            });
        });
    }
    else{
        
    }
}

-(void) isAuthenticWithEmail: (NSString * )email andAuthKey: (NSString *)authkey andDeviceKey: (NSString *)devicekey{

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:email, @"email", authkey, @"auth_key",devicekey, @"device_key" , nil];
        NSDictionary *result = [[Server sharedInstance] queryServerDomain:@"user" WithCommand:@"authenticate" andData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"success"] isEqualToString:@"1"]){
                NSDictionary *payload = [result objectForKey:@"payload"];
                self.email = [payload objectForKey:@"email"];
                self.auth_key = [payload objectForKey:@"auth_key"];
                self.device_key = [payload objectForKey:@"device_key"];
                /*[defaults setObject:[payload objectForKey:@"authkey"] forKey:@"authkey"];
                [defaults setObject:[payload objectForKey:@"email"] forKey:@"email"];*/
                [_authentication_delegate performSelector:@selector(validUser)];
            }
            else{
                [_authentication_delegate performSelector:@selector(invalidUser)];
            }
        });
    });
}

- (void)signupUserWithEmail:(NSString *)email AndFirstname:(NSString *)firstname AndLastname:(NSString *)lastname AndPassword:(NSString *)password{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        /*Create a dictionary and convert it to json data, then convert it to a string...*/
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                              email, @"email",
                              firstname, @"firstname",
                              lastname, @"lastname",
                              password, @"password",
                              @"555621621", @"phonenumber",
                              @"0001", @"countrycode",
                              nil];
        /*This is where we have a json string that can be sent over the interwebs*/
        NSDictionary *result = [[Server sharedInstance] queryServerDomain:@"user" WithCommand:@"add" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"success"] isEqualToString:@"1"]){
                [_signup_delegate performSelector:@selector(signUpComplete)];
            }
            else{
                [_signup_delegate performSelector:@selector(signUpFailedWithMessage:) withObject:[result objectForKey:@"message"]];
            }
        });
    });
}

@end
