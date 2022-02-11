//
//  ABSetPasswordViewController.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/4.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABSetPasswordViewController.h"

@interface ABSetPasswordViewController ()
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIButton *backBtn;
@property (nonatomic ,strong) UIButton *sureBtn;
@property (nonatomic ,strong) UITextField *passTXT;
@property (nonatomic ,strong) UIButton *switchBtn;
@property (nonatomic ,strong) UILabel *tipsLab;
@property (nonatomic ,strong) UILabel *tipscontentLab;
@end

@implementation ABSetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KWhiteColor;
    self.isHidenNaviBar = YES;    
    [self setupUI];
}

- (void)setupUI {
    kWeakSelf(self);
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.sureBtn];
    [self.view addSubview:self.passTXT];
    [self.view addSubview:self.switchBtn];
    [self.view addSubview:self.tipsLab];
    [self.view addSubview:self.tipscontentLab];
    [self.switchBtn addTapBlock:^(UIButton *btn) {
        weakself.passTXT.secureTextEntry = btn.selected;
        btn.selected = !btn.selected;
    }];
}

// MARK: actions
- (void)backBtnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sureBtnAction:(UIButton *)sender {
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    NSData *data = [udf objectForKey:@"p_model"];
    NSString *email = [udf objectForKey:@"email"];
    ABNationModel *p_model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSDictionary *params = self.funcPattern == Register ? @{@"consentAgreement":@"1",//用户协议
                                                            @"country":p_model.value,
                                                            @"countryCode":p_model.param,
                                                            @"password":aesEncrypt(self.passTXT.text),
                                                            @"userName":email}
                                                            : @{@"userEmail":email,@"password":aesEncrypt(self.passTXT.text)};
    if (self.funcPattern == Register) {
        [ABLoginInterface login_registerSetPasswordWithParams:params success:^(id  _Nonnull responseObject) {
            KPostNotification(KNotificationLoginStateChange, @(kUserLoginStatusNotLoggedIn));
        }];
    } else {
        [ABLoginInterface login_registerForgetPasswordWithParams:params success:^(id  _Nonnull responseObject) {
            [[ABGlobalNotifyServer sharedServer] postForgetPassword:email];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    }
}

- (void)passTXTAction:(UITextField *)textField {
    self.sureBtn.backgroundColor = ValidStr(textField.text) ? [UIColor colorWithHexString:@"0x006241"] : [UIColor colorWithHexString:@"0xC9C9C9"];
}

// MARK: Lazy loading
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.font = FONT_MEDIUM(24);
        _titleLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        _titleLab.text = @"Set password";
        _titleLab.frame = CGRectMake(24, CONTACTS_HEIGHT_NAV+40, kScreenWidth-24*2, 30);
    }
    return _titleLab;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = UIButton.new;
        [_backBtn setImage:ImageName(@"icon_t_arrow") forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.frame = CGRectMake(19, YTVIEW_STATUSBAR_HEIGHT+12, 30, 30);
    }
    return _backBtn;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = UIButton.new;
        _sureBtn.backgroundColor = [UIColor colorWithHexString:@"0xC9C9C9"];
        [_sureBtn setTitle:@"Continue" forState:UIControlStateNormal];
        _sureBtn.frame = CGRectMake(27, kScreenHeight-60-CONTACTS_SAFE_BOTTOM-126, kScreenWidth-27*2, 60);
        [_sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.sureBtn addRoundedCorners:UIRectCornerAllCorners withRadii:CGSizeMake(30, 30)];
    }
    return _sureBtn;
}

- (UITextField *)passTXT {
    if (!_passTXT) {
        _passTXT = [[UITextField alloc] init];
        _passTXT.placeholder = @"Enter password";
        _passTXT.keyboardType = UIKeyboardTypeASCIICapable;
        _passTXT.secureTextEntry = YES;
        _passTXT.frame = CGRectMake(20, self.titleLab.bottom+24, kScreenWidth-20*2, 60);
        _passTXT.layer.masksToBounds = YES;
        _passTXT.layer.cornerRadius = 5;
        _passTXT.layer.borderColor = [UIColor colorWithHexString:@"0xE5E5E5"].CGColor;
        _passTXT.layer.borderWidth = 1;
        [_passTXT addTarget:self action:@selector(passTXTAction:) forControlEvents:UIControlEventEditingChanged];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 0)];
        _passTXT.leftView = view;
        _passTXT.leftViewMode = UITextFieldViewModeAlways;
        _passTXT.textColor = KBlackColor;
    }
    return _passTXT;
}

- (UIButton *)switchBtn {
    if (!_switchBtn) {
        _switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_switchBtn setImage:ImageName(@"login_pass_eye_close") forState:UIControlStateNormal];
        [_switchBtn setImage:ImageName(@"login_pass_eye_open") forState:UIControlStateSelected];
        _switchBtn.frame = CGRectMake(kScreenWidth-32-26, self.titleLab.bottom+38, 32, 32);
    }
    return _switchBtn;
}

- (UILabel *)tipsLab {
    if (!_tipsLab) {
        _tipsLab = UILabel.new;
        _tipsLab.font = FONT_MEDIUM(15);
        _tipsLab.frame = CGRectMake(20, self.passTXT.bottom+16, kScreenWidth-20*2, 22);
        _tipsLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        _tipsLab.text = @"Your Password must contain";
    }
    return _tipsLab;
}

- (UILabel *)tipscontentLab {
    if (!_tipscontentLab) {
        _tipscontentLab = UILabel.new;
        _tipscontentLab.font = FONT_REGULAR(15);
        _tipscontentLab.frame = CGRectMake(20, self.tipsLab.bottom+1, kScreenWidth-20*2, 0);
        _tipscontentLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        _tipscontentLab.numberOfLines = 0;
        _tipscontentLab.text = @"· 8 characters minimum\n· At least one letter\n· At least one number";
        CGRect contentLabRect = [_tipscontentLab.text boundingRectWithSize:CGSizeMake(_tipscontentLab.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_tipscontentLab.font} context:nil];
        _tipscontentLab.height = contentLabRect.size.height;
        [_tipscontentLab sizeToFit];
    }
    return _tipscontentLab;
}
@end
