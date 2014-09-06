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
        beckon.beckonDescription = [child objectForKey:@"description"];
        beckon.chatRoomId = [child objectForKey:@"chatRoom"];
        beckon.server = self.server;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-M-d HH:mm:ss"];
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        [dateFormat setTimeZone:timeZone];
        beckon.begins = [dateFormat dateFromString:[child objectForKey:@"begins"]];
        beckon.ends = [dateFormat dateFromString:[child objectForKey:@"ends"]];
        beckon.chatRoom = [[ChatRoom alloc] initWithId: beckon.chatRoomId];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.appState.chatRooms setObject:beckon.chatRoom forKey:beckon.chatRoomId];
        [self.beckons addObject: beckon];
        if([self.newestBeckonPointer integerValue] < [beckon.id integerValue]){
            self.newestBeckonPointer = beckon.id;
        }
    }
    [self purgeExpiredBeckons];
    [self sortBeckons];
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

- (void) sortBeckons{
    NSMutableArray *beckons = [self.beckons mutableCopy];
    for(int i = 0; i < beckons.count; i++){
        Beckon *first = [beckons objectAtIndex:i];
        NSDate *firstDate = first.ends;
        for(int j = 0; j < beckons.count; j++){
            Beckon *second = [beckons objectAtIndex:j];
            NSDate *secondDate = second.ends;
            if([[firstDate earlierDate:secondDate] isEqualToDate:firstDate]){
                beckons[i] = second;
                beckons[j] = first;
                first = [beckons objectAtIndex:i];
                firstDate = first.ends;
            }
        }
    }
    self.beckons = beckons;
    self.newestBeckonPointer = self.newestBeckonPointer;
}

- (void) purgeExpiredBeckons{
    NSDate *now = [[NSDate alloc] init];
    NSArray *tempArr = [self.beckons copy];
    for(Beckon *beckon in tempArr){
        if(![[beckon.ends earlierDate:now] isEqualToDate:now]){
            [self.beckons removeObject:beckon];
            self.newestBeckonPointer = self.newestBeckonPointer;
        }
        else{
            
        }
    }
}

@end
