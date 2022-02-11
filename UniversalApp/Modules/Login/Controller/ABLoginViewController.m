//
//  ABLoginViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/11/24.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABLoginViewController.h"
#import "ABPrivacyViewController.h"
#import "ABForgetPwdViewController.h"
#import "ABAddDeviceViewController.h"
#import "ABRegisterViewController.h"
#import "XLWebViewController.h"
@interface ABLoginViewController ()<UITextFieldDelegate,ABSureLoginDelegate,GWGlobalNotifyServerDelegate>

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *tipsLab;
@property (nonatomic ,strong) UITextField *accountTXT;
@property (nonatomic ,strong) UITextField *passTXT;
@property (nonatomic ,strong) UIView *lineViewA;
@property (nonatomic ,strong) UIView *lineViewP;
@property (nonatomic ,strong) UILabel *errTipsLab;
@property (nonatomic ,strong) YYLabel *forgetBtn;
@property (nonatomic ,strong) YYLabel *loginBtn;
@property (nonatomic ,strong) UIButton *switchBtn;
@property (nonatomic ,strong) TuyaSmartHomeManager *homeManager;
@property (nonatomic ,strong) TuyaSmartHome *home;
@property (nonatomic ,strong) TuyaSmartHomeModel *smartHomeModel;
@property (nonatomic ,strong) UIButton *registerBtn;
@end

@implementation ABLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //DLog(@"%@",[TuyaSmartUser sharedInstance].email);
    // Do any additional setup after loading the view.
    self.isShowLiftBack = NO;//每个根视图需要设置该属性为NO，否则会出现导航栏异常
    self.isHidenNaviBar = YES;
    [[ABGlobalNotifyServer sharedServer] jaf_addDelegate:self];

    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.titleLab];
    self.titleLab.frame = CGRectMake(26, 150, kScreenWidth, 37);
    
    [self.view addSubview:self.tipsLab];
    self.tipsLab.frame = CGRectMake(self.titleLab.left, self.titleLab.bottom+7, kScreenWidth, 24);
    
    [self.view addSubview:self.accountTXT];
    self.accountTXT.frame = CGRectMake(25, self.tipsLab.bottom+30, kScreenWidth-25*2, 50);

    [self.view addSubview:self.lineViewA];
    self.lineViewA.frame = CGRectMake(25, self.accountTXT.bottom, kScreenWidth-25*2, 1);
    
    [self.view addSubview:self.passTXT];
    self.passTXT.frame = CGRectMake(25, self.lineViewA.bottom+20, kScreenWidth-25*2-32, 50);

    [self.view addSubview:self.lineViewP];
    self.lineViewP.frame = CGRectMake(25, self.passTXT.bottom, kScreenWidth-25*2, 1);
    
    [self.view addSubview:self.errTipsLab];
    self.errTipsLab.frame = CGRectMake(41, self.lineViewP.bottom+15, kScreenWidth, 24);
    
    [self.view addSubview:self.forgetBtn];
    self.forgetBtn.frame = CGRectMake(kScreenWidth-[self.forgetBtn.text getWidthWithHeight:18 Font:FONT_MEDIUM(12)]-26, self.lineViewP.bottom+19, [self.forgetBtn.text getWidthWithHeight:18 Font:FONT_MEDIUM(12)], 18);
    kWeakSelf(self);
    self.forgetBtn.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        ABForgetPwdViewController *vc = [[ABForgetPwdViewController alloc] init];
        vc.userName = weakself.accountTXT.text;
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    
    [self.view addSubview:self.loginBtn];
    self.loginBtn.frame = CGRectMake(26, kScreenHeight-CONTACTS_SAFE_BOTTOM-60-126, kScreenWidth-26*2, 60);
    ViewRadius(self.loginBtn, 30);
    self.loginBtn.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        ABPrivacyViewController *vc = [[ABPrivacyViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationCustom;
        vc.transitioningDelegate = weakself;
        vc.delegate = weakself;
        [weakself presentViewController:vc animated:YES completion:nil];
    };
    
    [self.view addSubview:self.switchBtn];
    self.switchBtn.frame = CGRectMake(kScreenWidth-32-26, self.lineViewA.bottom+29, 32, 32);
    [self.switchBtn addTapBlock:^(UIButton *btn) {
        weakself.passTXT.secureTextEntry = btn.selected;
        btn.selected = !btn.selected;
    }];
    
    [self.view addSubview:self.registerBtn];
    self.registerBtn.frame = CGRectMake(0, self.loginBtn.bottom+24, kScreenWidth, 22);
    
//    self.accountTXT.text= @"519001191@qq.com";
//    self.passTXT.text = @"123456";
    
    self.accountTXT.text= @"851578861@qq.com";
    self.passTXT.text = @"hzm123456";
}

