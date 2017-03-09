//
//  Daodao
//
//  Created by 郝凡宁 on 15/11/25.
//  Copyright © 2015年 东道道. All rights reserved.
//

#import "DDTabBarController.h"
#import "DDTabBar.h"
#import <objc/runtime.h>
#import "HomeVC.h"

NSUInteger DDTabbarItemsCount = 0;

@interface UIViewController (DDTabBarControllerItemInternal)

- (void)DD_setTabBarController:(DDTabBarController *)tabBarController;

@end

@interface DDTabBarController () <UIAlertViewDelegate>
@property (strong,nonatomic)NSDictionary *versionDic;
@end

@implementation DDTabBarController
@synthesize viewControllers = _viewControllers;

-(void)viewWillAppear:(BOOL)animated {
    [self.selectedViewController beginAppearanceTransition: YES animated: animated];
}

-(void) viewDidAppear:(BOOL)animated {
    [self.selectedViewController endAppearanceTransition];
}

-(void) viewWillDisappear:(BOOL)animated {
    [self.selectedViewController beginAppearanceTransition: NO animated: animated];
}

-(void) viewDidDisappear:(BOOL)animated {
    [self.selectedViewController endAppearanceTransition];
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    self.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpTabBar];
}

//-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(nonnull UIViewController *)viewController{
//    NSInteger index = [self.viewControllers indexOfObject:viewController];
//    return YES;
//}


/**
 *  记录tabbar点击位置
 *
 *  @param tabBar 平行导航栏
 *  @param item   平行导航栏item
 */
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    //获得选中的item
    NSUInteger tabIndex = [tabBar.items indexOfObject:item];
    if (tabIndex != self.selectedIndex) {
        //设置最近一次变更,记录上一次点击位置
        _lastSelectedIndex = self.selectedIndex;
        _newSelectedIndex = tabIndex;
    }
    
}


//-(void)homeAddRefresh:(BOOL)success {
    
//    UINavigationController *homeNav = [self.viewControllers objectAtIndex:0];
//    HomeVC *home = [homeNav.viewControllers objectAtIndex:0];
//    [home addRefreshGifHeader:success];
    
//}

#pragma mark - Private Methods

/**
 *  利用 KVC 把 系统的 tabBar 类型改为自定义类型。
 */
- (void)setUpTabBar {
    [self setValue:[[DDTabBar alloc] init] forKey:@"tabBar"];
}

- (void)setViewControllers:(NSArray *)viewControllers {
    if (_viewControllers && _viewControllers.count) {
        for (UIViewController *viewController in _viewControllers) {
            [viewController willMoveToParentViewController:nil];
            [viewController.view removeFromSuperview];
            [viewController removeFromParentViewController];
        }
    }
    
    if (viewControllers && [viewControllers isKindOfClass:[NSArray class]]) {
        
        _viewControllers = [viewControllers copy];
        if (_tabBarItemsAttributes) {
            if (_tabBarItemsAttributes.count != _viewControllers.count) {
                [NSException raise:@"DDTabBarController" format:@"The count of DDTabBarControllers is not equal to the count of tabBarItemsAttributes.【中文】设置_tabBarItemsAttributes属性时，请确保元素个数与控制器的个数相同，并在方法`-setViewControllers:`之前设置"];
            }
        }
        
        DDTabbarItemsCount = [viewControllers count];
        NSUInteger idx = 0;
        for (UIViewController *viewController in viewControllers) {
            [self addOneChildViewController:viewController
                                  WithTitle:_tabBarItemsAttributes[idx][DDTabBarItemTitle]
                            normalImageName:_tabBarItemsAttributes[idx][DDTabBarItemImage]
                          selectedImageName:_tabBarItemsAttributes[idx][DDTabBarItemSelectedImage]];
            [viewController DD_setTabBarController:self];
            idx++;
        }
    } else {
        
        for (UIViewController *viewController in _viewControllers) {
            [viewController DD_setTabBarController:nil];
        }
        _viewControllers = nil;
        
    }
}

/**
 *  添加一个子控制器
 *
 *  @param viewController    控制器
 *  @param title             标题
 *  @param normalImageName   图片
 *  @param selectedImageName 选中图片
 */
- (void)addOneChildViewController:(UIViewController *)viewController
                        WithTitle:(NSString *)title
                  normalImageName:(NSString *)normalImageName
                selectedImageName:(NSString *)selectedImageName {
    
    viewController.tabBarItem.title         = title;
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.image         = normalImage;
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = selectedImage;
    
    [self addChildViewController:viewController];
    
}

@end

#pragma mark - UIViewController+DDTabBarControllerItem

@implementation UIViewController (DDTabBarControllerItemInternal)

- (void)DD_setTabBarController:(DDTabBarController *)tabBarController {
    objc_setAssociatedObject(self, @selector(DD_tabBarController), tabBarController, OBJC_ASSOCIATION_ASSIGN);
}

@end

@implementation UIViewController (DDTabBarController)

- (DDTabBarController *)DD_tabBarController {
    DDTabBarController *tabBarController = objc_getAssociatedObject(self, @selector(DD_tabBarController));
    
    if (!tabBarController && self.parentViewController) {
        tabBarController = [self.parentViewController DD_tabBarController];
    }
    
    return tabBarController;
}

@end
