//
//  LoginVC.m
//  DailyTraining
//
//  Created by 孙琪 on 2017/3/8.
//  Copyright © 2017年 七. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC () <UITextFieldDelegate>

@property (nonatomic,strong) UIButton *loginBtn; //登录按键
@property (nonatomic,strong) UITextField *userName; //手机号输入框
@property (nonatomic,strong) UITextField  *passWord; //密码输入框

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createLoginVC];
    
    [_userName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_passWord addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuWillBeShown:) name:UIMenuControllerWillShowMenuNotification object:nil];
}

#pragma mark - /************************* 界面初始化 ***************************/
-(void) createLoginVC {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //手机号输入框
    UIImageView *userLogo = [[UIImageView alloc]init];
    userLogo.contentMode = UIViewContentModeScaleAspectFit;
    userLogo.image = [UIImage imageNamed:@"loginName"];
    [self.view addSubview:userLogo];
    [userLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(35);
        make.top.equalTo(self.view).offset(160);
        make.size.mas_equalTo(CGSizeMake(18, 50));
    }];
    
    _userName = [[UITextField alloc]init];
    _userName.placeholder = @"请输入手机号";
    _userName.keyboardType = UIKeyboardTypeNumberPad;
    _userName.font = [UIFont systemFontOfSize:15];
    _userName.layer.borderWidth = 1.0f;
    _userName.layer.cornerRadius = 2;
    _userName.layer.borderColor = [UIColor hexStringToColor:@"#cccccc"].CGColor;
    [self.view addSubview:_userName];
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userLogo.mas_right).offset(20);
        make.right.equalTo(self.view).offset(-25);
        make.top.equalTo(self.view).offset(160);
        make.height.mas_equalTo(50);
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.top.equalTo(userLogo.mas_bottom).offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    //密码输入框
    UIImageView *passLogo = [[UIImageView alloc]init];
    passLogo.contentMode = UIViewContentModeScaleAspectFit;
    passLogo.image = [UIImage imageNamed:@"loginPassword"];
    [self.view addSubview:passLogo];
    [passLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(35);
        make.top.equalTo(_userName.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(18, 50));
    }];
    
    _passWord = [[UITextField alloc]init];
    _passWord.placeholder = @"请输入密码";
    _passWord.secureTextEntry = YES;
    _passWord.returnKeyType = UIReturnKeyDone;
    _passWord.font = [UIFont systemFontOfSize:15];
    _passWord.layer.borderWidth = 1.0f;
    _passWord.layer.cornerRadius = 2;
    _passWord.layer.borderColor = [UIColor hexStringToColor:@"#cccccc"].CGColor;
    [self.view addSubview:_passWord];
    [_passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passLogo.mas_right).offset(20);
        make.right.equalTo(self.view).offset(-60);
        make.top.equalTo(_userName.mas_bottom).offset(0);
        make.height.mas_equalTo(50);
    }];
    
    UIButton *passEye = [UIButton buttonWithType:UIButtonTypeCustom];
    [passEye setImage:[UIImage imageNamed:@"passcode"] forState:UIControlStateNormal];
    [passEye addTarget:self action:@selector(passEyePassword:) forControlEvents:UIControlEventTouchUpInside];
    passEye.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:passEye];
    [passEye mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(_userName.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(36, 50));
    }];
    
    UIView *bottomLine2 = [[UIView alloc]init];
    bottomLine2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bottomLine2];
    [bottomLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.top.equalTo(passLogo.mas_bottom).offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    //登录按键
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(tapLogin:) forControlEvents:UIControlEventTouchUpInside];
    [_loginBtn setUserInteractionEnabled:NO];
    _loginBtn.backgroundColor = [UIColor hexStringToColor:@"#cccccc"];
    [self.view addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.height.mas_equalTo(45);
        make.top.equalTo(bottomLine2.mas_bottom).offset(70);
    }];
    
    _loginBtn.layer.cornerRadius = 3;
    _userName.tag = 1001;
    _passWord.tag = 1002;
    _userName.delegate = self;
    _passWord.delegate = self;
    
    [_userName setValue:[UIColor hexStringToColor:@"#cccccc"] forKeyPath:@"_placeholderLabel.textColor"];
    [_userName setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [_passWord setValue:[UIColor hexStringToColor:@"#cccccc"] forKeyPath:@"_placeholderLabel.textColor"];
    [_passWord setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    if (iphone6Plus_5_5) {
        [_userName setFont:[UIFont systemFontOfSize:16]];
        [_userName setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        [_passWord setFont:[UIFont systemFontOfSize:16]];
        [_passWord setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        _loginBtn.titleLabel.font  = [UIFont systemFontOfSize:17];
    }
}


/**
 *  监听方法--限制输入长度
 *
 *  @param textField 当前监听输入框
 */
-(void)textFieldDidChange:(UITextField *)textField {
    
    NSInteger kMaxLength = 11;
    if (textField.tag == 1002) {
        kMaxLength = 16;
    }
    
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > kMaxLength) {
            textField.text = [toBeString substringToIndex:kMaxLength];
        }
    }
    [self checkInfo];
}

/**
 *  释放监听
 */
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerWillShowMenuNotification object:nil];
}

- (void)passEyePassword:(id)sender {
    self.passWord.secureTextEntry = !self.passWord.secureTextEntry;
    
    NSString* text = self.passWord.text;
    self.passWord.text = @" ";
    self.passWord.text = text;
}


/**
 *  校验信息改变button状态
 */
-(void)checkInfo{
    
    NSString *phoneStr = [_userName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *passWordStr = [_passWord.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (![phoneStr isEqualToString:@""]&&![passWordStr isEqualToString:@""]) {
        
        [_loginBtn setUserInteractionEnabled:YES];
        _loginBtn.backgroundColor = [UIColor hexStringToColor:@"#007aff"];
    }else{
        
        [_loginBtn setUserInteractionEnabled:NO];
        _loginBtn.backgroundColor = [UIColor hexStringToColor:@"#cccccc"];
    }
}


/**
 *  点击登录回掉方法
 *
 *  @param sender 登录按键
 */
- (void)tapLogin:(id)sender {
    NSString *phoneStr = [_userName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *passWordStr = [_passWord.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (![phoneStr isEqualToString:@"sunshijia"]) {
        _userName.layer.borderColor = [UIColor redColor].CGColor;
    }else{
        _userName.layer.borderColor = [UIColor hexStringToColor:@"#cccccc"].CGColor;
    }
    
    if (![passWordStr isEqualToString:@"7777777"]) {
        _passWord.layer.borderColor = [UIColor redColor].CGColor;
    }else{
        _passWord.layer.borderColor = [UIColor hexStringToColor:@"#cccccc"].CGColor;
    }
    
    if ([phoneStr isEqualToString:@"sunshijia"] && [passWordStr isEqualToString:@"7777777"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark -- textField delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

#pragma mark -- 监听MenuController
- (void)menuWillBeShown:(NSNotification *)notification {
    dispatch_async(dispatch_get_main_queue(),^{
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
