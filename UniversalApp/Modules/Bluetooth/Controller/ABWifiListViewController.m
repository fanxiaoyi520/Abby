//
//  ABWifiListViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/11/26.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABWifiListViewController.h"
#import "ABWifiListCell.h"
#import <NetworkExtension/NetworkExtension.h>

@interface ABWifiListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UIView *bgView;
@property (nonatomic ,strong) UITableView *wifiTableView;
@property (nonatomic ,strong) NSMutableArray *dataList;
@end

@implementation ABWifiListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *array = @[@"Wework",@"Wework",@"Wework",@"Wework",@"Wework",@"Wework",@"Wework",@"Wework",@"Wework",@"Wework",@"Wework"];
    [self.dataList addObjectsFromArray:array];
    
    [self getWifiList];
    [self setupUI];
}

- (void)getWifiList {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {return;}
    dispatch_queue_t queue = dispatch_queue_create("com.leopardpan.HotspotHelper", 0);
    [NEHotspotHelper registerWithOptions:nil queue:queue handler: ^(NEHotspotHelperCommand * cmd) {
        if(cmd.commandType == kNEHotspotHelperCommandTypeFilterScanList) {
            for (NEHotspotNetwork* network  in cmd.networkList) {
                NSLog(@"network.SSID = %@",network.SSID);
            }
        }
    }];
}

- (void)setupUI {
    [self.view addSubview:self.bgView];
    self.bgView.frame = CGRectMake(48, (kScreenHeight-423)/2, kScreenWidth-48*2, 423);
    [UIView jaf_cutOptionalFillet:self.bgView byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(25, 25)];
    
    [self.bgView addSubview:self.wifiTableView];
    self.wifiTableView.frame = CGRectMake(0, 30, self.bgView.width, self.bgView.height-30*2);
}

// MARK: UITableViewDelegate & UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ABWifiListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ABWifiListCell" forIndexPath:indexPath];
    cell.model = _dataList[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.delegate = self;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.block) {
            self.block(_dataList[indexPath.row]);
        }
    }];
}

// MAKR: Lazy loading
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = KWhiteColor;
    }
    return _bgView;
}

- (UITableView *)wifiTableView
{
    if (_wifiTableView == nil) {
        _wifiTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _wifiTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _wifiTableView.estimatedRowHeight = 0;
        _wifiTableView.estimatedSectionHeaderHeight = 0;
        _wifiTableView.estimatedSectionFooterHeight = 0;
        _wifiTableView.delegate = self;
        _wifiTableView.dataSource = self;
        _wifiTableView.showsVerticalScrollIndicator = NO;
        _wifiTableView.showsHorizontalScrollIndicator = NO;
        _wifiTableView.backgroundColor = [UIColor clearColor];
        _wifiTableView.backgroundView = nil;
        _wifiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_wifiTableView registerClass:ABWifiListCell.class forCellReuseIdentifier:@"ABWifiListCell"];
        if (@available(iOS 15.0, *)) {
            _wifiTableView.sectionHeaderTopPadding = 0;
        }
    }
    return _wifiTableView;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}
@end
