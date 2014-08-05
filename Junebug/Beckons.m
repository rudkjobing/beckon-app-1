//
//  Beckons.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "Beckons.h"
#import "ChatRoom.h"
#import "AppDelegate.h"
#import "Convertions.h"


@implementation Beckons

- (Beckons *) init{
    self = [super init];
    [self startTimer];
    return self;
}

- (void) getUpdates{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:self.newestBeckonPointer, @"newestBeckonId", nil];
        NSDictionary *result = [self.server  queryServerDomain:@"beckon" WithCommand:@"getBeckons" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"status"] isEqualToNumber:@(1)]){
                NSArray *beckons = [[result objectForKey:@"payload"] objectForKey:@"beckons"];
                [self loadData:beckons];
            }
            else{
                
            }
        });
    });
}

- (void) loadData:(NSArray*)data{
    [self.beckons removeAllObjects];
    for(NSDictionary *child in data){
        Beckon *beckon = [[Beckon alloc] init];
        beckon.id = [child objectForKey:@"id"];
        beckon.title = [child objectForKey:@"title"];
        beckon.chatRoomId = [[child objectForKey:@"chatRoom"] objectForKey:@"id"];
        beckon.server = self.server;
        beckon.begins = [Convertions dateFromString:[child objectForKey:@"begins"]];
        beckon.ends = [child objectForKey:@"ends"];
        beckon.chatRoom = [[ChatRoom alloc] initWithId: beckon.chatRoomId];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.appState.chatRooms setObject:beckon.chatRoom forKey:beckon.chatRoomId];
        [self.beckons addObject: beckon];
        if([self.newestBeckonPointer integerValue] < [beckon.id integerValue]){
            self.newestBeckonPointer = beckon.id;
        }
    }
    [self purgeExpiredBeckons];
}

- (void) addBeckon:(Beckon *)beckon{
    [self.beckons addObject: beckon];
    if(self.newestBeckonPointer < beckon.id){
        self.newestBeckonPointer = beckon.id;
    }
}

- (NSMutableArray *)beckons{
    if(!_beckons){
        _beckons = [[NSMutableArray alloc] init];
    }
    return _beckons;
}

- (NSNumber *)newestBeckonPointer{
    if(!_newestBeckonPointer){
        _newestBeckonPointer = [[NSNumber alloc] initWithInt:0];
    }
    return _newestBeckonPointer;
}

- (void) startTimer{
    NSTimer *timer = [[NSTimer alloc] init];
    timer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(purgeExpiredBeckons) userInfo:nil repeats:YES];
    
}



- (void) purgeExpiredBeckons{
    NSDate *now = [[NSDate alloc] init];
    NSArray *tempArr = [self.beckons copy];
    for(Beckon *beckon in tempArr){
        if(![[[Convertions dateFromString:beckon.ends] earlierDate:now] isEqualToDate:now]){
            [self.beckons removeObject:beckon];
            self.newestBeckonPointer = self.newestBeckonPointer;
        }
    }
}

@end
