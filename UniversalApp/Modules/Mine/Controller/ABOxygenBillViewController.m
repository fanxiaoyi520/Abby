//
//  ABOxygenBillViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/8.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABOxygenBillViewController.h"
#import "ABOxygenBillCell.h"
#import "ABOxygenBillHeaderView.h"
#import "ABOxygenBillModel.h"
#import "ABOxygenBillLogic.h"

@interface ABOxygenBillViewController ()<UITableViewDelegate,UITableViewDataSource,ABGlobalDelegate>

@property (nonatomic,strong) ABOxygenBillLogic * logic;
@end

@implementation ABOxygenBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _logic = [ABOxygenBillLogic new];
    _logic.delegagte = self;
    
    self.isHidenNaviBar = NO;
    self.isShowLiftBack = YES;
    [self addNavigationItemWithImageNames:@[@"icon_t_tips"] isLeft:NO target:self action:@selector(rightBtnClick:) tags:@[@2001]];

    self.navTitle = @"Oxygen bill";
    [self setupUI];
    [self.meTableView.mj_header beginRefreshing];
}

- (void)setupUI {
    self.meTableView.height = KScreenHeight - kTopHeight;
    [self.meTableView registerClass:[ABOxygenBillCell class] forCellReuseIdentifier:@"ABOxygenBillCell"];
    self.meTableView.delegate = self;
    self.meTableView.dataSource = self;
    [self.view addSubview:self.meTableView];
}

// MARK: ————— 下拉刷新 —————
-(void)headerRereshing{
    [_logic.dataArray removeAllObjects];
    [_logic loadData];
}

// MARK: ————— 上拉刷新 —————
-(void)footerRereshing{
    [_logic loadData];
}

// MARK: ————— 数据拉取完成 渲染页面 —————
-(void)requestDataCompleted{
    [self.meTableView.mj_footer endRefreshing];
    [self.meTableView.mj_header endRefreshing];
    [UIView performWithoutAnimation:^{
        [self.meTableView reloadData];
    }];
}

// MARK: actions
- (void)rightBtnClick:(UIButton *)btn {
    XLWebViewController *vc = [[XLWebViewController alloc] initWithUrl:web_url_directions withNavTitle:@"Directions"];
    [self.navigationController pushViewController:vc animated:YES];
}

// MARK: ————— tableview 代理 —————
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _logic.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ABOxygenBillModel *model = _logic.dataArray[section];
    return model.list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ABOxygenBillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ABOxygenBillCell" forIndexPath:indexPath];
    ABOxygenBillModel *model = _logic.dataArray[indexPath.section];
    cell.cellModel = model.list[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.row == model.list.count-1) {
        cell.lineView.hidden = YES;
    } else {
        cell.lineView.hidden = NO;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ABOxygenBillHeaderView *headerView = [[ABOxygenBillHeaderView alloc] init];
    headerView.headerModel = _logic.dataArray[section];
    return headerView;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([view isKindOfClass:[ABOxygenBillHeaderView class]]) {
        ((ABOxygenBillHeaderView *)view).contentView.backgroundColor = [UIColor colorWithHexString:@"0xFFFFFF"];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 58.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 147.5f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 16.0f;
}

@end
