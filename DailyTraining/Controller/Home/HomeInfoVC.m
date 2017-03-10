//
//  HomeInfoVC.m
//  DailyTraining
//
//  Created by 孙琪 on 2017/3/8.
//  Copyright © 2017年 七. All rights reserved.
//

#import "HomeInfoVC.h"
#import "ZYKeyboardUtil.h"

#define MARGIN_KEYBOARD 10

@interface HomeInfoVC ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *bottomText;
@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;
@end

@implementation HomeInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addView];
    [self configKeyBoardRespond];
}

- (void)dealloc {
    self.bottomText.delegate = nil;
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
    
    
    _bottomText = [[UITextField alloc] init];
    _bottomText.delegate = self;
    _bottomText.placeholder = @"请在此输入...";
    _bottomText.backgroundColor = [UIColor whiteColor];
    _bottomText.tintColor = [UIColor hexStringToColor:@"#666666"];
    _bottomText.textColor = [UIColor hexStringToColor:@"#666666"];
    _bottomText.font = [UIFont systemFontOfSize:15];
    _bottomText.layer.borderWidth = 1.0f;
    _bottomText.layer.cornerRadius = 2;
    _bottomText.layer.borderColor = [UIColor hexStringToColor:@"#cccccc"].CGColor;
    [self.view addSubview:_bottomText];
    [_bottomText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-20);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.equalTo(@30);
    }];
}

#pragma mark - /************************* 自定义键盘 ***************************/
- (void)configKeyBoardRespond {
    self.keyboardUtil = [[ZYKeyboardUtil alloc] initWithKeyboardTopMargin:MARGIN_KEYBOARD];
    __weak HomeInfoVC *weakSelf = self;
    
    // 全自动键盘弹出/收起处理 (需调用keyboardUtil 的 adaptiveViewHandleWithController:adaptiveView:)
    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.bottomText, nil];
    }];
    
    //获取键盘信息
    [_keyboardUtil setPrintKeyboardInfoBlock:^(ZYKeyboardUtil *keyboardUtil, KeyboardInfo *keyboardInfo) {
        //NSLog(@"\n\n拿到键盘信息 和 ZYKeyboardUtil对象");
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.bottomText resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.bottomText resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
