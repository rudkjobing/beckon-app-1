//
//  Beckon.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 27/05/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "Beckon.h"
#import "AppDelegate.h"
#import "Beckons.h"

@interface Beckon ()

@property (strong, nonatomic) Beckons *beckons;

@end

@implementation Beckon

- (Beckon*) init{
    
    self = [super init];
    self.friends = [[NSMutableArray alloc] init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.server = appDelegate.appState.server;
    self.beckons = appDelegate.appState.beckons;
    return self;
    
}


- (void) flush{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *location = [[NSDictionary alloc] initWithObjectsAndKeys:self.latitude, @"latitude", self.longitude, @"longitude", nil];
        NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:self.title, @"title", self.begins.description, @"begins", self.ends.description, @"ends", location, @"location", self.friends, @"friends", [[NSArray alloc] init], @"groups", nil];
        NSDictionary *object = [[NSDictionary alloc] initWithObjectsAndKeys:data, @"beckon", nil];
        NSDictionary *result = [self.server queryServerDomain:@"beckon" WithCommand:@"addBeckon" andData:object];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"status"] isEqualToNumber:@(1)]){
                NSDictionary *payload = [result objectForKey:@"payload"];
                self.id = [payload objectForKey:@"id"];
                [self.beckons addBeckon:self];
            }
            else{
                
            }
        });
    });
}

- (void) acceptBeckon{
    
}

@end
