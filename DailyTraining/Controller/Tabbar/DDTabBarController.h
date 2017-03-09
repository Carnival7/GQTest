//
//  Daodao
//
//  Created by 郝凡宁 on 15/11/25.
//  Copyright © 2015年 东道道. All rights reserved.
//

@import Foundation;

static NSString *const DDTabBarItemTitle= @"tabBarItemTitle";
static NSString *const DDTabBarItemImage= @"tabBarItemImage";
static NSString *const DDTabBarItemSelectedImage= @"tabBarItemSelectedImage";

extern NSUInteger DDTabbarItemsCount;

#import <UIKit/UIKit.h>

typedef void(^LogSuccessBlock)();
typedef void(^LogFailedBlock)();

@interface DDTabBarController : UITabBarController <UITabBarControllerDelegate>

/**
 * An array of the root view controllers displayed by the tab bar interface.
 */
@property (nonatomic, readwrite, copy) IBOutletCollection(UIViewController) NSArray *viewControllers;

/**
 * The Attributes of items which is displayed on the tab bar.
 */
@property (nonatomic, readwrite, copy) IBOutletCollection(NSDictionary) NSArray *tabBarItemsAttributes;

@property (nonatomic, strong) LogSuccessBlock logSuccessBlock;
@property (nonatomic, strong) LogFailedBlock logFailedBlock;
@property (nonatomic, assign) NSInteger lastSelectedIndex;
@property (nonatomic, assign) NSInteger newSelectedIndex;

-(void)jumpLoginVCwithFrom:(NSString *)from successed:(LogSuccessBlock)successBlock failed:(LogFailedBlock)failedBlcok;
-(void)homeAddRefresh:(BOOL)success;

@end

@interface UIViewController (DDTabBarController)

/**
 * The nearest ancestor in the view controller hierarchy that is a tab bar controller. (read-only)
 */
@property(nonatomic, readonly) DDTabBarController *DD_tabBarController;

@end
