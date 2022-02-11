//
//  ABMineViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/2.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABMineViewController.h"

#import "ProfileViewController.h"
#import "SettingViewController.h"
#import "XYTransitionProtocol.h"

#import "ABOxygenBillViewController.h"
#import "ABMessageCenterViewController.h"
#import "ABSettingsViewController.h"
#import "ABHelpAndFBViewController.h"
#import "ABAboutUSViewController.h"
#import "ABProfileViewController.h"

#import "ABMineHeaderView.h"
#import "ABMineCell.h"
#import "ABMineModel.h"
#import "UserInfo.h"

#define KHeaderHeight  206//((206 * Iphone6ScaleWidth) + kStatusBarHeight)
@interface ABMineViewController ()<UITableViewDelegate,UITableViewDataSource,ABHeaderViewDelegate,XYTransitionProtocol,GWGlobalNotifyServerDelegate>
{
    UILabel * lbl;
    ABMineHeaderView *_headerView;//头部view
    UIView *_NavView;//导航栏
}
@property (nonatomic ,strong) NSMutableArray *dataSource;
@property (nonatomic ,strong) UserInfo *userInfo;
@property (nonatomic ,strong) ABMineServerModel *serverModel;
@end

@implementation ABMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHidenNaviBar = YES;
    self.StatusBarStyle = UIStatusBarStyleLightContent;
    self.isShowLiftBack = NO;//每个根视图需要设置该属性为NO，否则会出现导航栏异常
    [[ABGlobalNotifyServer sharedServer] jaf_addDelegate:self];
    self.userInfo = [UserInfo new];
    [self createUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [ABMineInterface mine_personalCenterWithParams:nil success:^(id  _Nonnull responseObject) {
        self.serverModel = [ABMineServerModel yy_modelWithDictionary:responseObject[@"data"]];
        _headerView.model = self.serverModel;
    }];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

// MARK: ABHeaderViewDelegate
-(void)headerViewClick{
    ABProfileViewController *vc = [ABProfileViewController new];
    vc.mineServerModel = self.serverModel;
    [self.navigationController pushViewController:vc animated:YES];
}

-(UIView *)targetTransitionView{
    return _headerView.headImgView;
}

-(BOOL)isNeedTransition{
    return YES;
}

// MARK: ————— 创建页面 —————
-(void)createUI{
    self.meTableView.height = KScreenHeight - kTabBarHeight;
    self.meTableView.mj_header.hidden = YES;
    self.meTableView.mj_footer.hidden = YES;
    [self.meTableView registerClass:[ABMineCell class] forCellReuseIdentifier:@"ABMineCell"];
    self.meTableView.delegate = self;
    self.meTableView.dataSource = self;
    
    _headerView = [[ABMineHeaderView alloc] initWithFrame:CGRectMake(0, -KHeaderHeight, KScreenWidth, KHeaderHeight)];
    _headerView.delegate = self;
    self.meTableView.contentInset = UIEdgeInsetsMake(_headerView.height, 0, 0, 0);
    [self.meTableView addSubview:_headerView];
    
    [self.view addSubview:self.meTableView];

    NSArray *jsonData = [ABUtils getJsonDataJsonname:@"ABMineData"];
    [jsonData enumerateObjectsUsingBlock:^(id  _Nonnull obj1, NSUInteger i, BOOL * _Nonnull stop) {
        NSMutableArray *array = [NSMutableArray array];
        [obj1 enumerateObjectsUsingBlock:^(id  _Nonnull obj2, NSUInteger j, BOOL * _Nonnull stop) {
            ABMineModel *model = [ABMineModel yy_modelWithJSON:obj2];
            [array addObject:model];
        }];
        [self.dataSource addObject:array];
    }];

    [self.tableView reloadData];
}

// MARK: ————— 创建自定义导航栏 —————
-(void)createNav{
    _NavView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, kTopHeight)];
    _NavView.backgroundColor = KClearColor;
    
    UILabel * titlelbl = [[UILabel alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, KScreenWidth/2, kNavBarHeight )];
    titlelbl.centerX = _NavView.width/2;
    titlelbl.textAlignment = NSTextAlignmentCenter;
    titlelbl.font= SYSTEMFONT(17);
    titlelbl.textColor = KWhiteColor;
    titlelbl.text = self.title;
    [_NavView addSubview:titlelbl];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"设置" forState:UIControlStateNormal];
    btn.titleLabel.font = SYSTEMFONT(16);
    [btn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    [btn sizeToFit];
    btn.frame = CGRectMake(_NavView.width - btn.width - 15, kStatusBarHeight, btn.width, 40);
    [btn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeUser) forControlEvents:UIControlEventTouchUpInside];
    
    [_NavView addSubview:btn];
    
    [self.view addSubview:_NavView];
}

// MARK: ————— tableview 代理 —————
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = _dataSource[section];
    return array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ABMineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ABMineCell" forIndexPath:indexPath];
    cell.backgroundColor = KWhiteColor;
    cell.cellModel = _dataSource[indexPath.section][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if ((indexPath.section==0&&indexPath.row==0) || (indexPath.section==1&&indexPath.row==0) || (indexPath.section==2&&indexPath.row==2)) cell.lineView.hidden = YES;
    if (indexPath.section==1) cell.newsTipsView.hidden = NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return .01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 16.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ABOxygenBillViewController *vc = [ABOxygenBillViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else if (indexPath.section == 1) {
            ABMessageCenterViewController *vc = [ABMessageCenterViewController new];
            [self.navigationController pushViewController:vc animated:YES];
    } else {
        if (indexPath.row == 0) {
            ABSettingsViewController *vc = [ABSettingsViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 1) {
            ABHelpAndFBViewController *vc = [ABHelpAndFBViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 2) {
            ABAboutUSViewController *vc = [ABAboutUSViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

// MARK: ————— scrollView 代理 —————
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y ;
    CGFloat totalOffsetY = scrollView.contentInset.top + offset;
    
    NSLog(@"offset    %.f   totalOffsetY %.f",offset,totalOffsetY);
    //    if (totalOffsetY < 0) {
    _headerView.frame = CGRectMake(0, offset, self.view.width, KHeaderHeight- totalOffsetY);
    //    }
    
}
// MARK: ————— 切换账号 —————
-(void)changeUser{
    SettingViewController *settingVC = [SettingViewController new];
    [self.navigationController pushViewController:settingVC animated:YES];
}

// MARK: 多播代理
- (void)resetUserName:(NSString *)userName {
    dispatch_async(dispatch_get_main_queue(), ^{
        //self.userInfo.nickname = userName;
//        _headerView.userInfo = self.userInfo;
    });
}

- (void)resetUserHeaderImage:(UIImage *)image {
    dispatch_async(dispatch_get_main_queue(), ^{
        //self.userInfo.image = image;
//        _headerView.userInfo = self.userInfo;
    });
}

// MARK: Lazy loading
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
