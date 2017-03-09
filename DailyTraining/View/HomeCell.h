//
//  HomeCell.h
//  DailyTraining
//
//  Created by 孙琪 on 2017/3/8.
//  Copyright © 2017年 七. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface HomeCell : UITableViewCell

@property (nonatomic, strong)UIImageView * iconImg;
@property (nonatomic,strong)UILabel *titleL;
@property (nonatomic,strong)UILabel *numL;
@property (nonatomic, strong)UIView * line;

@property (nonatomic,strong)HomeModel *homeModel;

- (void)setSubviews:(NSIndexPath *)indexPath;

@end
