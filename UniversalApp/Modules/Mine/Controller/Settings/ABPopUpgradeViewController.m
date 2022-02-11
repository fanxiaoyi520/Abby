//
//  ABPopUpgradeViewController.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/25.
//  Copyright © 2022 徐阳. All rights reserved.
//
typedef NS_ENUM(NSInteger, PopTypeStatus) {
    Precautions,
    Upgrading,
    UpdateSuccessed,
    UpgradeFailed,
};

#define TIME 2
#import "ABPopUpgradeViewController.h"

@interface ABPopUpgradeViewController ()

@property (nonatomic ,strong) UIView *precautionsBgView;
@property (nonatomic ,strong) UILabel *ptitleLab;
@property (nonatomic ,strong) UILabel *pconLab;
@property (nonatomic ,strong) UIView *pwlineView;
@property (nonatomic ,strong) UIView *phlineView;

@property (nonatomic ,strong) UIView *upgradingBgView;
@property (nonatomic ,strong) UILabel *utitleLab;
@property (nonatomic ,strong) FLAnimatedImageView *ugifImgView;
@property (nonatomic ,strong) LOTAnimationView *ulottieLogo;
@property (nonatomic ,strong) ZYGCDTimer *timer;
@property (nonatomic ,assign) NSInteger timeNum;

@property (nonatomic ,strong) UIView *updateSuccessedBgView;
@property (nonatomic ,strong) UILabel *updtitleLab;
@property (nonatomic ,strong) UIImageView *updLogoImgView;
@property (nonatomic ,strong) UIView *updLineView;
@property (nonatomic ,strong) UIButton *updSureBtn;

@property (nonatomic ,strong) UIView *upgradeFailedBgView;
@property (nonatomic ,strong) UILabel *upgtitleLab;
@property (nonatomic ,strong) UILabel *upgconLab;
@property (nonatomic ,strong) UIView *upgwlineView;
@property (nonatomic ,strong) UIView *upghlineView;

@end

@implementation ABPopUpgradeViewController
- (void)dealloc {
    [self.timer pause];
    [self.timer invalidate];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.timeNum = 0;
    [self.ulottieLogo play];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.ulottieLogo pause];
    [self.timer pause];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUIWithPrecautionsBgView];
}

// MARK: actions
- (void)precautionsBgViewAction:(UIButton *)sender {
    if (sender.tag == 100) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self updateUIWithUpgradingBgView];
    }
}

- (void)updSureBtnAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(abPop_upgradeSuccess:)]) {
            [self.delegate abPop_upgradeSuccess:sender];
        }
    }];

    //[self updateUIWithUpgradeFailedBgView];
}

- (void)upgradeFailedBgViewAction:(UIButton *)sender {
    if (sender.tag == 100) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self updateUIWithUpgradingBgView];
    }
}

// MARK : precautionsBgView
- (void)setupUIWithPrecautionsBgView {
    [self.view addSubview:self.precautionsBgView];
    
    [self.precautionsBgView addSubview:self.ptitleLab];
    
    [self.precautionsBgView addSubview:self.pconLab];
    CGRect contentLabRect = [self.pconLab.text boundingRectWithSize:CGSizeMake(self.pconLab.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.pconLab.font} context:nil];
    self.pconLab.height = contentLabRect.size.height;
    [self.pconLab sizeToFit];
    
    self.precautionsBgView.height = self.precautionsBgView.height+contentLabRect.size.height;
    self.precautionsBgView.centerY = self.view.centerY;
    
    [self.precautionsBgView addSubview:self.pwlineView];
    [self.precautionsBgView addSubview:self.phlineView];
    
    NSArray *array = @[@"Cancel",@"Upgrade"];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = UIButton.new;
        btn.frame = CGRectMake(idx*(self.precautionsBgView.width/2), self.pwlineView.bottom, self.precautionsBgView.width/2, ratioH(60));
        [btn setTitle:array[idx] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"0x006241"] forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_MEDIUM(18);
        btn.tag = 100+idx;
        [btn addTarget:self action:@selector(precautionsBgViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.precautionsBgView addSubview:btn];
    }];
}

