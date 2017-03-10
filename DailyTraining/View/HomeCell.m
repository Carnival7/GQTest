//
//  HomeCell.m
//  DailyTraining
//
//  Created by 孙琪 on 2017/3/8.
//  Copyright © 2017年 七. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSubviews:(NSIndexPath *)indexPath
{
    if (!_iconImg) {
        UIImageView *iconImg = [[UIImageView alloc]init];
        self.iconImg = iconImg;
        iconImg.contentMode = UIViewContentModeScaleAspectFit;
        iconImg.clipsToBounds = YES;
        iconImg.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:iconImg];
        [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(5);
            make.width.equalTo(@80);
            make.height.equalTo(@60);
        }];
    }
    
    if (!_titleL) {
        UILabel *titleL = [[UILabel alloc] init];
        self.titleL = titleL;
        titleL.textColor = [UIColor hexStringToColor:@"#333333"];
        titleL.font = [UIFont systemFontOfSize:15];
        titleL.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:titleL];
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_iconImg.mas_right).offset(20);
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(self).offset(5);
            make.height.equalTo(@15);
        }];
    }
    
    if (!_numL) {
        UILabel *numL = [[UILabel alloc]init];
        self.numL = numL;
        numL.textColor = [UIColor hexStringToColor:@"#666666"];
        numL.font = [UIFont systemFontOfSize:10];
        numL.textAlignment = NSTextAlignmentRight;
        numL.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:numL];
        [numL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.height.equalTo(@15);
            make.bottom.equalTo(self).offset(-5);
            make.width.equalTo(@40);
        }];
    }
    
    if(!_xxL){
        UILabel *titleL = [[UILabel alloc] init];
        self.xxL = titleL;
        titleL.textColor = [UIColor hexStringToColor:@"#333333"];
        titleL.font = [UIFont systemFontOfSize:15];
        titleL.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:titleL];
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_iconImg.mas_right).offset(20);
            make.right.equalTo(_numL.mas_left).offset(-10);
            make.bottom.equalTo(self).offset(-5);
            make.height.equalTo(@15);
        }];
    }
    
    
    if (!_line) {
        UIView *line = [[UIView alloc]init];
        self.line = line;
        line.clipsToBounds = YES;
        line.backgroundColor = [UIColor hexStringToColor:@"cccccc"];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.height.equalTo(@0.5);
            make.bottom.equalTo(self);
            make.left.equalTo(self).offset(15);
        }];
    }
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}


-(void)setHomeModel:(HomeModel *)homeModel
{
    _homeModel = homeModel;
    _titleL.text = homeModel.title;
    _numL.text = homeModel.number;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:homeModel.imgUrl] placeholderImage:[UIImage imageNamed:@"partnerList"] ];
    
}

@end
