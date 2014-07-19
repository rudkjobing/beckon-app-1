//
//  ChatMessage.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 30/06/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "ChatMessage.h"
#import "AppDelegate.h"
#import "Server.h"

@interface ChatMessage()

@property (strong, nonatomic) Server *server;

@end

@implementation ChatMessage

- (ChatMessage*) initWithChatRoomId: (NSString*)id andMessage: (NSString*) message{
    self = [super init];
    self.id = id;//ChatRoom ID
    self.text = message;
    self.message = message;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.server = appDelegate.appState.server;
    return self;
}

- (void) flush{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:self.message, @"message", self.id, @"chatRoom", nil];
        NSDictionary *object = [[NSDictionary alloc] initWithObjectsAndKeys:data, @"chatMessage", nil];
        NSDictionary *result = [self.server queryServerDomain:@"chatRoom" WithCommand:@"putChatRoomMessage" andData:object];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"status"] isEqualToNumber:@(1)]){

            }
            else{
                
            }
        });
    });
}

@end
