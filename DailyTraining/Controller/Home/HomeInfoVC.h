//
//  HomeInfoVC.h
//  DailyTraining
//
//  Created by 孙琪 on 2017/3/8.
//  Copyright © 2017年 七. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeInfoModel.h"

typedef void(^TextBackBlock)(HomeInfoModel *text);

//typedef void(^TextBackBlock)(NSString *text);

@interface HomeInfoVC : UIViewController

@property (nonatomic, strong)NSString * iconImg;
@property (nonatomic,strong)NSString *titleStr;
@property (nonatomic, strong) UITextField *bottomText;
@property (nonatomic,strong) HomeInfoModel *homeInfo;
@property (nonatomic,strong) TextBackBlock textBlock;

@end
