//
//  ABBluetoothSearchViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/11/25.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABBluetoothSearchViewController.h"
#import "ABBlueToothSearchCell.h"
#import "ABAddBTSSuccessViewController.h"
#import "ABScanHelpViewController.h"
#import "ABTipsViewController.h"

#define TIME 60
@interface ABBluetoothSearchViewController ()<UITableViewDelegate,UITableViewDataSource,TuyaSmartBLEManagerDelegate,ABAddBlueToothDelegate>

@property (nonatomic ,strong) UILabel *contentLab;
@property (nonatomic ,strong) LOTAnimationView *lottieLogo;
@property (nonatomic ,strong) UITableView *bluetoothTableView;
@property (nonatomic ,strong) NSMutableArray <TYBLEAdvModel *> *dataList;

@end

@implementation ABBluetoothSearchViewController
- (void)dealloc {
    [self.timer pause];
    [self.timer invalidate];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.lottieLogo play];
    self.timeNum = 0;
    [self.timer fire];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //[[TuyaSmartBLEManager sharedInstance] stopListening:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.lottieLogo pause];
    [self.timer pause];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[ABGlobalNotifyServer sharedServer] jaf_addDelegate:self];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"0xFBFFFD"];
    self.isHidenNaviBar = NO;
    self.isShowLiftBack = NO;
    [self addNavigationItemWithTitles
     :@[@"Cancel"] isLeft:YES target:self action:@selector(naviBtnClick:) tags:@[@1000]];
    self.navTitle = @"1/3";

    [self.dataList removeAllObjects];
    [TuyaSmartBLEManager sharedInstance].delegate = self;
    [[TuyaSmartBLEManager sharedInstance] startListening:YES];
    
    // 计时一分钟，未发现设备则跳转帮助页
    self.timeNum = 0;
    self.timer = [ZYGCDTimer timerWithTimeInterval:1 userInfo:nil repeats:YES dispatchQueue:dispatch_get_main_queue() block:^(ZYGCDTimer * _Nonnull timer) {
        self.timeNum++;
        if (self.timeNum >= TIME) {
            [timer pause];
            ABScanHelpViewController* vc = [ABScanHelpViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
    
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.contentLab];
    self.contentLab.frame = CGRectMake(26, 47, kScreenWidth-26*2, 0);
    CGFloat conHeight = [self.contentLab.text getHeightWithWidth:self.contentLab.width Font:FONT_REGULAR(15)];
    self.contentLab.height = conHeight;
    
    [self.view addSubview:self.lottieLogo];
    self.lottieLogo.frame = CGRectMake(26, self.contentLab.bottom+30, kScreenWidth-26*2, 200);
    
    [self.view addSubview:self.bluetoothTableView];
    self.bluetoothTableView.frame = CGRectMake(0, self.lottieLogo.bottom+30, KScreenWidth, 60*5+30);
}

// MARK: actions
- (void)naviBtnClick:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

// MARK: TuyaSmartBLEManagerDelegate
/**
 * 蓝牙状态变化通知
 *
 * @param isPoweredOn 蓝牙状态，开启或关闭
 */
- (void)bluetoothDidUpdateState:(BOOL)isPoweredOn {
    if (!isPoweredOn) {
        [UIViewController jaf_showHudTip:@"Bluetooth is not turned on, turn on Bluetooth in settings"];
    }
}

/**
 * 扫描到未激活的设备
 *
 * @param deviceInfo 未激活设备信息 Model
 */
- (void)didDiscoveryDeviceWithDeviceInfo:(TYBLEAdvModel *)deviceInfo {
    
    // 成功扫描到未激活的设备
    // 若设备已激活，则不会走此回调，且会自动进行激活连接
//    [self.timer pause];
    if (![self.dataList containsObject:deviceInfo]) {
        [self.dataList addObject:deviceInfo];
    }

    [self.bluetoothTableView reloadData];
    self.navTitle = @"2/3";
}

// MARK: UITableViewDelegate & UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ABBlueToothSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ABBlueToothSearchCell" forIndexPath:indexPath];
    cell.peripheral = _dataList[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
}

// MARK: ABAddBlueToothDelegate
- (void)addBlueTooth:(id)info {
    UIButton *btn = (UIButton *)info;
    if ([btn.superview.superview isKindOfClass:ABBlueToothSearchCell.class]) {
        ABBlueToothSearchCell *cell = (ABBlueToothSearchCell *)btn.superview.superview;
        NSIndexPath *indexPath = [self.bluetoothTableView indexPathForCell:cell];
        ABAddBTSSuccessViewController *vc = [ABAddBTSSuccessViewController new];
        vc.peripheral = _dataList[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
//    //如果设备被绑定
//    ABTipsViewController *vc = [ABTipsViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
}

// MARK: ABGlobalNotifyServer
- (void)resetDeviceNext {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.timeNum = 0;
        [self.timer fire];
    });
}

// MARK: Lazy loading
- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [[UILabel alloc] init];
        _contentLab.numberOfLines = 0;
        _contentLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        _contentLab.text = @"Scanning for device nearby, please move your phone as close as possible to the device.";
        _contentLab.font = FONT_REGULAR(15);
        _contentLab.textAlignment = NSTextAlignmentLeft;
    }
    return _contentLab;
}

- (LOTAnimationView *)lottieLogo {
    if (!_lottieLogo) {
        _lottieLogo = [LOTAnimationView animationNamed:@"ab_bluetooth_search_gif"];
        _lottieLogo.contentMode = UIViewContentModeScaleAspectFill;
        _lottieLogo.loopAnimation = YES;
    }
    return _lottieLogo;
}

- (UITableView *)bluetoothTableView
{
    if (_bluetoothTableView == nil) {
        _bluetoothTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _bluetoothTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _bluetoothTableView.estimatedRowHeight = 0;
        _bluetoothTableView.estimatedSectionHeaderHeight = 0;
        _bluetoothTableView.estimatedSectionFooterHeight = 0;
        _bluetoothTableView.delegate = self;
        _bluetoothTableView.dataSource = self;
        _bluetoothTableView.showsVerticalScrollIndicator = NO;
        _bluetoothTableView.showsHorizontalScrollIndicator = NO;
        _bluetoothTableView.backgroundColor = [UIColor clearColor];
        _bluetoothTableView.backgroundView = nil;
        _bluetoothTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_bluetoothTableView registerClass:ABBlueToothSearchCell.class forCellReuseIdentifier:@"ABBlueToothSearchCell"];
        if (@available(iOS 15.0, *)) {
            _bluetoothTableView.sectionHeaderTopPadding = 0;
        }
    }
    return _bluetoothTableView;
}

- (NSMutableArray <TYBLEAdvModel *>*)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}
@end
