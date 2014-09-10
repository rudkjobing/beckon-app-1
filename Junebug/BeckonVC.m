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
#import "BeckonDetailPageVC.h"

@interface BeckonVC ()
@property (weak, nonatomic) IBOutlet UITableView *beckonTableView;
@property (strong, nonatomic) Beckons *beckons;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *userLocation;
@end

@implementation BeckonVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//added backgroundLayer
    CAGradientLayer *bgLayer = [GradientLayers appBlueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(goToSignIn:)
     name:@"UserMustSignIn"
     object:nil];
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
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
            [self.locationManager requestAlwaysAuthorization];
            [self.locationManager requestWhenInUseAuthorization];
        }
        self.locationManager.delegate = self;
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [self.locationManager setDesiredAccuracy:kCLDistanceFilterNone];
        
        
    }

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    for(CLLocation *location in locations){
        self.userLocation = location;
    }
    [self.locationManager stopUpdatingLocation];
}

-(void) goToSignIn:(NSNotification*) notification{
    [self performSegueWithIdentifier:@"LoginModal" sender:self];
}

-(void)viewEnteredForeground{
    [self.locationManager startUpdatingLocation];
    [self.beckons getUpdates];
}

- (void) viewWillAppear:(BOOL)animated{
    [self.locationManager startUpdatingLocation];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.appState getState];
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
    return 65;
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
    CLLocation *beckonLocation = [[CLLocation alloc] initWithLatitude:[beckon.latitude doubleValue] longitude:[beckon.longitude doubleValue]];
    CLLocationDistance distance = [self.userLocation distanceFromLocation:beckonLocation];
    if(distance < 1000 && distance > 100){
        cell.placeOfEventLabel.text = @"You are allmost there";
    }
    else if (distance < 100){
        cell.placeOfEventLabel.text = @"You are there";
    }
    else{
        distance = distance / 1000;
        NSString *distanceString = [NSString stringWithFormat: @"%f", distance];
        cell.placeOfEventLabel.text = distanceString;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
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
        UINavigationController *nav = [segue destinationViewController];
//        BeckonDetailPageVC *pageVC = [segue destinationViewController];
        BeckonDetailPageVC *pageVC = [[nav viewControllers] objectAtIndex:0];
//        beckon.chatRoom.chatRoomVC = chatRoomVC;
//        chatRoomVC.dataSource = beckon.chatRoom.chatMessages;
//        chatRoomVC.chatRoom = beckon.chatRoom;
        pageVC.beckon = beckon;
        [self.beckonTableView deselectRowAtIndexPath:index animated:NO];
    }
}

@end
