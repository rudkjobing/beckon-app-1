//
//  ChatRoom.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 30/06/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "ChatRoom.h"
#import "Server.h"
#import "AppDelegate.h"
#import "ChatMessage.h"

@interface ChatRoom ()

@property (strong, nonatomic) Server *server;

@end

@implementation ChatRoom

- (ChatRoom*) initWithId: (NSString *)id{
    self = [super init];
    self.id = id;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.server = appDelegate.appState.server;
    return self;
}

- (void) sync{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:self.id, @"chatRoomId", nil];
        /*This is where we have a json string that can be sent over the interwebs*/
        NSDictionary *result = [self.server queryServerDomain:@"chatRoom" WithCommand:@"getChatRoomMessages" andData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"success"] isEqualToString:@"1"]){
                NSArray *payload = [result objectForKey:@"payload"];
                [self loadData:payload];
            }
            else{
                
            }
        });
    });
}

- (void) loadData:(NSArray*)data{
    [self.chatMessages removeAllObjects];
    for(NSDictionary *child in data){
        ChatMessage *chatMessage = [[ChatMessage alloc] init];
        chatMessage.message = [child objectForKey:@"message"];
        [self.chatMessages addObject: chatMessage];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadChatRoomTableView" object:self];
}

- (NSMutableArray *)chatMessages{
    if(!_chatMessages){
        _chatMessages = [[NSMutableArray alloc] init];
    }
    return _chatMessages;
}

@end
