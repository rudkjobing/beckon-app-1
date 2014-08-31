#import "BeckonDetailPageVC.h"
#import "ChatRoomVC.h"

@implementation BeckonDetailPageVC
@synthesize viewControllerArray;
@synthesize manualSelectionBar;
@synthesize pageController;
@synthesize navigationView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    viewControllerArray = [[NSMutableArray alloc]init];
    ChatRoomVC *chatVC = [[ChatRoomVC alloc]init];
    chatVC.chatRoom = self.beckon.chatRoom;
    chatVC.dataSource = self.beckon.chatRoom.chatMessages;
    UIViewController *asd = [[UIViewController alloc] init];
    [self.viewControllerArray addObjectsFromArray:@[chatVC, asd]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setupPageViewController];
}

-(void)setupPageViewController
{
    pageController = self;
    pageController.delegate = self;
    pageController.dataSource = self;
    [pageController setViewControllers:@[[viewControllerArray objectAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

-(NSInteger)indexOfController:(UIViewController *)viewController
{
    for (int i = 0; i<[viewControllerArray count]; i++) {
        if (viewController == [viewControllerArray objectAtIndex:i])
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
    return [viewControllerArray objectAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfController:viewController];
    
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    
    if (index == [viewControllerArray count]) {
        return nil;
    }
    return [viewControllerArray objectAtIndex:index];
}

@end
