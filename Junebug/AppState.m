//
//  AppState.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 12/05/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "AppState.h"

@interface AppState ()

@property (nonatomic,strong,readwrite) NSMutableArray* delegates;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *auth_key;
@property (strong, nonatomic) NSString *device_key;

@end

@implementation AppState

- (void) applicationReady{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(self.email && self.auth_key && self.device_key){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AppDidAutoLogin" object:self];
    }
    else if([defaults stringForKey:@"email"] && [defaults stringForKey:@"device_key"] && [defaults stringForKey:@"auth_key"]){
        self.email = [defaults stringForKey:@"email"];
        self.auth_key = [defaults stringForKey:@"auth_key"];
        self.device_key = [defaults stringForKey:@"device_key"];
        [self applicationReady];
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UserMustLogIn" object:self];
    }
}

- (void) registerDeviceUsingEmail: (NSString *) email AndPassword: (NSString *) password{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:email, @"email", password, @"password", [UIDevice currentDevice].model, @"device_type", [[UIDevice currentDevice] systemVersion], @"device_os", nil];
        NSDictionary *result = [self.server  queryServerDomain:@"user" WithCommand:@"registerDevice" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"success"] isEqualToString:@"1"]){
                NSDictionary *payload = [result objectForKey:@"payload"];
                self.email = [payload objectForKey:@"email"];
                self.auth_key = [payload objectForKey:@"auth_key"];
                self.device_key = [payload objectForKey:@"device_key"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AppState_Ready" object:self];
            }
            else{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AppState_NotReady" object:self userInfo:result];
            }
        });
    });
}

- (void) startSessionUsingEmail: (NSString *) email AndPassword: (NSString *) password{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults stringForKey:@"device_key"]){
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:email, @"email", password, @"password", nil];
            NSDictionary *result = [self.server  queryServerDomain:@"user" WithCommand:@"registerDevice" andData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                if([[result objectForKey:@"success"] isEqualToString:@"1"]){
                    NSDictionary *payload = [result objectForKey:@"payload"];
                    self.email = [payload objectForKey:@"email"];
                    self.auth_key = [payload objectForKey:@"auth_key"];
                    self.device_key = [payload objectForKey:@"device_key"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"ApplicationReady" object:self];
                }
                else{
                    NSLog(@"%@", [result objectForKey:@"message"]);
                }
            });
        });
    }
    else{
        
    }
}

- (Server *) server{
    if(!_server){
        _server = [[Server alloc] init];
    }
    return _server;
}

- (Friends *) friends{
    if(!_friends){
        _friends = [[Friends alloc] init];
        _friends.server = self.server;
    }
    return _friends;
}

@end
