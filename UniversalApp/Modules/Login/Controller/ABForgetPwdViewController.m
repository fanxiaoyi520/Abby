//
//  ABForgetPwdViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/11/25.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABForgetPwdViewController.h"
#import "ABVerifyEmailViewController.h"

@interface ABForgetPwdViewController ()

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIButton *backBtn;
@property (nonatomic ,strong) UITextField *emailTXT;
@property (nonatomic ,strong) UIButton *sureBtn;
@end

@implementation ABForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isHidenNaviBar = YES;
    self.view.backgroundColor = KWhiteColor;
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.emailTXT];
    [self.view addSubview:self.sureBtn];
    
    self.emailTXT.text = ValidStr(self.userName) ? self.userName : nil;
    self.sureBtn.backgroundColor = ValidStr(self.userName) ? [UIColor colorWithHexString:@"0x006241"] : [UIColor colorWithHexString:@"0xC9C9C9"];
}

// MARK: actions
- (void)backBtnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)emailTXTAction:(UITextField *)textField {
    self.sureBtn.backgroundColor = ValidStr(textField.text) ? [UIColor colorWithHexString:@"0x006241"] : [UIColor colorWithHexString:@"0xC9C9C9"];
    
}

- (void)sureBtnAction:(UIButton *)sender {
    if (!ValidStr(self.emailTXT.text)) return;
    NSDictionary *params = @{@"email":self.emailTXT.text,@"type":@"2"};
    [ABLoginInterface login_registerWithParams:params success:^(id  _Nonnull responseObject) {
        NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
        [udf setObject:self.emailTXT.text forKey:@"email"];
        [udf synchronize];
        
        ABVerifyEmailViewController *vc = ABVerifyEmailViewController.new;
        vc.emailStr = self.emailTXT.text;
        vc.funcPattern = ForgetPassword;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

// MARK: Lazy loading
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.font = FONT_MEDIUM(24);
        _titleLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        _titleLab.text = @"Forgot password";
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

- (UITextField *)emailTXT {
    if (!_emailTXT) {
        _emailTXT = UITextField.new;
        _emailTXT.frame = CGRectMake(20, self.titleLab.bottom+24, kScreenWidth-20*2, 60);
        _emailTXT.placeholder = @"Enter account";
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
        [_sureBtn setTitle:@"Reset Password" forState:UIControlStateNormal];
        _sureBtn.frame = CGRectMake(27, kScreenHeight-60-CONTACTS_SAFE_BOTTOM-126, kScreenWidth-27*2, 60);
        [_sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.sureBtn addRoundedCorners:UIRectCornerAllCorners withRadii:CGSizeMake(30, 30)];
    }
    return _sureBtn;
}
@end
