//
//  BeckonVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "BeckonVC.h"
#import "AppDelegate.h"
#import "Beckon.h"
#import "Beckons.h"
#import "BeckonCell.h"
#import "ChatRoomVC.h"
#import "ChatRoom.h"

@interface BeckonVC ()
@property (weak, nonatomic) IBOutlet UITableView *beckonTableView;
@property (strong, nonatomic) Beckons *beckons;
@end

@implementation BeckonVC

- (void)viewDidLoad
{
    [super viewDidLoad];
//added backgroundLayer
    CAGradientLayer *bgLayer = [GradientLayers appBlueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    
    self.title = @"Beckons";
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createBeckon)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.beckons = appDelegate.appState.beckons;
    self.beckonTableView.dataSource = self;
    self.beckonTableView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewEnteredForeground) name:UIApplicationWillEnterForegroundNotification object:nil];//Handle being put in the foreground
    [self.beckons addObserver:self forKeyPath:@"newestBeckonPointer" options:0 context:nil];
//added clearcolor background
    self.beckonTableView.backgroundColor = [UIColor clearColor];
    [self.beckonTableView registerClass:[BeckonCell class] forCellReuseIdentifier:@"BeckonCell"];
}


-(void)viewEnteredForeground{
    [self.beckons getUpdates];
}

- (void) viewWillAppear:(BOOL)animated{
    [[self tabBarItem] setBadgeValue: nil];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self.beckonTableView reloadData];
}

- (void)createBeckon{
    [self performSegueWithIdentifier:@"BeckonToCreate" sender:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//Added row height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.beckons.beckons.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"BeckonCell";
    BeckonCell *cell = (BeckonCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[BeckonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    Beckon *beckon = [self.beckons.beckons objectAtIndex:indexPath.row];
    cell.begins = beckon.begins;
    cell.nameOfEventLabel.text = beckon.title;
    cell.placeOfEventLabel.text = @"Not Implemented";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    cell.timeOfEventLabel.text = [formatter stringFromDate:beckon.begins];
    [cell updateLabel];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"BeckonsToBeckon" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"BeckonsToBeckon"]){
        NSIndexPath *index = [self.beckonTableView indexPathForSelectedRow];
        Beckon *beckon = [self.beckons.beckons objectAtIndex:index.row];
        ChatRoomVC *chatRoomVC = [segue destinationViewController];
        beckon.chatRoom.chatRoomVC = chatRoomVC;
        chatRoomVC.dataSource = beckon.chatRoom.chatMessages;
        chatRoomVC.chatRoom = beckon.chatRoom;
    }
}

@end
