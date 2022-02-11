//
//  ABAddBTSSuccessViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/11/26.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABAddBTSSuccessViewController.h"
#import "ABWifiListViewController.h"
#import "ABConnectingViewController.h"

@interface ABAddBTSSuccessViewController ()<UITextFieldDelegate>

@property (nonatomic ,strong)UILabel *titleLab;
@property (nonatomic ,strong)UILabel *contentLab;
@property (nonatomic ,strong)UIView *deviceBgView;
@property (nonatomic ,strong)UILabel *deviceNameLab;
@property (nonatomic ,strong)UILabel *wifiNameLab;
@property (nonatomic ,strong)UIButton *wifiSelectBtn;
@property (nonatomic ,strong)UIView *lineViewW;
@property (nonatomic ,strong)UITextField *passTXT;
@property (nonatomic ,strong)UIButton *eyeBtn;
@property (nonatomic ,strong)UIView *lineViewP;
@property (nonatomic ,strong)UILabel *errTipsLab;
@property (nonatomic ,strong)YYLabel *sureBtn;

@end

@implementation ABAddBTSSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"0xFBFFFD"];
    self.isHidenNaviBar = NO;
    self.isShowLiftBack = NO;
    [self addNavigationItemWithTitles
     :@[@"Cancel"] isLeft:YES target:self action:@selector(naviBtnClick:) tags:@[@1000]];
    self.navTitle = @"3/3";
    
    [self setupUI];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];//移除通知
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(imcomingBack)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)setupUI {
    kWeakSelf(self)
    [self.view addSubview:self.titleLab];
    self.titleLab.frame = CGRectMake(26, 39, [self.titleLab.text getWidthWithHeight:29 Font:self.titleLab.font], 29);
    
    [self.view addSubview:self.contentLab];
    self.contentLab.frame = CGRectMake(26, self.titleLab.bottom+8, kScreenWidth-26*2, 36);
    
    [self.view addSubview:self.deviceBgView];
    self.deviceBgView.frame = CGRectMake(20, self.contentLab.bottom+30, kScreenWidth-20*2, 50);
    [UIView jaf_cutOptionalFillet:self.deviceBgView byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
    
    [self.deviceBgView addSubview:self.deviceNameLab];
    self.deviceNameLab.frame = CGRectMake(11, 13, self.deviceBgView.width-11*2, 24);
    self.deviceNameLab.text = [NSString stringWithFormat:@"Device: %@", self.peripheral.uuid];
    
    [self.view addSubview:self.wifiNameLab];
    self.wifiNameLab.frame = CGRectMake(26, self.deviceBgView.bottom+28, kScreenWidth-26-101, 24);
    if (ValidStr([NSString getDeviceConnectWifiName])) {
        self.wifiNameLab.text = [NSString getDeviceConnectWifiName];
    } else {
        self.wifiNameLab.text = @"Please select WiFi";
    }

        
    [self.view addSubview:self.lineViewW];
    self.lineViewW.frame = CGRectMake(20, self.deviceBgView.bottom+64, kScreenWidth-20*2, 1);
    
    [self.view addSubview:self.passTXT];
    self.passTXT.frame = CGRectMake(26, self.lineViewW.bottom+30, kScreenWidth-26*2-32, 50);
    
    [self.view addSubview:self.lineViewP];
    self.lineViewP.frame = CGRectMake(20, self.lineViewW.bottom+79, kScreenWidth-20*2, 1);

    [self.view addSubview:self.errTipsLab];
    self.errTipsLab.frame = CGRectMake(41, self.lineViewP.bottom+16, kScreenWidth, 24);
    
    [self.view addSubview:self.eyeBtn];
    self.eyeBtn.frame = CGRectMake(kScreenWidth-32-30, self.lineViewW.bottom+39, 32, 32);
    [self.eyeBtn addTapBlock:^(UIButton *btn) {
        weakself.passTXT.secureTextEntry = btn.selected;
        btn.selected = !btn.selected;
    }];
    
    [self.view addSubview:self.wifiSelectBtn];
    self.wifiSelectBtn.frame = CGRectMake(kScreenWidth-32-30, self.deviceBgView.bottom+24, 32, 32);
    [self.wifiSelectBtn addTapBlock:^(UIButton *btn) {
//        ABWifiListViewController *vc =[ABWifiListViewController new];
//        vc.modalPresentationStyle = UIModalPresentationCustom;
//        vc.transitioningDelegate = weakself;
//        vc.block = ^(id  _Nonnull info) {
//            weakself.wifiNameLab.text = (NSString *)info;
//        };
//        [weakself presentViewController:vc animated:YES completion:nil];
        [weakself gotoSettings];
    }];
    
    [self.view addSubview:self.sureBtn];
    self.sureBtn.frame = CGRectMake(26, kScreenHeight-CONTACTS_HEIGHT_NAV-144-CONTACTS_SAFE_BOTTOM, kScreenWidth-26*2, 60);
    ViewRadius(self.sureBtn, 30);
    self.sureBtn.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if ([weakself validInput]) {
            weakself.errTipsLab.hidden = YES;
            ABConnectingViewController *vc = ABConnectingViewController.new;
            vc.modalPresentationStyle = UIModalPresentationCustom;
            vc.transitioningDelegate = weakself;
            vc.peripheral = weakself.peripheral;
            vc.PWD = weakself.passTXT.text;
            [weakself presentViewController:vc animated:YES completion:nil];
        }
    };
}

