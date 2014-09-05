//
//  FriendChatVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 01/06/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "ChatRoomVC.h"
#import "ChatRoom.h"
#import "ChatMessage.h"
#import "AppDelegate.h"
#import "GradientLayers.h"

@interface ChatRoomVC ()



@end

@implementation ChatRoomVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    CAGradientLayer * bgLayer = [GradientLayers appBlueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.chatRoom sync];
}

-(void) viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewEnteredForeground) name:UIApplicationWillEnterForegroundNotification object:nil];//Handle being put in the foreground
}

-(void)viewEnteredForeground{
    [self.chatRoom sync];
}

-(void) viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (NSMutableArray *)messages
{
    return self.dataSource;
    //return array of SOMessage objects
}

- (void)configureMessageCell:(SOMessageCell *)cell forMessageAtIndex:(NSInteger)index
{
    ChatMessage *message = self.dataSource[index];
    
    // Customize balloon as you wish
    if (!message.fromMe) {
        cell.contentInsets = UIEdgeInsetsMake(0, 4.0f, 0, 0); //Move content for 3 pt. to right
        cell.textView.textColor = [UIColor blackColor];
        cell.nameLabel.text = message.from;
    } else {
        cell.contentInsets = UIEdgeInsetsMake(0, 0, 0, 4.0f); //Move content for 3 pt. to left
        cell.textView.textColor = [UIColor blackColor];
    }
}

- (void)didSelectMedia:(NSData *)media inMessageCell:(SOMessageCell *)cell
{
    // Show selected media in fullscreen
    [super didSelectMedia:media inMessageCell:cell];
}

- (void)messageInputView:(SOMessageInputView *)inputView didSendMessage:(NSString *)message
{
    if (![[message stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        return;
    }
    
    ChatMessage *msg = [[ChatMessage alloc] initWithChatRoomId:self.chatRoom.id andMessage:message];
    [msg flush];
    msg.text = message;
    
    [self sendMessage:msg];
}

- (void)messageInputViewDidSelectMediaButton:(SOMessageInputView *)inputView
{
    // Take a photo/video or choose from gallery
}

@end