// MARK: actions
- (BOOL)validInput {
    if (!ValidStr(self.accountTXT.text)) {
        [UIViewController jaf_showHudTip:@"Account cannot be empty"];
        return NO;
    }
    
    if (!ValidStr(self.passTXT.text)) {
        [UIViewController jaf_showHudTip:@"Password cannot be empty"];
        return NO;
    }
//
//    if (![self.passTXT.text isEqualToString:@"fanxiaoyi520"]) {
//        self.errTipsLab.hidden = NO;
//        return NO;
//    }
    return YES;
}

- (void)registerBtnAction:(UIButton *)sender {
    ABRegisterViewController *vc = ABRegisterViewController.new;
    [self.navigationController pushViewController:vc animated:YES];
}

// MARK: UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.passTXT]) self.errTipsLab.hidden = YES;
}

// MARK: ABSureLoginDelegate
- (void)sureLogin {
    if (![self validInput]) {
        self.errTipsLab.hidden = YES;
        return;
    }
    KPostNotification(KNotificationLoginStateChange, @(kUserLoginStatusLoggedIn));
    return;
    [[UserManager sharedUserManager] login:kUserLoginTypePwd params:@{@"userName":self.accountTXT.text,@"password":aesEncrypt(self.passTXT.text)} completion:^(BOOL success, NSString *des) {
            if (success) {
                [self associatedGraffitiLoginBusiness];
            } else {
                [UIViewController jaf_showHudTip:des];
            }
        }
    ];
}

- (void)associatedGraffitiLoginBusiness {
    self.homeManager = [TuyaSmartHomeManager new];
    [self.homeManager getHomeListWithSuccess:^(NSArray<TuyaSmartHomeModel *> *homes) {
        self.smartHomeModel = homes.count > 0 ? homes[0] : nil;
        NSAssert(self.smartHomeModel != nil, @"unknown error");
        self.home = [TuyaSmartHome homeWithHomeId:self.smartHomeModel.homeId];
        [self.home getHomeDetailWithSuccess:^(TuyaSmartHomeModel *homeModel) {
            if (self.home.deviceList.count>0) {
                TuyaSmartDeviceModel *deviceModel = self.home.deviceList[0];
                [[DeviceManager sharedDeviceManager] saveDeviceInfo:deviceModel];
                KPostNotification(KNotificationLoginStateChange, @(kUserLoginStatusLoggedIn));
            } else {
                ABAddDeviceViewController *vc = [ABAddDeviceViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
        } failure:^(NSError *error) {
            [UIViewController jaf_showHudTip:error.description];
        }];
    } failure:^(NSError *error) {
        [UIViewController jaf_showHudTip:error.description];
    }];
}

- (void)openUrlWithTypeStr:(NSString *)typeStr {
    if ([typeStr isEqualToString:@"Privacy policy"]) {
        XLWebViewController *vc = [[XLWebViewController alloc] initWithUrl:web_url_privacyPolicy withNavTitle:@"《Terms of Use and Privacy》"];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        XLWebViewController *vc = [[XLWebViewController alloc] initWithUrl:web_url_personal withNavTitle:@"《Privacy Policy》"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

// MARK: GWGlobalNotifyServerDelegate
- (void)resetForgetPassword:(NSString *)emailStr{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.accountTXT.text = emailStr;
    });
}

// MARK: Lazy loading
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"Log in";
        _titleLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        _titleLab.font = FONT_BOLD(30);
    }
    return _titleLab;
}

- (UILabel *)tipsLab {
    if (!_tipsLab) {
        _tipsLab = [[UILabel alloc] init];
        _tipsLab.text = @"Enter the account from the Baypac.com";
        _tipsLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        _tipsLab.font = FONT_MEDIUM(15);
    }
    return _tipsLab;
}

- (UITextField *)accountTXT {
    if (!_accountTXT) {
        _accountTXT = [[UITextField alloc] init];
        _accountTXT.placeholder = @"Account";
        _accountTXT.keyboardType = UIKeyboardTypeASCIICapable;
        _accountTXT.autocapitalizationType = UITextAutocapitalizationTypeNone;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 0)];
        _accountTXT.leftView = view;
        _accountTXT.leftViewMode = UITextFieldViewModeAlways;
        _accountTXT.textColor = KBlackColor;
    }
    return _accountTXT;
}

