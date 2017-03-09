//
//  HomeModel.m
//  DailyTraining
//
//  Created by 孙琪 on 2017/3/8.
//  Copyright © 2017年 七. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"number"]) {
        self.number = value;
    }
}

@end
