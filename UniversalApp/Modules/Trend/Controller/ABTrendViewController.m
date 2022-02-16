//
//  ABTrendViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/1.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABTrendViewController.h"
#import "ABReleaseViewController.h"
#import "ABPlantDataViewController.h"
#import "ABReportViewController.h"
#import "ABMyJournalViewController.h"
#import "ABShareViewController.h"

#import "ABTrendCell.h"
#import "ABTrendLogic.h"
#import "ABCustomNavBar.h"
#import "CustomPopOverView.h"
#import "ABPopBgView.h"

@interface ABTrendViewController ()<UITableViewDelegate,UITableViewDataSource,ABTrendDelegate,ABNavBarEventDelegate,ABTrendCellFuncDelegate,ABPopBgDelege>

@property (nonatomic,strong) ABTrendLogic * logic;
@property (nonatomic,strong) ABCustomNavBar * customNavBar;
@property (nonatomic,strong) UIButton * suspensionBtn;//悬浮按钮
@property (nonatomic,strong) CustomPopOverView *popOverView;
@property (nonatomic,strong) NSIndexPath *myIndexPath;
@end

@implementation ABTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _logic = [ABTrendLogic new];
    _logic.delegagte = self;
    
    self.isHidenNaviBar = YES;
    
    [self setupUI];
    [self.view insertSubview:self.customNavBar aboveSubview:self.tableView];
    [self.tableView.mj_header beginRefreshing];
}

- (void)setupUI {
    self.tableView.frame = CGRectMake(0, 98, KScreenWidth, KScreenHeight - 98 - kTabBarHeight);
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[ABTrendCell class] forCellReuseIdentifier:NSStringFromClass([ABTrendCell class])];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView = nil;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view bringSubviewToFront:self.suspensionBtn];
}

// MARK: actions
- (void)suspensionBtnAction:(UIButton *)sender {
    ABReleaseViewController *vc = [ABReleaseViewController new];
    [self.navigationController pushViewController:vc animated:YES];
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
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
    [UIView performWithoutAnimation:^{
        [self.tableView reloadData];
    }];
}

// MARK: ABNavBarEventDelegate
- (void)customNavBarClickEventAction:(UITapGestureRecognizer *)sender {
    ABMyJournalViewController *vc = ABMyJournalViewController.new;
    [self.navigationController pushViewController:vc animated:YES];
}

// MARK: tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _logic.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ABTrendCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ABTrendCell class]) forIndexPath:indexPath];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = nil;
    cell.model = _logic.dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.myIndexPath == indexPath) {
        return [ABTrendLogic dynamicallyCalculateCellHeight:_logic.dataArray[indexPath.row] isShowMore:YES];
    }
    return [ABTrendLogic dynamicallyCalculateCellHeight:_logic.dataArray[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

// MARK: ABTrendCellFuncDelegate
- (void)trend_LikeAction:(UIButton *)sender{DLog(@"1")}
- (void)trend_giftAction:(UIButton *)sender{DLog(@"1")}

- (void)trend_downloadAction:(UIButton *)sender{

    ABShareViewController *vc = ABShareViewController.new;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)trend_moreAction:(UIButton *)sender {
    CustomPopOverView *view = [CustomPopOverView popOverView];
    self.popOverView = view;
    ABPopBgView *bgView = [ABPopBgView loadPopBgViewWith:ABReport];
    bgView.bounds = CGRectMake(0, 0, 171, 50);
    bgView.delegate = self;
    view.style.triAngelHeight = 0;
    view.style.triAngelWidth = 0;
    view.style.containerBackgroudColor = [UIColor colorWithHexString:@"0xFFFFFF"];
    view.style.containerCornerRadius = 5;
    view.style.isNeedAnimate = NO;
    view.style.showSpace = 16;
    view.style.roundMargin = 0;
    view.style.containerBorderColor = [UIColor colorWithHexString:@"0xFFFFFF"];
    view.content = bgView;
    [view showFrom:sender alignStyle:CPAlignStyleRight relativePosition:CPContentPositionAlwaysLeft];
    
    view.backgroundColor = [UIColor clearColor];
}

- (void)trend_deviceDataPopAction:(UITapGestureRecognizer *)tap {
    ABPlantDataViewController *vc = ABPlantDataViewController.new;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)trend_updeteCellHeight:(UIButton *)sender {
    ABTrendCell *cell = (ABTrendCell *)sender.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    self.myIndexPath = indexPath;
    [ABTrendLogic dynamicallyCalculateCellHeight:_logic.dataArray[indexPath.row] isShowMore:YES];
    [self.tableView reloadData];
}

// MARK: ABPopBgDelege
- (void)popBg_reportAction:(UIButton *)sender{
    [self.popOverView dismiss];
    ABReportViewController *vc = ABReportViewController.new;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)popBg_delegeAction:(UIButton *)sender{DLog(@"2");}

// MARK: Lazy loading
- (ABCustomNavBar *)customNavBar {
    if (!_customNavBar) {
        _customNavBar = [[ABCustomNavBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 98)];
        _customNavBar.delegate = self;
    }
    return _customNavBar;
}

- (UIButton *)suspensionBtn {
    if (!_suspensionBtn) {
        _suspensionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_suspensionBtn setImage:ImageName(@"trend_icon_add") forState:UIControlStateNormal];
        [_suspensionBtn addTarget:self action:@selector(suspensionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_suspensionBtn];
        [_suspensionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-(kTabBarHeight+16));
            make.right.mas_equalTo(-16);
        }];

    }
    return _suspensionBtn;
}
@end
