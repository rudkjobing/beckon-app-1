#import "BeckonDetailPageVC.h"
#import "ChatRoomVC.h"
#import "BeckonMapViewController.h"
#import "BeckonAcceptDeclineViewController.h"

@implementation BeckonDetailPageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewControllerArray = [[NSMutableArray alloc]init];
    ChatRoomVC *chatVC = [[ChatRoomVC alloc]init];
    self.beckon.chatRoom.chatRoomVC = chatVC;
    chatVC.chatRoom = self.beckon.chatRoom;
    chatVC.dataSource = self.beckon.chatRoom.chatMessages;
    BeckonMapViewController *map = [[BeckonMapViewController alloc] initWithNibName:@"BeckonMapViewController" bundle:nil];
    BeckonAcceptDeclineViewController *acceptReject = [[BeckonAcceptDeclineViewController alloc] initWithNibName:@"BeckonAcceptDeclineViewController" bundle:nil];
    [self.viewControllerArray addObjectsFromArray:@[chatVC, acceptReject, map]];
    UIBarButtonItem *previousButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = previousButton;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setupPageViewController];
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setupPageViewController
{
    self.delegate = self;
    self.dataSource = self;
    [self setViewControllers:@[[self.viewControllerArray objectAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

-(NSInteger)indexOfController:(UIViewController *)viewController
{
    for (int i = 0; i<[self.viewControllerArray count]; i++) {
        if (viewController == [self.viewControllerArray objectAtIndex:i])
        {
            return i;
        }
    }
    return NSNotFound;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfController:viewController];
    
    if ((index == NSNotFound) || (index == 0)) {
        return nil;
    }
    
    index--;
    return [self.viewControllerArray objectAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfController:viewController];
    
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    
    if (index == [self.viewControllerArray count]) {
        return nil;
    }
    return [self.viewControllerArray objectAtIndex:index];
}

@end
