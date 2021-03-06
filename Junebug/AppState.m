//
//  AppState.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 12/05/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import "AppState.h"
#import "ChatMessage.h"
#import "ChatRoom.h"
#import <AudioToolbox/AudioServices.h>

@interface AppState ()

@property (nonatomic,strong,readwrite) NSMutableArray* delegates;

@end

@implementation AppState

- (void) handleNotification: (NSDictionary *)userInfo{
    NSLog(@"%@", userInfo);
    NSString *updateType = [[userInfo objectForKey:@"prm"] objectForKey:@"ut"];
    NSString *destinationId = [[userInfo objectForKey:@"prm"] objectForKey:@"did"];
    if([updateType isEqualToString:@"ChatRoom"]){
        for(Beckon *beckon in self.beckons.beckons){
            if([beckon.chatRoom.id isEqualToString:destinationId] && beckon.isInFocus){
                [beckon.chatRoom sync];            }
        }
        [self.beckons getUpdates];
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    else if([updateType isEqualToString:@"Beckon"]){
        [self.beckons getUpdates];
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
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
                [defaults setObject:self.server.cookieId forKey:@"cookieId"];
                self.server.cookie = [cookie objectForKey:@"cookie"];
                [defaults setObject:self.server.cookie forKey:@"cookie"];
                self.userId = [payload objectForKey:@"userId"];
                [defaults setObject:self.userId forKey:@"userId"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SignInSuccess" object:self];
            }
            else{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SignInFailure" object:self userInfo:result];
            }
        });
    });
}

- (void) getState{
    /*dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [[NSDictionary alloc] init];
        NSDictionary *result = [self.server  queryServerDomain:@"user" WithCommand:@"getState" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"status"] isEqualToNumber:@(1)]){
                NSArray *beckons = [[[result objectForKey:@"payload"] objectForKey:@"user" ]objectForKey:@"beckons"];
                NSArray *friends = [[[result objectForKey:@"payload"] objectForKey:@"user" ]objectForKey:@"friends"];
                NSArray *groups = [[[result objectForKey:@"payload"] objectForKey:@"user" ]objectForKey:@"groups"];
                self.userId = [result objectForKey:@"id"];
                [self.beckons loadData:beckons];
                [self.friends loadData:friends];
                [self.groups loadData:groups];
            }
            else{
                
            }
        });
    });*/
    [self.groups getAllGroups];
    [self.friends getAllFriends];
    [self.beckons getUpdates];
}

- (void) updateNotificationToken{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:self.token , @"notificationKey", @"APPLEIOS", @"type", nil];
        NSDictionary *result = [self.server  queryServerDomain:@"device" WithCommand:@"registerDevice" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"status"] isEqualToNumber:@(1)]){
                
            }
            else{
                
            }
        });
    });
}

- (void) signOut{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [[NSDictionary alloc]init];
        NSDictionary *result = [self.server  queryServerDomain:@"user" WithCommand:@"signOut" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"status"] isEqualToNumber:@(1)]){
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                self.server.cookie = nil;
                self.server.cookieId = nil;
                [defaults removeObjectForKey:@"cookieId"];
                [defaults removeObjectForKey:@"cookie"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"UserSignOutSuccess" object:self userInfo:result];
            }
            else{
                
            }
        });
    });
}

- (void) signUpWithEmail: (NSString *)email Password: (NSString *)password Firstname: (NSString *)firstname Lastname: (NSString *)lastname{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:email, @"email", password, @"password", firstname, @"firstName", lastname, @"lastName", nil];
        NSDictionary *result = [self.server  queryServerDomain:@"user" WithCommand:@"signUp" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"status"] isEqualToNumber:@(1)]){
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSDictionary *payload = [result objectForKey:@"payload"];
                NSDictionary *cookie = [payload objectForKey:@"cookie"];
                self.server.cookieId = [cookie objectForKey:@"id"];
                [defaults setObject:self.server.cookieId forKey:@"cookieId"];
                self.server.cookie = [cookie objectForKey:@"cookie"];
                [defaults setObject:self.server.cookie forKey:@"cookie"];
                self.userId = [payload objectForKey:@"userId"];
                [defaults setObject:self.userId forKey:@"userId"];
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

- (NSMutableDictionary *) chatRooms{
    if(!_chatRooms){
        _chatRooms = [[NSMutableDictionary alloc] init];
    }
    return _chatRooms;
}

@end
