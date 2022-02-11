//
//  ABUpgradeViewController.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/25.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABUpgradeViewController.h"
#import "ABPopUpgradeViewController.h"

@interface ABUpgradeViewController ()<ABPopUpgradeDelegate>

@property (nonatomic ,strong)UIView *vBgview;
@property (nonatomic ,strong)UILabel *vLab;
@property (nonatomic ,strong)UILabel *conLab;
@property (nonatomic ,strong)UIButton *sureBtn;
@end

@implementation ABUpgradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isHidenNaviBar = NO;
    self.isShowLiftBack = YES;
    self.navTitle = @"Upgrade";
//    DLog(@"%@",[[DeviceManager sharedDeviceManager] getDevice]);
//    [[[DeviceManager sharedDeviceManager] getDevice] getFirmwareUpgradeInfo:^(NSArray<TuyaSmartFirmwareUpgradeModel *> *upgradeModelList) {
//        NSLog(@"getFirmwareUpgradeInfo success");
//    } failure:^(NSError *error) {
//        NSLog(@"getFirmwareUpgradeInfo failure: %@", error);
//    }];
    
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.vBgview];
    
    self.vLab.text = @"Ve 1.2";
    [self.vBgview addSubview:self.vLab];
    
    self.conLab.text = @"1.Follow the APP instruction, change\n2.open the front door of the device, put the pipe into the bucket, operate on APP to start the pumping water; In the meantime, turn the water tank cover over to observe the situation of Root; after the pumping, check whether there are dead roots or trash on the pipe filter. If so, clean it up, and then place the tube back to the fixed position at the bottom of the tank;";
    [self.view addSubview:self.conLab];
    CGRect contentLabRect = [self.conLab.text boundingRectWithSize:CGSizeMake(self.conLab.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.conLab.font} context:nil];
    self.conLab.height = contentLabRect.size.height;
    [self.conLab sizeToFit];
    
    [self.view addSubview:self.sureBtn];
}

// MARK: actions
- (void)sureBtnAction:(UIButton *)sender {
    ABPopUpgradeViewController *vc = ABPopUpgradeViewController.new;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

// MARK: ABPopUpgradeDelegate
- (void)abPop_upgradeSuccess:(UIButton *)sender {
    self.conLab.text = @"There is currently no firmware to upgrade";
    self.conLab.textAlignment = NSTextAlignmentCenter;
    self.sureBtn.hidden = YES;
    self.vLab.text = @"Ve 1.3";
}

// MARK: Lazy loading
- (UIView *)vBgview {
    if (!_vBgview) {
        _vBgview = UIView.new;
        _vBgview.backgroundColor = KWhiteColor;
        _vBgview.frame = CGRectMake((kScreenWidth-160)/2, 40, 160, 160);
        ViewRadius(_vBgview, 80);
    }
    return _vBgview;
}

- (UILabel *)vLab {
    if (!_vLab) {
        _vLab = UILabel.new;
        _vLab.font = FONT_BOLD(30);
        _vLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        _vLab.textAlignment = NSTextAlignmentCenter;
        _vLab.frame = CGRectMake(0, (self.vBgview.height-36)/2, self.vBgview.width, 36);
    }
    return _vLab;
}

- (UILabel *)conLab {
    if (!_conLab) {
        _conLab = UILabel.new;
        _conLab.font = FONT_REGULAR(15);
        _conLab.textColor = [UIColor colorWithHexString:@"0x161B19"];
        _conLab.numberOfLines = 0;
        _conLab.frame = CGRectMake(40, self.vBgview.bottom+40, kScreenWidth-40*2, 0);
    }
    return _conLab;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = UIButton.new;
        _sureBtn.frame = CGRectMake(24, kScreenHeight-60-24-CONTACTS_SAFE_BOTTOM-CONTACTS_HEIGHT_NAV, kScreenWidth-24*2, 60);
        _sureBtn.backgroundColor = [UIColor colorWithHexString:@"0x006241"];
        [_sureBtn setTitle:@"Upgrade" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = FONT_MEDIUM(18);
        [_sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        ViewRadius(_sureBtn, 30);
    }
    return _sureBtn;
}
@end
