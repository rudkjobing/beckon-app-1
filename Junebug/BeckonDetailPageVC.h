#import <UIKit/UIKit.h>
#import "Beckon.h"
@interface BeckonDetailPageVC : UIPageViewController <UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *viewControllerArray;
@property (nonatomic, strong) UIView *selectionBar;
@property (nonatomic, strong) UIView *manualSelectionBar;
@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) Beckon *beckon;


@end