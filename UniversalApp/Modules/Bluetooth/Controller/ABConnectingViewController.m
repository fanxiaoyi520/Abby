//
//  ABConnectingViewController.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/19.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABConnectingViewController.h"
#import "STLoopProgressView.h"

#define First_Boundary_Time 140
#define Sec_Boundary_Time 140

@interface ABConnectingViewController ()<TuyaSmartBLEWifiActivatorDelegate>
@property (nonatomic ,strong)CLLocationManager *locationManager;
@property (nonatomic ,strong)TuyaSmartHomeManager *homeManager;
@property (nonatomic ,strong)TuyaSmartHomeModel *smartHomeModel;
@property (nonatomic ,strong)TuyaSmartHome *home;
@property (nonatomic, assign) NSTimeInterval currentTime;;

@property (nonatomic ,strong) UIView *bgSpeedView;
@property (nonatomic ,strong) UIButton *closeBtn;
@property (nonatomic ,strong) STLoopProgressView *progressView;
@property (nonatomic ,strong) UILabel *conLab;
@property (nonatomic ,strong) FLAnimatedImageView *gifImgView;

@property (nonatomic ,strong) UIView *bgResultView;
@property (nonatomic ,strong) UIImageView *tipsImgView;
@property (nonatomic ,strong) UILabel *errorTipsLab;
@property (nonatomic ,strong) UIView *lineView;
@property (nonatomic ,strong) UIButton *sureBtn;
@end

@implementation ABConnectingViewController
{
    ZYGCDTimer *_timer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 定时器业务
    kWeakSelf(self);
    _timer = [ZYGCDTimer timerWithTimeInterval:1.0 userInfo:nil repeats:YES dispatchQueue:dispatch_get_main_queue() block:^(ZYGCDTimer * _Nonnull timer) {
        NSAssert(NSThread.isMainThread, @"不是主线程");
        weakself.currentTime += timer.interval;
        if (weakself.currentTime >= First_Boundary_Time) {
            [_timer pause];
            [self updateUIwithInfo:@"Device failed to connect to the network"];
        } else {
            self.progressView.persentage += self.progressView.persentage + timer.interval/First_Boundary_Time;
        }
    }];
    _timer.tolerance = 0.5;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _timer.tolerance = 0.8;
    });
    [_timer fire];
    
    
    // 涂鸦云业务
    [TuyaSmartBLEWifiActivator sharedInstance].bleWifiDelegate = self;
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    CGFloat version = [phoneVersion floatValue];
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined && version >= 13) {
         self.locationManager = [[CLLocationManager alloc] init];
         [self.locationManager requestWhenInUseAuthorization];
    }
    
    weakself.homeManager = [TuyaSmartHomeManager new];
    [weakself.homeManager getHomeListWithSuccess:^(NSArray<TuyaSmartHomeModel *> *homes) {
        if (homes.count > 0) weakself.smartHomeModel = homes[0];
        //ValidStr(self.PWD)? self.PWD : @"baypacclub"
        [[TuyaSmartBLEWifiActivator sharedInstance] startConfigBLEWifiDeviceWithUUID:weakself.peripheral.uuid homeId:weakself.smartHomeModel.homeId productId:weakself.peripheral.productId ssid:[NSString getDeviceConnectWifiName] password:@"baypacclub"  timeout:100 success:^{
        } failure:^{
            [self updateUIwithInfo:@"Device failed to connect to the network"];
        }];
    } failure:^(NSError *error) {
        [self updateUIwithInfo:error.description];
    }];
    
    
    // UI
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.bgSpeedView];
    [self.bgSpeedView addSubview:self.closeBtn];
    [self.bgSpeedView addSubview:self.progressView];
    [self.bgSpeedView addSubview:self.gifImgView];
    [self.bgSpeedView addSubview:self.conLab];
    CGRect conLabRect = [self.conLab.text boundingRectWithSize:CGSizeMake(self.conLab.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.conLab.font} context:nil];
    self.conLab.height = conLabRect.size.height;

}

- (void)updateUIwithInfo:(NSString *)info {
    [_timer pause];
    [self.view removeAllSubviews];
    [self.view addSubview:self.bgResultView];
    [self.bgResultView addSubview:self.tipsImgView];
    
    [self.bgResultView addSubview:self.errorTipsLab];
    self.errorTipsLab.text = info;
    CGRect errorTipsLabRect = [self.errorTipsLab.text boundingRectWithSize:CGSizeMake(self.errorTipsLab.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.errorTipsLab.font} context:nil];
    self.errorTipsLab.height = errorTipsLabRect.size.height;
    
    [self.bgResultView addSubview:self.lineView];
    [self.bgResultView addSubview:self.sureBtn];
}

