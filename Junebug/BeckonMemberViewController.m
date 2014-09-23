//
//  BeckonMemberViewController.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 06/09/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import "BeckonMemberViewController.h"
#import "BeckonDetailPageVC.h"
#import "MemberCell.h"
#import "BeckonMember.h"
#import "GradientLayers.h"

@interface BeckonMemberViewController ()

@property (weak, nonatomic) IBOutlet UITableView *memberTableView;

@end

@implementation BeckonMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.memberTableView.backgroundColor = [UIColor clearColor];
    
    [self.memberTableView registerClass:[MemberCell class] forCellReuseIdentifier:@"MemberCell"];
    self.memberTableView.dataSource = self;
    self.memberTableView.delegate = self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BeckonDetailPageVC *parentVC = (BeckonDetailPageVC *)self.parentViewController;
    return parentVC.beckon.members.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BeckonDetailPageVC *parentVC = (BeckonDetailPageVC *)self.parentViewController;
    static NSString *cellIdentifier = @"BeckonCell";
    MemberCell *cell = (MemberCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[MemberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    BeckonMember *beckonMember = [parentVC.beckon.members objectAtIndex:indexPath.row];
    cell.name.text = [[beckonMember.user.firstName stringByAppendingString:@" "] stringByAppendingString:beckonMember.user.lastName];
    
    if([beckonMember.status isEqualToString:@"PENDING"]){
        [cell setCellColor: [UIColor colorWithRed:255.0/255.0 green:118.0/255.0 blue:0.0/255.0 alpha:0.6]];
    }
    else if ([beckonMember.status isEqualToString:@"ACCEPTED"]){
//        [cell setCellColor: [UIColor colorWithRed:93.0/255.0 green:119.0/255.0 blue:55.0/255.0 alpha:0.65]];
        [cell setCellColor: [UIColor colorWithRed:36.0/255.0 green:192.0/255.0 blue:154.0/255.0 alpha:1.00]];
    }
    else if ([beckonMember.status isEqualToString:@"REJECTED"]){
//        [cell setCellColor: [UIColor colorWithRed:240.0/255.0 green:31.0/255.0 blue:0.0/255.0 alpha:0.6]];
        [cell setCellColor: [UIColor colorWithRed:255.0/255.0 green:44.0/255.0 blue:107.0/255.0 alpha:1.0]];
    }
//    24BE9A 36 192 154
//    FF186B 255 44 107
    if(beckonMember.isCreator == YES){
        [cell activateCreatorIndicator];
    }
    else{
        [cell deactivateCreatorIndicator];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}


@end
