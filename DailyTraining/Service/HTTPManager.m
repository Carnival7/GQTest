//
//  HTTPManager.m
//  DailyTraining
//
//  Created by 孙琪 on 2017/3/9.
//  Copyright © 2017年 七. All rights reserved.
//

#import "HTTPManager.h"

@implementation HTTPManager

+ (instancetype)manager
{
    HTTPManager *mgr = [super manager];
    NSMutableSet *mgrSet = [NSMutableSet set];
    mgrSet.set = mgr.responseSerializer.acceptableContentTypes;
    
    [mgrSet addObject:@"text/html"];
    
    mgr.responseSerializer.acceptableContentTypes = mgrSet;
    
    return mgr;
}

@end
