//
//  FriendChatVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 01/06/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "ChatRoomVC.h"
#import "ChatMessage.h"
#import "AppDelegate.h"

@interface ChatRoomVC ()



@end

@implementation ChatRoomVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.dataSource = [[NSMutableArray alloc] init];
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
        cell.contentInsets = UIEdgeInsetsMake(0, 3.0f, 0, 0); //Move content for 3 pt. to right
        cell.textView.textColor = [UIColor blackColor];
        cell.timeLabel.text = @"321";
    } else {
        cell.contentInsets = UIEdgeInsetsMake(0, 0, 0, 3.0f); //Move content for 3 pt. to left
        cell.textView.textColor = [UIColor whiteColor];
        cell.timeLabel.text = @"123";
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
    
    ChatMessage *msg = [[ChatMessage alloc] initWithChatRoomId:self.chatRoomId andMessage:message];
    [msg flush];
    msg.text = message;
    
    [self sendMessage:msg];
}

- (void)messageInputViewDidSelectMediaButton:(SOMessageInputView *)inputView
{
    // Take a photo/video or choose from gallery
}

@end
