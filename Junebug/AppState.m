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
    if([defaults stringForKey:@"cookieId"] && [defaults stringForKey:@"cookie"]){
        self.server.cookieId = [defaults stringForKey:@"cookieId"];
        self.server.cookie = [defaults stringForKey:@"cookie"];
        [self getState];
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AppStateNotReady" object:self];
    }
}

- (void) signInUsingEmail: (NSString *) email AndPassword: (NSString *) password{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:email, @"email", password, @"password", nil];
        NSDictionary *result = [self.server queryServerDomain:@"user" WithCommand:@"signIn" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"status"] isEqualToNumber:@(1)]){
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSDictionary *payload = [result objectForKey:@"payload"];
                NSDictionary *cookie = [payload objectForKey:@"cookie"];
                self.server.cookieId = [cookie objectForKey:@"id"];
                [defaults setObject:self.server.cookieId forKey:@"id"];
                self.server.cookie = [cookie objectForKey:@"cookie"];
                [defaults setObject:self.server.cookie forKey:@"cookie"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AppStateReady" object:self];
            }
            else{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AppStateNotReady" object:self userInfo:result];
            }
        });
    });
}

- (void) getState{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [[NSDictionary alloc] init];
        NSDictionary *result = [self.server  queryServerDomain:@"user" WithCommand:@"getState" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"status"] isEqualToNumber:@(1)]){
                //[[NSNotificationCenter defaultCenter] postNotificationName:@"AppStateReady" object:self];
            }
            else{
                [defaults removeObjectForKey:@"cookieId"];
                [defaults removeObjectForKey:@"cookie"];
                [self applicationReady];
            }
        });
    });
}

- (void) updateNotificationToken{
    if(self.server.email && self.server.auth_key && self.server.device_key){
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:self.token , @"notification_key", nil];
            NSDictionary *result = [self.server  queryServerDomain:@"user" WithCommand:@"updateNotificationKey" andData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                if([[result objectForKey:@"success"] isEqualToString:@"1"]){
                    
                }
                else{
                    
                }
            });
        });
    }
}

- (void) signUpWithEmail: (NSString *)email Password: (NSString *)password Firstname: (NSString *)firstname Lastname: (NSString *)lastname{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:email, @"email", password, @"password", firstname, @"firstName", lastname, @"lastName", nil];
        NSDictionary *result = [self.server  queryServerDomain:@"user" WithCommand:@"signUp" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"status"] isEqualToNumber:@(1)]){
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
