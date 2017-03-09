//
//  HomeInfoVC.m
//  DailyTraining
//
//  Created by 孙琪 on 2017/3/8.
//  Copyright © 2017年 七. All rights reserved.
//

#import "HomeInfoVC.h"

@interface HomeInfoVC ()

@end

@implementation HomeInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addView];
    
}

- (void)addView{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *iconImg = [[UIImageView alloc]init];
    iconImg.contentMode = UIViewContentModeScaleAspectFit;
    iconImg.clipsToBounds = YES;
    iconImg.backgroundColor = [UIColor whiteColor];
    [iconImg sd_setImageWithURL:[NSURL URLWithString:_iconImg] placeholderImage:[UIImage imageNamed:@"partnerList"] ];
    [self.view addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(self.view).offset(90);
        make.width.equalTo(@80);
        make.height.equalTo(@60);
    }];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.textColor = [UIColor hexStringToColor:@"#333333"];
    titleL.font = [UIFont systemFontOfSize:15];
    titleL.backgroundColor = [UIColor whiteColor];
    titleL.text = _titleStr;
    [self.view addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImg.mas_right).offset(20);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.view).offset(90);
        make.height.equalTo(@15);
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
