#import "BeckonDetailPageVC.h"
#import "ChatRoomVC.h"
#import "BeckonMapViewController.h"
#import "BeckonMemberViewController.h"
#import "BeckonChatViewController.h"

@implementation BeckonDetailPageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewControllerArray = [[NSMutableArray alloc]init];
    
    BeckonChatViewController *chat = [[BeckonChatViewController alloc] initWithNibName:@"BeckonChatViewController" bundle:nil];
    self.beckon.chatRoom.chatRoomVC = chat;
    chat.chatRoom = self.beckon.chatRoom;
    chat.dataSource = self.beckon.chatRoom.chatMessages;
    
    BeckonMapViewController *map = [[BeckonMapViewController alloc] initWithNibName:@"BeckonMapViewController" bundle:nil];
    
    BeckonMemberViewController *members = [[BeckonMemberViewController alloc] initWithNibName:@"BeckonMemberViewController" bundle:nil];
    
    [self.viewControllerArray addObjectsFromArray:@[chat, members, map]];
    
    UIBarButtonItem *previousButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    previousButton.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = previousButton;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.beckon.isInFocus = YES;
    [self setupPageViewController];
}

- (void)backAction{
    self.beckon.isInFocus = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setupPageViewController
{
    self.delegate = self;
    self.dataSource = self;
    if([self.beckon.status isEqualToString:@"PENDING"]){
        [self setViewControllers:@[[self.viewControllerArray objectAtIndex:2]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    else{
        [self setViewControllers:@[[self.viewControllerArray objectAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
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
