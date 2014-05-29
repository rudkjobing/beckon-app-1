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

@end

@implementation AppState

- (void) applicationReady{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(self.server.email && self.server.auth_key && self.server.device_key){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AppStateReady" object:self];
    }
    else if([defaults stringForKey:@"email"] && [defaults stringForKey:@"device_key"] && [defaults stringForKey:@"auth_key"]){
        self.server.email = [defaults stringForKey:@"email"];
        self.server.auth_key = [defaults stringForKey:@"auth_key"];
        self.server.device_key = [defaults stringForKey:@"device_key"];
        [self applicationReady];
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AppStateNotReady" object:self];
    }
}

- (void) registerDeviceUsingEmail: (NSString *) email AndPassword: (NSString *) password{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:email, @"email", password, @"password", [UIDevice currentDevice].model, @"device_type", [[UIDevice currentDevice] systemVersion], @"device_os", nil];
        NSDictionary *result = [self.server  queryServerDomain:@"user" WithCommand:@"registerDevice" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"success"] isEqualToString:@"1"]){
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

                NSDictionary *payload = [result objectForKey:@"payload"];
                self.server.email = [payload objectForKey:@"email"];
                [defaults setObject:self.server.email forKey:@"email"];
                self.server.auth_key = [payload objectForKey:@"auth_key"];
                [defaults setObject:self.server.auth_key forKey:@"auth_key"];
                self.server.device_key = [payload objectForKey:@"device_key"];
                [defaults setObject:self.server.device_key forKey:@"device_key"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AppStateReady" object:self];
            }
            else{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AppStateNotReady" object:self userInfo:result];
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
                    self.server.email = [payload objectForKey:@"email"];
                    self.server.auth_key = [payload objectForKey:@"auth_key"];
                    self.server.device_key = [payload objectForKey:@"device_key"];
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

- (void) signUpWithEmail: (NSString *)email Password: (NSString *)password Firstname: (NSString *)firstname Lastname: (NSString *)lastname Phonenumber: (NSString *)phonenumber{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:email, @"email", password, @"password", firstname, @"firstname", lastname, @"lastname", phonenumber, @"phonenumber", @"45", @"countrycode", [UIDevice currentDevice].model, @"device_type", [[UIDevice currentDevice] systemVersion], @"device_os", nil];
        NSDictionary *result = [self.server  queryServerDomain:@"user" WithCommand:@"put" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"success"] isEqualToString:@"1"]){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"UserSignedUp" object:self];
            }
            else{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"UserSignupFailed" object:self userInfo:result];
            }
        });
    });
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

- (Groups *) groups{
    if(!_groups){
        _groups = [[Groups alloc] init];
        _groups.server = self.server;
    }
    return _groups;
}

- (Beckons *) beckons{
    if(!_beckons){
        _beckons = [[Beckons alloc] init];
        _beckons.server = self.server;
    }
    return _beckons;
}

@end