// MARK: Lazy loading
- (void)closeBtnAction:(UIButton *)sender {
    [[TuyaSmartBLEWifiActivator sharedInstance] stopDiscover];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sureBtnAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// MARK: TuyaSmartBLEWifiActivatorDelegate
- (void)bleWifiActivator:(TuyaSmartBLEWifiActivator *)activator didReceiveBLEWifiConfigDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error {
    if (!error && deviceModel) {
        // 配网成功
        dispatch_async(dispatch_get_main_queue(), ^{
            self.home = [TuyaSmartHome homeWithHomeId:self.smartHomeModel.homeId];
            [self.home getHomeDetailWithSuccess:^(TuyaSmartHomeModel *homeModel) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.progressView.persentage = 1;
                });
                
                TuyaSmartDeviceModel *deviceModel = self.home.deviceList[0];
                [[DeviceManager sharedDeviceManager] saveDeviceInfo:deviceModel];
                KPostNotification(KNotificationLoginStateChange, @(kUserLoginStatusLoggedIn));
            } failure:^(NSError *error) {
                [self updateUIwithInfo:error.description];
            }];
        });
    }

    if (error) {
        // 配网失败
        [self updateUIwithInfo:error.description];
    }
}

// MARK: Lazy loading
// MARK: ----------------bgSpeedView----------------
- (UIView *)bgSpeedView {
    if (!_bgSpeedView) {
        _bgSpeedView = UIView.new;
        _bgSpeedView.backgroundColor = KWhiteColor;
        _bgSpeedView.frame = CGRectMake((kScreenWidth-ratioW(281))/2, (kScreenHeight-ratioH(291))/2, ratioW(281), ratioH(291));
        ViewRadius(_bgSpeedView, 15);
    }
    return _bgSpeedView;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = UIButton.new;
        _closeBtn.frame = CGRectMake(self.bgSpeedView.width-ratioH(20)-ratioW(16), ratioH(16), ratioH(20), ratioH(20));
        [_closeBtn setImage:ImageName(@"icon_t_closure") forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (STLoopProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[STLoopProgressView alloc] initWithFrame:CGRectMake((self.bgSpeedView.width-ratioH(151))/2, ratioH(41), ratioH(151), ratioH(151))];
        _progressView.persentage = 0;
    }
    return _progressView;
}

- (UILabel *)conLab {
    if (!_conLab) {
        _conLab = UILabel.new;
        _conLab.font = FONT_REGULAR(13);
        _conLab.textColor = [UIColor colorWithHexString:@"0x161B19"];
        _conLab.textAlignment = NSTextAlignmentCenter;
        _conLab.frame = CGRectMake(ratioW(16), self.progressView.bottom+ratioH(32), self.bgSpeedView.width-ratioW(16)*2, 0);
        _conLab.text = @"Keep routers, phones and devices as close as possible";
        _conLab.numberOfLines = 0;
        [_conLab sizeToFit];
    }
    return _conLab;
}

- (FLAnimatedImageView *)gifImgView {
    if (!_gifImgView) {
        _gifImgView = FLAnimatedImageView.new;
        _gifImgView.frame = CGRectMake((self.bgSpeedView.width-58)/2, self.progressView.top+ratioH(50), 58, 58);
        _gifImgView.contentMode = UIViewContentModeScaleAspectFill;
        _gifImgView.backgroundColor = KWhiteColor;
        _gifImgView.clipsToBounds = YES;
        NSString *pathForFile = [[NSBundle mainBundle] pathForResource:@"middle_img_v2_776" ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile: pathForFile];
        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:data];
        _gifImgView.animatedImage = image;
    }
    return _gifImgView;
}

// MARK: ----------------bgResultView----------------
- (UIView *)bgResultView {
    if (!_bgResultView) {
        _bgResultView = UIView.new;
        _bgResultView.backgroundColor = KWhiteColor;
        _bgResultView.frame = CGRectMake((kScreenWidth-ratioW(281))/2, (kScreenHeight-ratioH(350))/2, ratioW(281), ratioH(350));
        ViewRadius(_bgResultView, 15);
    }
    return _bgResultView;
}

- (UIImageView *)tipsImgView {
    if (!_tipsImgView) {
        _tipsImgView = UIImageView.new;
        _tipsImgView.frame = CGRectMake((self.bgResultView.width-ratioH(131))/2, ratioH(53), ratioW(131), ratioH(132));
        _tipsImgView.image = ImageName(@"pic_fail");
    }
    return _tipsImgView;
}

- (UILabel *)errorTipsLab {
    if (!_errorTipsLab) {
        _errorTipsLab = UILabel.new;
        _errorTipsLab.font = FONT_REGULAR(13);
        _errorTipsLab.textColor = [UIColor colorWithHexString:@"0xD61744"];
        _errorTipsLab.frame = CGRectMake(ratioW(16), self.tipsImgView.bottom+ratioH(39), self.bgResultView.width-ratioW(16)*2, 0);
        _errorTipsLab.text = @"Device failed to connect to the network";
        _errorTipsLab.numberOfLines = 0;
        _errorTipsLab.textAlignment = NSTextAlignmentCenter;
    }
    return _errorTipsLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = UIView.new;
        _lineView.backgroundColor = kLineColor;
        _lineView.frame = CGRectMake(0, self.bgResultView.height-ratioH(59), self.bgResultView.width, 1);
    }
    return _lineView;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = UIButton.new;
        [_sureBtn setTitle:@"OK" forState:UIControlStateNormal];
        _sureBtn.frame = CGRectMake(0, self.bgResultView.height-ratioH(59), self.bgResultView.width, ratioH(59));
        [_sureBtn setTitleColor:[UIColor colorWithHexString:@"0x006241"] forState:UIControlStateNormal];;
        _sureBtn.titleLabel.font = FONT_REGULAR(18);
        [_sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
@end
