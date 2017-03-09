//
//  HomeModel.h
//  DailyTraining
//
//  Created by 孙琪 on 2017/3/8.
//  Copyright © 2017年 七. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

/**
 *  图片
 */
@property (nonatomic,strong)NSString *imgUrl;
/**
 *  标题
 */
@property (nonatomic,strong)NSString *title;
/**
 *  角标
 */
@property (nonatomic,strong)NSString *number;

@end
