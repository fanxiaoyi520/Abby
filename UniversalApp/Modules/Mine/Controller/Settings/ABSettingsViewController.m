//
//  ABSettingsViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/9.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABSettingsViewController.h"
#import "ABReplantViewController.h"
#import "ABDeleteDeviceViewController.h"
#import "ABInputPWDViewController.h"
#import "XLWebViewController.h"
#import "ABPreChangeWaterViewController.h"
#import "ABUpgradeViewController.h"

#import "ABSettingsHeaderView.h"
#import "ABSettingCell.h"

#define GlobalSectionSpacing 8
@interface ABSettingsViewController ()<UITableViewDelegate,UITableViewDataSource,ABSettingsDelegate>

@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) NSMutableArray *dataArray;
@end

@implementation ABSettingsViewController
{
    CGFloat _globalSectionSpacing;
    NSArray *_deviceArray;
    NSArray *_appArray;
    BOOL _isApp;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isHidenNaviBar = NO;
    self.isShowLiftBack = YES;
    self.navTitle = @"Settings";
//    [[self.navigationController.navigationBar.subviews objectAtIndex:0] setAlpha:0];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init]forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    _deviceArray = @[@[@"Current firmware",@"Firmware upgrade"],@[@"Clean the water tank",@"Replant"],@[@"Delete Device"]];
    _appArray = @[@[@"Notifications"],@[@"Vision",@"New Vision"]];
    
    self.isHaveDevice = YES;
    _isApp = self.isHaveDevice ? NO : YES;

    [self setupUI];
}

- (void)setupUI {
    
    self.meTableView.height = KScreenHeight - kTopHeight;
    [self.meTableView registerClass:[ABSettingCell class] forCellReuseIdentifier:@"ABSettingCell"];
    self.meTableView.mj_header.hidden = YES;
    self.meTableView.mj_footer.hidden = YES;
    self.meTableView.delegate = self;
    self.meTableView.dataSource = self;
    self.meTableView.scrollEnabled = NO;
    [self.view addSubview:self.meTableView];
    
    if (self.isHaveDevice) {
        ABSettingsHeaderView *headerView = [[ABSettingsHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 48)];
        self.meTableView.tableHeaderView = headerView;
        headerView.delegate = self;
        [self.dataArray addObjectsFromArray:_deviceArray];
        _globalSectionSpacing = GlobalSectionSpacing*2;
    } else {
        [self.dataArray addObjectsFromArray:_appArray];
        _globalSectionSpacing = GlobalSectionSpacing;
    }
}

// MARK: ABSettingsDelegate
- (void)switchSetting:(UIButton *)sender {
    if (sender.tag == 100) {
        _isApp = NO;
        self.dataArray = _deviceArray.mutableCopy;
        _globalSectionSpacing = GlobalSectionSpacing*2;
        [self.meTableView reloadData];
    } else {
        _isApp = YES;
        self.dataArray = _appArray.mutableCopy;
        _globalSectionSpacing = GlobalSectionSpacing;
        [self.meTableView reloadData];
    }
}

//// MARK: ————— tableview 代理 —————
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.dataArray[section];
    return array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ABSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ABSettingCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    while ([cell.contentView.subviews lastObject] != nil) {
        [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    if (self.isHaveDevice && !_isApp) {
        [cell layoutAndLoadData:self.dataArray[indexPath.section][indexPath.row] isApp:NO myIndexPath:indexPath];
    } else {
        [cell layoutAndLoadData:self.dataArray[indexPath.section][indexPath.row] isApp:YES myIndexPath:indexPath];;
    }
    
    NSArray *array = self.dataArray[indexPath.section];
    if (indexPath.row == array.count-1) {
        cell.lineView.hidden = YES;
    } else {
        cell.lineView.hidden = NO;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((self.isHaveDevice && _isApp && indexPath.section==0) || (!self.isHaveDevice && indexPath.section==0)) return 70;
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) return _globalSectionSpacing;
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return _globalSectionSpacing;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isHaveDevice && !_isApp) {
        kWeakSelf(self);
        if (indexPath.section == 0 && indexPath.row == 1) {
            ABUpgradeViewController *vc = ABUpgradeViewController.new;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        if (indexPath.section == 1 && indexPath.row == 0) {
            ABPreChangeWaterViewController *vc = [ABPreChangeWaterViewController new];
            vc.modalPresentationStyle = UIModalPresentationCustom;
            vc.transitioningDelegate = self;
//            vc.delegate = self;
            [self presentViewController:vc animated:YES completion:nil];
        }
        
        if (indexPath.section == 1 && indexPath.row == 1) {
            ABReplantViewController *vc = [ABReplantViewController new];
            vc.modalPresentationStyle = UIModalPresentationCustom;
            vc.transitioningDelegate = self;
            vc.block = ^() {
                [weakself.navigationController popViewControllerAnimated:NO];
                MainTabBarController *mainTBC = (MainTabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
                [mainTBC setSelectedIndex:0];
                
            };
            [self presentViewController:vc animated:YES completion:nil];
        }
        if (indexPath.section == 2) {
            ABDeleteDeviceViewController *vc = [ABDeleteDeviceViewController new];
            vc.modalPresentationStyle = UIModalPresentationCustom;
            vc.transitioningDelegate = self;
            vc.block = ^() {
                ABInputPWDViewController *vc = [ABInputPWDViewController new];
                vc.modalPresentationStyle = UIModalPresentationCustom;
                vc.transitioningDelegate = self;
    //            vc.block = ^(id  _Nonnull info) {
    //                weakself.wifiNameLab.text = (NSString *)info;
    //            };
                [self presentViewController:vc animated:YES completion:nil];
            };
            [self presentViewController:vc animated:YES completion:nil];
        }
        
    } else {
        if (indexPath.section == 1 && indexPath.row == 1) {
            [XHVersion checkNewVersion];
        }
    }
}

// MARK: Lazy loading
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