- (UIView *)precautionsBgView {
    if (!_precautionsBgView) {
        _precautionsBgView = [[UIView alloc] init];
        _precautionsBgView.userInteractionEnabled = YES;
        _precautionsBgView.frame = CGRectMake((kScreenWidth-ratioW(281))/2, (kScreenHeight-ratioH(230))/2, ratioW(281), ratioH(55)+ratioH(90));
        _precautionsBgView.backgroundColor = KWhiteColor;
        ViewRadius(_precautionsBgView, 15);
    }
    return _precautionsBgView;
}

- (UILabel *)ptitleLab {
    if (!_ptitleLab) {
        _ptitleLab = UILabel.new;
        _ptitleLab.font = FONT_BOLD(16);
        _ptitleLab.textColor = [UIColor colorWithHexString:@"0x161B19"];
        _ptitleLab.textAlignment = NSTextAlignmentCenter;
        _ptitleLab.frame = CGRectMake(0, ratioH(24), self.precautionsBgView.width, ratioH(21));
        _ptitleLab.text = @"Precautions";
    }
    return _ptitleLab;
}

- (UILabel *)pconLab {
    if (!_pconLab) {
        _pconLab = UILabel.new;
        _pconLab.font = FONT_REGULAR(13);
        _pconLab.textColor = [UIColor colorWithHexString:@"0x161B19"];
        _pconLab.frame = CGRectMake(0, ratioH(24), self.precautionsBgView.width, ratioH(21));
        _pconLab.text = @"* The upgrade may take a few minutes, and the device will not work during the upgrade process.\n* Please do not power off or reset during the update";
        _pconLab.numberOfLines = 0;
        _pconLab.frame = CGRectMake(ratioW(16), self.ptitleLab.bottom+ratioH(10), self.precautionsBgView.width-ratioW(16)*2, 0);
    }
    return _pconLab;
}

- (UIView *)pwlineView {
    if (!_pwlineView) {
        _pwlineView = UIView.new;
        _pwlineView.backgroundColor = kLineColor;
        _pwlineView.frame = CGRectMake(0, self.precautionsBgView.height-ratioH(60), self.precautionsBgView.width, 1);
    }
    return _pwlineView;
}

- (UIView *)phlineView {
    if (!_phlineView) {
        _phlineView = UIView.new;
        _phlineView.backgroundColor = kLineColor;
        _phlineView.frame = CGRectMake(self.precautionsBgView.width/2-.5, self.precautionsBgView.height-ratioH(60), 1, ratioH(59));
    }
    return _phlineView;
}

// MARK : upgradingBgView
- (void)updateUIWithUpgradingBgView {
    [self.view removeAllSubviews];
    
    // 计时一分钟，未发现设备则跳转帮助页
    self.timeNum = 0;
    self.timer = [ZYGCDTimer timerWithTimeInterval:1 userInfo:nil repeats:YES dispatchQueue:dispatch_get_main_queue() block:^(ZYGCDTimer * _Nonnull timer) {
        self.timeNum++;
        if (self.timeNum >= TIME) {
            [timer pause];
            [self updateUIWithUpdateSuccessedBgView];
        }
    }];
    [self.timer fire];
    [self.view addSubview:self.upgradingBgView];
    [self.upgradingBgView addSubview:self.utitleLab];
    [self.upgradingBgView addSubview:self.ulottieLogo];
}

- (UIView *)upgradingBgView {
    if (!_upgradingBgView) {
        _upgradingBgView = [[UIView alloc] init];
        _upgradingBgView.userInteractionEnabled = YES;
        _upgradingBgView.frame = CGRectMake((kScreenWidth-ratioW(281))/2, (kScreenHeight-ratioH(167))/2, ratioW(281), ratioH(167));
        _upgradingBgView.backgroundColor = KWhiteColor;
        ViewRadius(_upgradingBgView, 15);
    }
    return _upgradingBgView;
}

