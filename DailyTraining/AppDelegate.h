//
//  AppDelegate.h
//  DailyTraining
//
//  Created by 孙琪 on 2017/3/8.
//  Copyright © 2017年 七. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DDTabBarControllerConfig.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DDTabBarControllerConfig *TabbarConfig;
@property (strong, nonatomic) NSDate *lastPlaySoundDate;

-(DDTabBarControllerConfig *)getMainTabVC;


@end

