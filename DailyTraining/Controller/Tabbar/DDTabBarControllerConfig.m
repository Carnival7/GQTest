//
//  Daodao
//
//  Created by 郝凡宁 on 15/11/25.
//  Copyright © 2015年 东道道. All rights reserved.
//

#import "DDTabBarControllerConfig.h"
#import "HomeVC.h"

#define NomarlTitleColor [UIColor hexStringToColor:@"#333333"]
#define SelectTitleColor [UIColor hexStringToColor:@"#007aff"]

@interface DDTabBarControllerConfig ()

@property (nonatomic, readwrite, strong) DDTabBarController *tabBarController;

@end

@implementation DDTabBarControllerConfig

/**
 *  lazy load tabBarController
 *
 *  @return DDTabBarController
 */
- (DDTabBarController *)tabBarController {
  
    if (_tabBarController == nil) {
        
        HomeVC *homeVC = [[HomeVC alloc] init];
        UIViewController *homeNav = [[UINavigationController alloc]
                                                       initWithRootViewController:homeVC];
        
        HomeVC *businessVC = [[HomeVC alloc] init];
        UIViewController *businessNav = [[UINavigationController alloc]
                                                        initWithRootViewController:businessVC];
        
        HomeVC *orderVC = [[HomeVC alloc] init];
        UIViewController *orderNav = [[UINavigationController alloc]
                                                       initWithRootViewController:orderVC];
        
        HomeVC *chatlistVC = [[HomeVC alloc] init];
        UIViewController *chatNav = [[UINavigationController alloc]
                                                        initWithRootViewController:chatlistVC];
        
        DDTabBarController *tabBarController = [[DDTabBarController alloc] init];
        
        //在`-setViewControllers:`之前设置TabBar的属性，设置TabBarItem的属性，包括 title、Image、selectedImage。
        [self setUpTabBarItemsAttributesForController:tabBarController];
        
        [tabBarController setViewControllers:@[
                                               homeNav,
                                               businessNav,
                                               orderNav,
                                               chatNav
                                               ]];
        
        //更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性
        [[self class] customizeTabBarAppearance];
        
        _tabBarController = tabBarController;
        
    }
    
    return _tabBarController;
    
}

/*
 *在`-setViewControllers:`之前设置TabBar的属性，设置TabBarItem的属性，包括 title、Image、selectedImage。
 *
 */
- (void)setUpTabBarItemsAttributesForController:(DDTabBarController *)tabBarController {
    
    NSDictionary *dict1 = @{
                            DDTabBarItemTitle : @"首页",
                            DDTabBarItemImage : @"home_normal",
                            DDTabBarItemSelectedImage : @"home_highlight",
                            };
    
    NSDictionary *dict2 = @{
                            DDTabBarItemTitle : @"业务",
                            DDTabBarItemImage : @"business_normal",
                            DDTabBarItemSelectedImage : @"business_highlight",
                            };
    
    NSDictionary *dict3 = @{
                            DDTabBarItemTitle : @"订单",
                            DDTabBarItemImage : @"order_normal",
                            DDTabBarItemSelectedImage : @"order_highlight"
                            };
    
    NSDictionary *dict4 = @{
                            DDTabBarItemTitle : @"消息",
                            DDTabBarItemImage : @"message_normal",
                            DDTabBarItemSelectedImage : @"message_highlight",
                            };

    NSArray *tabBarItemsAttributes = @[dict1,dict2,dict3,dict4];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
    
}

/**
 *  TabBar自定义设置
 */
+ (void)customizeTabBarAppearance {
    
    //去除 TabBar 自带的顶部阴影
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = NomarlTitleColor;
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = SelectTitleColor;
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];

}


- (void)recivedNotifiction:(NSDictionary *)notiInfo {
}

@end