- (UILabel *)utitleLab {
    if (!_utitleLab) {
        _utitleLab = UILabel.new;
        _utitleLab.font = FONT_BOLD(16);
        _utitleLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        _utitleLab.textAlignment = NSTextAlignmentCenter;
        _utitleLab.frame = CGRectMake(0, ratioH(24), self.precautionsBgView.width, ratioH(21));
        _utitleLab.text = @"Upgrading";
    }
    return _utitleLab;
}

- (LOTAnimationView *)ulottieLogo {
    if (!_ulottieLogo) {
        _ulottieLogo = [LOTAnimationView animationNamed:@"loading"];
        _ulottieLogo.contentMode = UIViewContentModeScaleAspectFill;
        _ulottieLogo.loopAnimation = YES;
        _ulottieLogo.frame = CGRectMake(ratioW(16), self.utitleLab.bottom+ratioH(40), self.upgradingBgView.width-ratioW(16)*2, ratioH(44));
    }
    return _ulottieLogo;
}

// MARK : updateSuccessedBgView
- (void)updateUIWithUpdateSuccessedBgView {
    [self.view removeAllSubviews];
    
    [self.view addSubview:self.updateSuccessedBgView];
    [self.updateSuccessedBgView addSubview:self.updtitleLab];
    [self.updateSuccessedBgView addSubview:self.updLogoImgView];
    [self.updateSuccessedBgView addSubview:self.updLineView];
    [self.updateSuccessedBgView addSubview:self.updSureBtn];
}

- (UIView *)updateSuccessedBgView {
    if (!_updateSuccessedBgView) {
        _updateSuccessedBgView = [[UIView alloc] init];
        _updateSuccessedBgView.userInteractionEnabled = YES;
        _updateSuccessedBgView.frame = CGRectMake((kScreenWidth-ratioW(281))/2, (kScreenHeight-ratioH(328))/2, ratioW(281), ratioH(328));
        _updateSuccessedBgView.backgroundColor = KWhiteColor;
        ViewRadius(_updateSuccessedBgView, 15);
    }
    return _updateSuccessedBgView;
}

- (UILabel *)updtitleLab {
    if (!_updtitleLab) {
        _updtitleLab = UILabel.new;
        _updtitleLab.font = FONT_BOLD(16);
        _updtitleLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        _updtitleLab.textAlignment = NSTextAlignmentCenter;
        _updtitleLab.frame = CGRectMake(0, ratioH(24), self.precautionsBgView.width, ratioH(21));
        _updtitleLab.text = @"Update successed";
    }
    return _updtitleLab;
}

- (UIImageView *)updLogoImgView {
    if (!_updLogoImgView) {
        _updLogoImgView = UIImageView.new;
        _updLogoImgView.frame = CGRectMake((self.updateSuccessedBgView.width-ratioW(155))/2, self.updtitleLab.bottom+ratioH(32), ratioW(155), ratioH(162));
        _updLogoImgView.image = ImageName(@"pic_succ");
    }
    return _updLogoImgView;
}

- (UIView *)updLineView {
    if (!_updLineView) {
        _updLineView = UIView.new;
        _updLineView.backgroundColor = kLineColor;
        _updLineView.frame = CGRectMake(0, self.updateSuccessedBgView.height-ratioH(60), self.updateSuccessedBgView.width, 1);
    }
    return _updLineView;
}