- (UITextField *)passTXT {
    if (!_passTXT) {
        _passTXT = [[UITextField alloc] init];
        _passTXT.placeholder = @"Password";
        _passTXT.keyboardType = UIKeyboardTypeASCIICapable;
        _passTXT.secureTextEntry = YES;
        _passTXT.clearsOnBeginEditing = NO;
        _passTXT.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passTXT.delegate = self;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 0)];
        _passTXT.leftView = view;
        _passTXT.leftViewMode = UITextFieldViewModeAlways;
        _passTXT.textColor = KBlackColor;
    }
    return _passTXT;
}

- (UIView *)lineViewA {
    if (!_lineViewA) {
        _lineViewA = [[UIView alloc] init];
        _lineViewA.backgroundColor = [UIColor colorWithHexString:@"0x006241"];
    }
    return _lineViewA;
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
        _errTipsLab.text = @"wrong password!";
        _errTipsLab.font = FONT_MEDIUM(15);
        _errTipsLab.hidden = YES;
    }
    return _errTipsLab;
}

- (YYLabel *)forgetBtn {
    if (!_forgetBtn) {
        _forgetBtn = [[YYLabel alloc] init];
        _forgetBtn.text = @"Forgot password ？";
        _forgetBtn.font = FONT_MEDIUM(12);
        _forgetBtn.textColor = [UIColor colorWithHexString:@"0x006241"];
        _forgetBtn.textAlignment = NSTextAlignmentCenter;
        _forgetBtn.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    }
    return _forgetBtn;
}

- (YYLabel *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [[YYLabel alloc] init];
        _loginBtn.text = @"Log in";
        _loginBtn.font = FONT_MEDIUM(18);
        _loginBtn.textColor = [UIColor colorWithHexString:@"0xFFFFFF"];
        _loginBtn.textAlignment = NSTextAlignmentCenter;
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"0x006241"];
        _loginBtn.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    }
    return _loginBtn;
}

- (UIButton *)switchBtn {
    if (!_switchBtn) {
        _switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_switchBtn setImage:ImageName(@"login_pass_eye_close") forState:UIControlStateNormal];
        [_switchBtn setImage:ImageName(@"login_pass_eye_open") forState:UIControlStateSelected];
    }
    return _switchBtn;
}

- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = UIButton.new;
        [_registerBtn setTitle:@"Create New Account" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:[UIColor colorWithHexString:@"0x006241"] forState:UIControlStateNormal];
        [_registerBtn addTarget:self action:@selector(registerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _registerBtn.titleLabel.font = FONT_MEDIUM(15);
        
        UIView *lineView = UIView.new;
        [_registerBtn addSubview:lineView];
        lineView.backgroundColor = [UIColor colorWithHexString:@"0x006241"];
        CGFloat w = [@"Create New Account" getWidthWithHeight:22 Font:_registerBtn.titleLabel.font];
        lineView.frame = CGRectMake((kScreenWidth-w)/2, 21, w, 1);
    }
    return _registerBtn;
}
@end
