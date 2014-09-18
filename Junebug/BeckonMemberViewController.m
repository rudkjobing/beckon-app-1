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
    CAGradientLayer *bgLayer = [GradientLayers appBlueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    self.memberTableView.backgroundColor = [UIColor clearColor];
    
    [self.memberTableView registerClass:[MemberCell class] forCellReuseIdentifier:@"MemberCell"];
    self.memberTableView.dataSource = self;
    self.memberTableView.delegate = self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
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
    cell.firstName.text = [[[beckonMember.user.firstName stringByAppendingString:@" ("] stringByAppendingString:beckonMember.status] stringByAppendingString:@")"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}


@end
