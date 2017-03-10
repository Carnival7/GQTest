//
//  HTTPManager.h
//  DailyTraining
//
//  Created by 孙琪 on 2017/3/9.
//  Copyright © 2017年 七. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface HTTPManager : AFHTTPRequestOperationManager

+ (instancetype)manager;

@end
