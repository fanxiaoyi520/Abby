//
//  ABVerifyEmailViewController.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/4.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABVerifyEmailViewController.h"
#import "ABSetPasswordViewController.h"
#import "ABPopResendEmailViewController.h"

#import "CRBoxInputView.h"

@interface ABVerifyEmailViewController ()<ABPopResendEmailDelegate>
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *contentLab;
@property (nonatomic ,strong) UIButton *backBtn;
@property (nonatomic ,strong) UIButton *sureBtn;
@property (nonatomic ,strong) UIButton *resetEmailBtn;
@property (nonatomic ,strong) CRBoxInputView *boxInputView;
@property (nonatomic ,copy) NSString *inputStr;
@end

@implementation ABVerifyEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KWhiteColor;
    self.isHidenNaviBar = YES;
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.sureBtn];
    [self.view addSubview:self.contentLab];
    
    NSString *string = self.funcPattern == Register ? [NSString stringWithFormat:@"We sent an email to %@ Enter the verification code sent to your email address.",self.emailStr] : [NSString stringWithFormat:@"We sent an email to %@ enter the verification code sent to your email address，and you can reset you password.",self.emailStr];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:string];
    [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0x006241"] range:[string rangeOfString:self.emailStr]];
    [attribute addAttribute:NSFontAttributeName value:FONT_BOLD(16) range: [string rangeOfString:self.emailStr]];
    self.contentLab.attributedText = attribute;
    CGRect contentLabRect = [self.contentLab.text boundingRectWithSize:CGSizeMake(self.contentLab.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.contentLab.font} context:nil];
    self.contentLab.height = contentLabRect.size.height;
    [self.contentLab sizeToFit];
    
    CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
    cellProperty.cellBgColorNormal = [UIColor colorWithHexString:@"0xE5E5E5"];
    cellProperty.cellBgColorSelected = [UIColor whiteColor];
    cellProperty.cellBorderColorFilled = [UIColor colorWithHexString:@"0x006241"];
    cellProperty.cellBorderColorSelected = [UIColor clearColor];
    cellProperty.cellBgColorFilled = [UIColor whiteColor];
    cellProperty.cornerRadius = 10;
    cellProperty.borderWidth = 2;
    cellProperty.cellFont = FONT_MEDIUM(24);
    cellProperty.cellTextColor = [UIColor colorWithHexString:@"0x000000"];
    cellProperty.configCellShadowBlock = ^(CALayer * _Nonnull layer) {
    };

    CRBoxInputView *boxInputView = [[CRBoxInputView alloc] initWithCodeLength:6];
    [self.view addSubview:boxInputView];
    self.boxInputView = boxInputView;
    boxInputView.frame = CGRectMake(24, self.contentLab.bottom+32, kScreenWidth-24*2, 46);
    boxInputView.boxFlowLayout.itemSize = CGSizeMake(46, 46);
    boxInputView.customCellProperty = cellProperty;
    [boxInputView loadAndPrepareViewWithBeginEdit:YES];
    boxInputView.ifNeedCursor = NO;
    boxInputView.textDidChangeblock = ^(NSString *text, BOOL isFinished) {
        self.sureBtn.backgroundColor = !isFinished ? [UIColor colorWithHexString:@"0xC9C9C9"] : [UIColor colorWithHexString:@"0x006241"];
        self.inputStr = text;
    };
    
    [self.view addSubview:self.resetEmailBtn];
}

// MARK: actions
- (void)backBtnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sureBtnAction:(UIButton *)sender {
    if (!ValidStr(self.inputStr)) return;
    NSDictionary *params = @{@"email":self.emailStr,@"code":self.inputStr};
    [ABLoginInterface login_registerVerificationCodeWithParams:params success:^(id  _Nonnull responseObject) {
        ABSetPasswordViewController *vc = [[ABSetPasswordViewController alloc] init];
        vc.funcPattern = self.funcPattern;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)resetEmailBtnAction:(UIButton *)sender {
    ABPopResendEmailViewController * vc = ABPopResendEmailViewController.new;
    vc.delegate = self;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

// MARK: ABPopResendEmailDelegate
- (void)resendEmail {
    NSString *type = self.funcPattern == Register ? @"1" : @"2";
    NSDictionary *params = @{@"email":self.emailStr,@"type":type};
    [ABLoginInterface login_registerWithParams:params success:^(id  _Nonnull responseObject) {
        [UIViewController jaf_showHudTip:@"Sent successfully"];
    }];
}

// MARK: Lazy loading
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.font = FONT_MEDIUM(24);
        _titleLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        _titleLab.text = self.funcPattern == Register ? @"Verify email" : @"Reset password";
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

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = UILabel.new;
        _contentLab.font = FONT_REGULAR(15);
        _contentLab.frame = CGRectMake(24, self.titleLab.bottom+24, kScreenWidth-24*2, 0);
        _contentLab.numberOfLines = 0;
        _contentLab.textColor = [UIColor colorWithHexString:@"0x000000"];
    }
    return _contentLab;
}

- (UIButton *)resetEmailBtn {
    if (!_resetEmailBtn) {
        _resetEmailBtn = UIButton.new;
        [_resetEmailBtn setTitle:@"Didn't receive email ? " forState:UIControlStateNormal];
        [_resetEmailBtn setTitleColor:[UIColor colorWithHexString:@"0x006241"] forState:UIControlStateNormal];
        _resetEmailBtn.titleLabel.font = FONT_REGULAR(15);
        [_resetEmailBtn addTarget:self action:@selector(resetEmailBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat w = [_resetEmailBtn.titleLabel.text getWidthWithHeight:20 Font:_resetEmailBtn.titleLabel.font];
        _resetEmailBtn.frame = CGRectMake(25, self.boxInputView.bottom+16, w, 20);
    }
    return _resetEmailBtn;
}
@end

