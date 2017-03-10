//
//  HomeVC.h
//  DailyTraining
//
//  Created by 孙琪 on 2017/3/8.
//  Copyright © 2017年 七. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeInfoModel.h"

typedef void(^TextBackBlock)(HomeInfoModel *text);
@interface HomeVC : UIViewController

@property (nonatomic,strong) TextBackBlock textBlock;

@end