// MARK: actions
- (BOOL)validInput {
    if (!ValidStr(self.passTXT.text)) {
        [UIViewController jaf_showHudTip:@"Password cannot be empty"];
        return NO;
    }

    return YES;
}

- (void)naviBtnClick:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)gotoSettings {
    NSString *urlString = @"App-Prefs:root=WIFI";
    NSURL *url = [NSURL URLWithString:urlString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

-  (void)imcomingBack{
    if (ValidStr([NSString getDeviceConnectWifiName])) {
        self.wifiNameLab.text = [NSString getDeviceConnectWifiName];
    } else {
        self.wifiNameLab.text = @"Please select WiFi";
    }
}

// MARK: UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.passTXT]) self.errTipsLab.hidden = YES;
}

// MARK: Lazy loading
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        _titleLab.text = @"Select Wi-Fi network";
        _titleLab.font = FONT_MEDIUM(24);
    }
    return _titleLab;
}

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [UILabel new];
        _contentLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        _contentLab.text = @"The device only supports 2.4GHz Wi-Fi\nWi-Fi only supports alphanumeric character";
        _contentLab.font = FONT_REGULAR(15);
        _contentLab.numberOfLines = 2;
    }
    return _contentLab;
}

- (UIView *)deviceBgView {
    if (!_deviceBgView) {
        _deviceBgView = [UIView new];
        _deviceBgView.backgroundColor = [UIColor colorWithHexString:@"0xF9F9F9"];
    }
    return _deviceBgView;
}

- (UILabel *)deviceNameLab {
    if (!_deviceNameLab) {
        _deviceNameLab = [UILabel new];
        _deviceNameLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        _deviceNameLab.font = FONT_BOLD(16);
    }
    return _deviceNameLab;
}

- (UILabel *)wifiNameLab {
    if (!_wifiNameLab) {
        _wifiNameLab = [UILabel new];
        _wifiNameLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        _wifiNameLab.font = FONT_MEDIUM(15);
    }
    return _wifiNameLab;
}

- (UITextField *)passTXT {
    if (!_passTXT) {
        _passTXT = [[UITextField alloc] init];
        _passTXT.placeholder = @"Network Password";
        _passTXT.keyboardType = UIKeyboardTypeASCIICapable;
        _passTXT.secureTextEntry = YES;
        _passTXT.clearsOnBeginEditing = NO;
        _passTXT.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passTXT.delegate = self;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 6, 0)];
        _passTXT.leftView = view;
        _passTXT.leftViewMode = UITextFieldViewModeAlways;
        _passTXT.textColor = KBlackColor;
    }
    return _passTXT;
}

- (UIView *)lineViewW {
    if (!_lineViewW) {
        _lineViewW = [[UIView alloc] init];
        _lineViewW.backgroundColor = [UIColor colorWithHexString:@"0x006241"];
    }
    return _lineViewW;
}

- (UIView *)lineViewP {
    if (!_lineViewP) {
        _lineViewP = [[UIView alloc] init];
        _lineViewP.backgroundColor = [UIColor colorWithHexString:@"0x006241"];
    }
    return _lineViewP;
}

- (UILabel *)errTipsLab {
    if (!_errTipsLab) {
        _errTipsLab = [[UILabel alloc] init];
        _errTipsLab.textColor = [UIColor colorWithHexString:@"0xF72E47"];
        _errTipsLab.text = @"Wrong password!";
        _errTipsLab.font = FONT_MEDIUM(15);
        _errTipsLab.hidden = YES;
    }
    return _errTipsLab;
}

- (YYLabel *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [[YYLabel alloc] init];
        _sureBtn.text = @"Confirm";
        _sureBtn.font = FONT_MEDIUM(18);
        _sureBtn.textColor = [UIColor colorWithHexString:@"0xFFFFFF"];
        _sureBtn.textAlignment = NSTextAlignmentCenter;
        _sureBtn.backgroundColor = [UIColor colorWithHexString:@"0x006241"];
        _sureBtn.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    }
    return _sureBtn;
}

- (UIButton *)wifiSelectBtn {
    if (!_wifiSelectBtn) {
        _wifiSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wifiSelectBtn setImage:ImageName(@"login_pass_eye_close") forState:UIControlStateNormal];
        [_wifiSelectBtn setImage:ImageName(@"login_pass_eye_open") forState:UIControlStateSelected];
    }
    return _wifiSelectBtn;
}

- (UIButton *)eyeBtn {
    if (!_eyeBtn) {
        _eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eyeBtn setImage:ImageName(@"login_pass_eye_close") forState:UIControlStateNormal];
        [_eyeBtn setImage:ImageName(@"login_pass_eye_open") forState:UIControlStateSelected];
    }
    return _eyeBtn;
}

@end
