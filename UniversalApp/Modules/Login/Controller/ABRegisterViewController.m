//
//  ABRegisterViewController.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/4.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABRegisterViewController.h"
#import "ABPrivacyViewController.h"
#import "ABVerifyEmailViewController.h"
#import "ABPopRegisterViewController.h"

@interface ABRegisterViewController ()<ABSureLoginDelegate,ABPopRegisterDelegte>

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIButton *selCountryBtn;
@property (nonatomic ,strong) UIButton *backBtn;
@property (nonatomic ,strong) UITextField *emailTXT;
@property (nonatomic ,strong) UIButton *sureBtn;
@property (nonatomic ,strong) ABNationModel *model;
@end

@implementation ABRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KWhiteColor;
    self.isHidenNaviBar = YES;
    self.model = ABNationModel.new;
    self.model.value = @"中国";
    self.model.param = @"CH";
    ABNationModel *p_model = ABNationModel.new;
    p_model.value = self.model.value;
    p_model.param = self.model.param;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.model];
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    [udf setObject:data forKey:@"p_model"];
    [udf synchronize];
    
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.selCountryBtn];
    [self.view addSubview:self.emailTXT];
    [self.view addSubview:self.sureBtn];
}

// MARK: actions
- (void)backBtnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)selCountryBtnAction:(UIButton *)sender {
    ABPopRegisterViewController *vc = ABPopRegisterViewController.new;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
    vc.delegate = self;
    vc.model = self.model;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)emailTXTAction:(UITextField *)textField {
    self.sureBtn.backgroundColor = ValidStr(textField.text) ? [UIColor colorWithHexString:@"0x006241"] : [UIColor colorWithHexString:@"0xC9C9C9"];
}

- (void)sureBtnAction:(UIButton *)sender {
    if (!ValidStr(self.emailTXT.text)) return;
    ABPrivacyViewController *vc = [[ABPrivacyViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

// MARK: ABSureLoginDelegate
- (void)sureLogin {
    NSDictionary *params = @{@"email":self.emailTXT.text,@"type":@"1"};
    [ABLoginInterface login_registerWithParams:params success:^(id  _Nonnull responseObject) {
        NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
        [udf setObject:self.emailTXT.text forKey:@"email"];
        [udf synchronize];
        
        ABVerifyEmailViewController *vc = ABVerifyEmailViewController.new;
        vc.emailStr = self.emailTXT.text;
        vc.funcPattern = Register;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

// MARK: ABPopRegisterDelegte
- (void)popRegister:(id)model {
    self.model = (ABNationModel *)model;
    CGFloat titleW = [self.model.value getWidthWithHeight:22 Font:FONT_MEDIUM(15)];
    [self.selCountryBtn setTitle:self.model.value forState:UIControlStateNormal];
    [self.selCountryBtn setTitleEdgeInsets:UIEdgeInsetsMake(16, -16, 16, (self.selCountryBtn.width-titleW-self.selCountryBtn.imageView.width))];
    [self.selCountryBtn setImageEdgeInsets:UIEdgeInsetsMake(16, self.selCountryBtn.width-28-16, 16, 16)];
    
    ABNationModel *p_model = ABNationModel.new;
    p_model.value = self.model.value;
    p_model.param = self.model.param;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    [udf setObject:data forKey:@"p_model"];
    [udf synchronize];
}

// MARK: Lazy loading
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.font = FONT_MEDIUM(24);
        _titleLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        _titleLab.text = @"Create New Account";
        _titleLab.frame = CGRectMake(24, CONTACTS_HEIGHT_NAV+80, kScreenWidth-24*2, 30);
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

- (UIButton *)selCountryBtn {
    if (!_selCountryBtn) {
        _selCountryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selCountryBtn.frame = CGRectMake(20, self.titleLab.bottom+24, kScreenWidth-20*2, 60);
        [_selCountryBtn setTitle:self.model.value forState:UIControlStateNormal];
        [_selCountryBtn setImage:ImageName(@"icon_28_arrow_x") forState:UIControlStateNormal];
        CGFloat titleW = [self.model.value getWidthWithHeight:22 Font:FONT_MEDIUM(15)];
        [_selCountryBtn setTitleEdgeInsets:UIEdgeInsetsMake(16, -16, 16, (_selCountryBtn.width-titleW-_selCountryBtn.imageView.width))];
        [_selCountryBtn setImageEdgeInsets:UIEdgeInsetsMake(16, _selCountryBtn.width-28-16, 16, 16)];
        [_selCountryBtn setTitleColor:[UIColor colorWithHexString:@"0x000000"] forState:UIControlStateNormal];
        _selCountryBtn.layer.masksToBounds = YES;
        _selCountryBtn.layer.cornerRadius = 5;
        _selCountryBtn.layer.borderColor = [UIColor colorWithHexString:@"0xE5E5E5"].CGColor;
        _selCountryBtn.layer.borderWidth = 1;
        [_selCountryBtn addTarget:self action:@selector(selCountryBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selCountryBtn;
}

- (UITextField *)emailTXT {
    if (!_emailTXT) {
        _emailTXT = UITextField.new;
        _emailTXT.frame = CGRectMake(20, self.selCountryBtn.bottom+32, kScreenWidth-20*2, 60);
        _emailTXT.placeholder = @"Enter Email address to register!";
        _emailTXT.layer.masksToBounds = YES;
        _emailTXT.layer.cornerRadius = 5;
        _emailTXT.layer.borderColor = [UIColor colorWithHexString:@"0xE5E5E5"].CGColor;
        _emailTXT.layer.borderWidth = 1;
        _emailTXT.clearsOnBeginEditing = NO;
        _emailTXT.keyboardType = UIKeyboardTypeEmailAddress;
        _emailTXT.clearButtonMode = UITextFieldViewModeWhileEditing;
        _emailTXT.textColor = [UIColor colorWithHexString:@"0x000000"];
        [_emailTXT addTarget:self action:@selector(emailTXTAction:) forControlEvents:UIControlEventEditingChanged];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 0)];
        _emailTXT.leftView = view;
        _emailTXT.leftViewMode = UITextFieldViewModeAlways;
        _emailTXT.textColor = KBlackColor;
    }
    return _emailTXT;
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
@end
