//
//  Beckons.h
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Server.h"
#import "Beckon.h"
#import "BeckonCell.h"

@interface Beckons : NSObject

@property (strong, nonatomic) Server *server;
@property (strong, nonatomic) NSMutableArray *beckons;
@property (strong, nonatomic) NSNumber *newestBeckonPointer;

- (void) getUpdates;
- (void) addBeckon: (Beckon*)beckon;
- (void) loadData: (NSArray*)data;

@end
