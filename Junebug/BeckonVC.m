//
//  BeckonVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
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
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *beckonTableView;
@property (strong, nonatomic) Beckons *beckons;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *userLocation;
@end

@implementation BeckonVC

dispatch_once_t onceToken;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//added backgroundLayer
//    CAGradientLayer *bgLayer = [GradientLayers appBlueGradient];
//    bgLayer.frame = self.view.bounds;
//    [self.view.layer insertSublayer:bgLayer atIndex:0];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(goToSignIn:)
     name:@"UserMustSignIn"
     object:nil];
    self.title = @"Beckons";
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createBeckon)];
    addButton.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = addButton;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.beckons = appDelegate.appState.beckons;
    self.beckonTableView.dataSource = self;
    self.beckonTableView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewEnteredForeground) name:UIApplicationWillEnterForegroundNotification object:nil];//Handle being put in the foreground
    [self.beckons addObserver:self forKeyPath:@"newestBeckonPointer" options:0 context:nil];

    self.beckonTableView.backgroundColor = [UIColor clearColor];
    
    /*Register for remote notifications*/
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
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
    dispatch_once(&onceToken, ^{
        [self performSegueWithIdentifier:@"LoginModal" sender:self];
    });
}

-(void)viewEnteredForeground{
    [self.activityIndicator startAnimating];
    [self.locationManager startUpdatingLocation];
    [self.beckons getUpdates];
}

- (void) viewDidDisappear:(BOOL)animated{
    [self.activityIndicator stopAnimating];
}

- (void) viewWillAppear:(BOOL)animated{
    [self.activityIndicator startAnimating];
    [self.locationManager startUpdatingLocation];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.appState getState];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self.activityIndicator stopAnimating];
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
    return 75;
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
    //Set the color of the cell differently according to status
    
    cell.begins = beckon.begins;
    cell.nameOfEventLabel.text = beckon.title;
    if([beckon.hasUnreadMessages intValue] == 1){
        [cell activateChatIndicator];
    }
    else{
        [cell deactivateChatIndicator];
    }

    if([beckon.status isEqualToString:@"PENDING"]){
//        [cell setCellColor: [UIColor colorWithRed:255.0/255.0 green:118.0/255.0 blue:0.0/255.0 alpha:0.6]];
        [cell setCellColor: [UIColor colorWithRed:230.0/255.0 green:180.0/255.0 blue:0.0/255.0 alpha:1.0]];
    }
    else if ([beckon.status isEqualToString:@"ACCEPTED"]){
//        [cell setCellColor: [UIColor colorWithRed:93.0/255.0 green:119.0/255.0 blue:55.0/255.0 alpha:0.65]];
//        [cell setCellColor: [UIColor colorWithRed:36.0/255.0 green:192.0/255.0 blue:154.0/255.0 alpha:1.00]];
        [cell setCellColor: [UIColor colorWithRed:30.0/255.0 green:180.0/255.0 blue:100.0/255.0 alpha:1.00]];
    }
    else if ([beckon.status isEqualToString:@"REJECTED"]){
//        [cell setCellColor: [UIColor colorWithRed:240.0/255.0 green:31.0/255.0 blue:0.0/255.0 alpha:0.6]];
        [cell setCellColor: [UIColor colorWithRed:255.0/255.0 green:44.0/255.0 blue:107.0/255.0 alpha:1.0]];
    }
    CLLocation *beckonLocation = [[CLLocation alloc] initWithLatitude:[beckon.latitude doubleValue] longitude:[beckon.longitude doubleValue]];
    CLLocationDistance distance = [self.userLocation distanceFromLocation:beckonLocation];
    if(distance < 1000 && distance > 100){
        cell.statusLabel.text = @"You are almost there";
    }
    else if (distance < 100){
        cell.statusLabel.text = @"You are there";
    }
    else{
        distance = distance / 1000;
        NSString *distanceString = [NSString stringWithFormat: @"%.0f km away", distance];
        cell.statusLabel.text = distanceString;
    }
    cell.placeOfEventLabel.text = beckon.locationString;
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
        [self.activityIndicator startAnimating];
        NSIndexPath *index = [self.beckonTableView indexPathForSelectedRow];
        Beckon *beckon = [self.beckons.beckons objectAtIndex:index.row];
        UINavigationController *navController = [segue destinationViewController];
        BeckonDetailPageVC *pageVC = [[navController viewControllers] objectAtIndex:0];
        pageVC.beckon = beckon;
        [self.beckonTableView deselectRowAtIndexPath:index animated:NO];
    }
}

@end
