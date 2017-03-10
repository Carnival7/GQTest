//
//  HomeVC.m
//  DailyTraining
//
//  Created by 孙琪 on 2017/3/8.
//  Copyright © 2017年 七. All rights reserved.
//

#import "HomeVC.h"
#import "LoginVC.h"
#import "HomeCell.h"
#import "HomeInfoVC.h"
#import "HomeModel.h"

@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *textL;
@property (strong,nonatomic) NSArray<HomeModel *> *dataArr;  //数组

@property (nonatomic,strong) HomeInfoModel *homeInfo;

@end

@implementation HomeVC

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNav];
    [self addTableView];
    [self infoDic];
    [self sendWeatherRequest];
    
    self.homeInfo = [HomeInfoModel new];
    
    __weak __typeof(&*self)weakSelf = self;
    self.textBlock = ^(HomeInfoModel *homeInfo){
        weakSelf.homeInfo.text = homeInfo.text;
    };
}

#pragma mark - /************************* 界面初始化 ***************************/
/**
 *  初始化导航栏
 */
-(void)createNav{
    
    // 头部logo
    UIImageView *titleView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 31, 26)];
    titleView.contentMode = UIViewContentModeScaleAspectFit;
    titleView.image = [UIImage imageNamed:@"titleLogo"];
    self.navigationItem.titleView = titleView;
    
    // 个人信息页button
    UIButton* personInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [personInfoBtn setFrame:CGRectMake(0, 0, 24, 24)];
    [personInfoBtn setImage:[UIImage imageNamed:@"personInfoBtn"] forState:UIControlStateNormal];
    [personInfoBtn addTarget:self
                      action:@selector(personInfoAction:)
            forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftBarBtn=[[UIBarButtonItem alloc]initWithCustomView:personInfoBtn];
    self.navigationItem.leftBarButtonItem=leftBarBtn;
}


/**
 *  登录页跳转
 *
 */
- (void)personInfoAction:(UIButton *)btn{
    LoginVC *vc = [[LoginVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


/**
 *  创建tableView
 *
 */
- (void)addTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0 , 64, kScreenW, kScreenH-64-100) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.scrollEnabled =NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
//    UILabel *titleL = [[UILabel alloc] init];
//    titleL.textColor = [UIColor hexStringToColor:@"#333333"];
//    titleL.font = [UIFont systemFontOfSize:15];
//    titleL.backgroundColor = [UIColor redColor];
//    titleL.text = self.homeInfo.text;;
//    [self.view addSubview:titleL];
//    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(20);
//        make.right.equalTo(self.view).offset(-20);
//        make.bottom.equalTo(self.view).offset(-20);
//        make.height.equalTo(@15);
//    }];
}

#pragma mark - /************************* 获取网络方法 ***************************/
- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}

-(void)infoDic{
    NSDictionary *dataDic = @{
                              @"dataArr" :     @[
                                      @{
                                          @"number" : @"3",
                                          @"title" : @"画册阿萨德拉斯",
                                          @"imgUrl" : @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488992504477&di=0fa7fa00dc1a5d062f2609f538b327ea&imgtype=0&src=http%3A%2F%2Fpic2.ooopic.com%2F10%2F22%2F23%2F71b1OOOPICda.jpg",
                                          },
                                      @{
                                          @"number" : @"4",
                                          @"title" : @"画册老师肯定了看上你都",
                                          @"imgUrl" : @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488992504477&di=0fa7fa00dc1a5d062f2609f538b327ea&imgtype=0&src=http%3A%2F%2Fpic2.ooopic.com%2F10%2F22%2F23%2F71b1OOOPICda.jpg",
                                          },
                                      @{
                                          @"number" : @"5",
                                          @"title" : @"画册拉屎第六空间按时",
                                          @"imgUrl" : @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488992504477&di=0fa7fa00dc1a5d062f2609f538b327ea&imgtype=0&src=http%3A%2F%2Fpic2.ooopic.com%2F10%2F22%2F23%2F71b1OOOPICda.jpg",
                                          },
                                      @{
                                          @"number" : @"6",
                                          @"title" : @"画册开始觉得拉可",
                                          @"imgUrl" : @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488992504477&di=0fa7fa00dc1a5d062f2609f538b327ea&imgtype=0&src=http%3A%2F%2Fpic2.ooopic.com%2F10%2F22%2F23%2F71b1OOOPICda.jpg",
                                          }
                                      ]
                              };
    _dataArr = dataDic[@"dataArr"];
    
    
    
    [self.tableView reloadData];
}



- (void)sendWeatherRequest{
    NSString *allUrlstring = [NSString stringWithFormat:@"/nc/article/list/T1348649145984/0-20.html"];
    [self withURL:allUrlstring];
}


- (void)withURL:(NSString *)allUrlstring{
    [[[HTTPTools sharedWorkTools]GET:allUrlstring parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* datadic) {
        NSLog(@"%@",datadic);
        
        //            [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }] resume];
}// ------想把这里改成block来着


#pragma mark - /************************* tableView数据源方法 ***************************/
/**
 *  返回几个表头
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/**
 *  每一个表头下返回几行
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

/**
 *  设置表头的高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = [NSString stringWithFormat:@"HomeCell%ld%ld",(long)indexPath.section,(long)indexPath.row];
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!cell) {
        cell = [[HomeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.xxL.text = self.homeInfo.text;
    [cell setSubviews:indexPath];
    //    cell.homeModel = _dataArr[indexPath.row];
    HomeModel *user = [HomeModel yy_modelWithJSON:_dataArr[indexPath.row]];
    cell.homeModel = user;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[_dataArr objectAtIndex:indexPath.row]];
    NSString *title = [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
    NSString *img = [NSString stringWithFormat:@"%@",[dic objectForKey:@"imgUrl"]];
    
    HomeInfoVC *vc = [[HomeInfoVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.titleStr = title;
    vc.iconImg = img;
    vc.homeInfo = self.homeInfo;
    vc.textBlock = self.textBlock;
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
