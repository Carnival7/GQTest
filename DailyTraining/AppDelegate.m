//
//  AppDelegate.m
//  DailyTraining
//
//  Created by 孙琪 on 2017/3/8.
//  Copyright © 2017年 七. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
#if !TARGET_IPHONE_SIMULATOR
    // 真机测试时保存日志
    // [self redirectNSLogToDocumentFolder];
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
#endif
    
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isRereshToken"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    _TabbarConfig = [[DDTabBarControllerConfig alloc]init];
    [self.window setRootViewController:_TabbarConfig.tabBarController];
    [self.window makeKeyAndVisible];
    
    return YES;
}


-(DDTabBarControllerConfig *)getMainTabVC {
    return _TabbarConfig;
}



/**
 *  本地记录LOG日志
 */
- (void)redirectNSLogToDocumentFolder{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName =[NSString stringWithFormat:@"%@.log",[NSDate date]];
    NSString *logFilePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding],"a+",stderr);
}


@end
