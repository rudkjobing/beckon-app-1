//
//  FriendChatVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 01/06/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "ChatRoomVC.h"

@interface ChatRoomVC ()

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation ChatRoomVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSource = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
    NSMutableArray *result = [NSMutableArray new];
    SOMessage *message = [[SOMessage alloc] init];
        message.fromMe = YES;
        message.text = @"Welcome";
        message.type = SOMessageTypeText;
        message.date = [NSDate date];
        
            SOMessage *prevMesage = result.lastObject;
            message.date = [NSDate dateWithTimeInterval:((10 % 2) ? 2 * 24 * 60 * 60 : 120) sinceDate:prevMesage.date];
        [result addObject:message];

    
    self.dataSource = result;
}

- (NSMutableArray *)messages
{
    
    
    
    return self.dataSource;
    //return array of SOMessage objects
}

- (void)configureMessageCell:(SOMessageCell *)cell forMessageAtIndex:(NSInteger)index
{
    SOMessage *message = self.dataSource[index];
    
    // Customize balloon as you wish
    if (message.fromMe) {
        
    } else {
        
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
    
    SOMessage *msg = [[SOMessage alloc] init];
    msg.text = message;
    msg.fromMe = YES;
    
    [self sendMessage:msg];
}

- (void)messageInputViewDidSelectMediaButton:(SOMessageInputView *)inputView
{
    // Take a photo/video or choose from gallery
}

@end