- (UIButton *)updSureBtn {
    if (!_updSureBtn) {
        _updSureBtn = UIButton.new;
        _updSureBtn.frame = CGRectMake(0, self.updateSuccessedBgView.height-ratioH(60), self.updateSuccessedBgView.width, ratioH(60));
        [_updSureBtn setTitle:@"OK" forState:UIControlStateNormal];
        [_updSureBtn setTitleColor:[UIColor colorWithHexString:@"0x006241"] forState:UIControlStateNormal];
        _updSureBtn.titleLabel.font = FONT_MEDIUM(18);
        [_updSureBtn addTarget:self action:@selector(updSureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _updSureBtn;
}

// MARK : upgradeFailedBgView
- (void)updateUIWithUpgradeFailedBgView {
    [self.view removeAllSubviews];
    
    [self.view addSubview:self.upgradeFailedBgView];
    [self.upgradeFailedBgView addSubview:self.upgtitleLab];
    
    [self.upgradeFailedBgView addSubview:self.upgconLab];
    CGRect contentLabRect = [self.upgconLab.text boundingRectWithSize:CGSizeMake(self.upgconLab.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.upgconLab.font} context:nil];
    self.upgconLab.height = contentLabRect.size.height;
    [self.upgconLab sizeToFit];
    
    self.upgradeFailedBgView.height = ratioH(145)+contentLabRect.size.height;
    self.upgradeFailedBgView.centerY = self.view.centerY;
    
    [self.upgradeFailedBgView addSubview:self.upgwlineView];
    [self.upgradeFailedBgView addSubview:self.upghlineView];
    
    NSArray *array = @[@"Cancel",@"Retry"];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = UIButton.new;
        btn.frame = CGRectMake(idx*(self.upgradeFailedBgView.width/2), self.upgwlineView.bottom, self.upgradeFailedBgView.width/2, ratioH(60));
        [btn setTitle:array[idx] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"0x006241"] forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_MEDIUM(18);
        btn.tag = 100+idx;
        [btn addTarget:self action:@selector(upgradeFailedBgViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.upgradeFailedBgView addSubview:btn];
    }];
}

- (UIView *)upgradeFailedBgView {
    if (!_upgradeFailedBgView) {
        _upgradeFailedBgView = [[UIView alloc] init];
        _upgradeFailedBgView.userInteractionEnabled = YES;
        _upgradeFailedBgView.frame = CGRectMake((kScreenWidth-ratioW(281))/2, (kScreenHeight-ratioH(145))/2, ratioW(281), ratioH(145));
        _upgradeFailedBgView.backgroundColor = KWhiteColor;
        ViewRadius(_upgradeFailedBgView, 15);
    }
    return _upgradeFailedBgView;
}

- (UILabel *)upgtitleLab {
    if (!_upgtitleLab) {
        _upgtitleLab = UILabel.new;
        _upgtitleLab.font = FONT_BOLD(16);
        _upgtitleLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        _upgtitleLab.textAlignment = NSTextAlignmentCenter;
        _upgtitleLab.frame = CGRectMake(0, ratioH(24), self.upgradeFailedBgView.width, ratioH(21));
        _upgtitleLab.text = @"Upgrade failed";
    }
    return _upgtitleLab;
}

- (UILabel *)upgconLab {
    if (!_upgconLab) {
        _upgconLab = UILabel.new;
        _upgconLab.font = FONT_REGULAR(13);
        _upgconLab.textColor = [UIColor colorWithHexString:@"0x161B19"];
        _upgconLab.frame = CGRectMake(0, ratioH(24), self.upgradeFailedBgView.width, ratioH(21));
        _upgconLab.text = @"升级失败的原因 may take a few minutes, and the device will not work during the upgrade process.\n* Please do not power off or reset during the update";
        _upgconLab.numberOfLines = 0;
        _upgconLab.frame = CGRectMake(ratioW(16), self.upgtitleLab.bottom+ratioH(10), self.upgradeFailedBgView.width-ratioW(16)*2, 0);
    }
    return _pconLab;
}

- (UIView *)upgwlineView {
    if (!_upgwlineView) {
        _upgwlineView = UIView.new;
        _upgwlineView.backgroundColor = kLineColor;
        _upgwlineView.frame = CGRectMake(0, self.upgradeFailedBgView.height-ratioH(60), self.upgradeFailedBgView.width, 1);
    }
    return _upgwlineView;
}

- (UIView *)upghlineView {
    if (!_upghlineView) {
        _upghlineView = UIView.new;
        _upghlineView.backgroundColor = kLineColor;
        _upghlineView.frame = CGRectMake(self.upgradeFailedBgView.width/2-.5, self.upgradeFailedBgView.height-ratioH(60), 1, ratioH(59));
    }
    return _upghlineView;
}
@end

