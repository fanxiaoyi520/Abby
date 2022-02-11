//
//  ABAboutUSViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/13.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABAboutUSViewController.h"
#import "ABRateViewController.h"
#import "ABAboutUSCell.h"

@interface ABAboutUSViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) NSArray *dataArray;
@end

@implementation ABAboutUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isHidenNaviBar = NO;
    self.isShowLiftBack = YES;
    self.navTitle = @"About us";
    
    self.dataArray = @[@[@"Learn about BAYPAC",@"Rate"],@[@"Terms of Use",@"Privacy Policy"]];
    [self setupUI];
}

- (void)setupUI {
    self.meTableView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - kTopHeight);
    [self.view addSubview:self.meTableView];
    [self.meTableView registerClass:[ABAboutUSCell class] forCellReuseIdentifier:NSStringFromClass([ABAboutUSCell class])];
    self.meTableView.delegate = self;
    self.meTableView.dataSource = self;
    self.meTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.meTableView.mj_header.hidden = YES;
    self.meTableView.mj_footer.hidden = YES;
}

// MARK: tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = _dataArray[section];
    return array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ABAboutUSCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ABAboutUSCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleStr = _dataArray[indexPath.section][indexPath.row];
    if (indexPath.row == _dataArray.count-1) {
        cell.lineView.hidden = YES;
    } else {
        cell.lineView.hidden = NO;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) return 16;
    return .01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 16;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            ABRateViewController *vc = [ABRateViewController new];
            vc.modalPresentationStyle = UIModalPresentationCustom;
            vc.transitioningDelegate = self;
            [self presentViewController:vc animated:YES completion:nil];
        } else {
            XLWebViewController *vc = [[XLWebViewController alloc] initWithUrl:web_url_privacyPolicy withNavTitle:@"《Terms of Use and Privacy》"];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else {
        if (indexPath.row == 0) {
            XLWebViewController *vc = [[XLWebViewController alloc] initWithUrl:web_url_privacyPolicy withNavTitle:@"《Terms of Use and Privacy》"];
            vc.navRightStr = @"Disagree";
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            XLWebViewController *vc = [[XLWebViewController alloc] initWithUrl:web_url_personal withNavTitle:@"《Privacy Policy》"];
            vc.navRightStr = @"Disagree";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
@end
