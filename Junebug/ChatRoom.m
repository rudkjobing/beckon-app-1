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
#import "Convertions.h"

@interface ChatRoom ()

@property (strong, nonatomic) Server *server;

@end

@implementation ChatRoom

- (ChatRoom*) initWithId: (NSString *)id{
    self = [super init];
    _chatMessages = [[NSMutableArray alloc] init];
    self.id = id;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.server = appDelegate.appState.server;
    return self;
}

- (void) sync{
    /*dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{*/
        NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:self.id, @"chatRoomId", nil];
        /*This is where we have a json string that can be sent over the interwebs*/
        NSDictionary *result = [self.server queryServerDomain:@"chatRoom" WithCommand:@"getChatRoomMessages" andData:data];
        /*dispatch_async(dispatch_get_main_queue(), ^{*/
            if([[result objectForKey:@"status"] isEqualToNumber:@(1)]){
                NSArray *payload = [[result objectForKey:@"payload"] objectForKey:@"messages"];
                [self loadData:payload];
            }
            else{
                
            }
       /* });
    });*/
}

- (void) loadData:(NSArray*)data{
    [self.chatMessages removeAllObjects];
    [self.chatRoomVC refreshMessages];
    for(NSDictionary *child in data){
        ChatMessage *chatMessage = [[ChatMessage alloc] init];
        chatMessage.text = [child objectForKey:@"message"];
        chatMessage.type = SOMessageTypeText;
        chatMessage.from = [child objectForKey:@"from"];
        chatMessage.date = [Convertions dateFromString:[child objectForKey:@"date"]];

        if([[child objectForKey:@"fromMe"] isEqualToNumber:@(1)]){
            [self.chatRoomVC sendMessage: chatMessage];
        }
        else{
            [self.chatRoomVC receiveMessage: chatMessage];
        }
    }
}

- (void) recieveMessage: (ChatMessage *)chatMessage{
    [self.chatRoomVC receiveMessage: chatMessage];
}

- (NSMutableArray *)chatMessages{
    if(!_chatMessages){
        _chatMessages = [[NSMutableArray alloc] init];
    }
    return _chatMessages;
}

                            
@end
