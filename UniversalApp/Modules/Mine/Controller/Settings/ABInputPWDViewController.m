//
//  ABInputPWDViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/10.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABInputPWDViewController.h"

@interface ABInputPWDViewController ()<UITextFieldDelegate>
@property (nonatomic ,strong) TuyaSmartDevice *device;
@end

@implementation ABInputPWDViewController
{
    UIView *_bgView;
    UIButton *_closeBtn;
    UILabel *_contentLab;
    UILabel *_errorLab;
    UIButton *_sureBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI {
    _bgView = [UIView new];
    _bgView.backgroundColor = KWhiteColor;
    [self.view addSubview:_bgView];
    _bgView.frame = CGRectMake(0, kScreenHeight-460, kScreenWidth, 460);
    [UIView jaf_cutOptionalFillet:_bgView byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(30, 30)];
    
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bgView addSubview:_closeBtn];
    [_closeBtn setImage:ImageName(@"icon_t_closure") forState:UIControlStateNormal];
    _closeBtn.frame = CGRectMake(kScreenWidth-24*2, 24, 24, 24);
    kWeakSelf(self);
    [_closeBtn addTapBlock:^(UIButton *btn) {
        [weakself dismissViewControllerAnimated:YES completion:nil];
    }];
    
    NSString *conStr = @"​Please enter the password for APP login to confirm again";
    _contentLab = [UILabel new];
    _contentLab.numberOfLines = 0;
    [ABUtils setTextColorAndFont:_contentLab str:conStr textArray:@[conStr] colorArray:@[[UIColor colorWithHexString:@"0x000000"]] fontArray:@[FONT_REGULAR(15)]];
    [_bgView addSubview:_contentLab];
    _contentLab.frame = CGRectMake(26, 72, kScreenWidth-26*2, 0);
    CGRect contentLabRect = [conStr boundingRectWithSize:CGSizeMake(kScreenWidth-26*2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:FONT_REGULAR(15)} context:nil];
    _contentLab.height = contentLabRect.size.height;
    [_contentLab sizeToFit];
    
    __block CGFloat bottom_Height = 0;
    NSArray *array = @[@"Account",@"Passward"];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITextField *txtField = [[UITextField alloc] init];
        txtField.placeholder = array[idx];
        [_bgView addSubview:txtField];
        txtField.frame = CGRectMake(24, _contentLab.bottom+14+idx*(50+20), _bgView.width-24*2, 50);
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 50)];
        txtField.leftViewMode = UITextFieldViewModeAlways;
        txtField.leftView = leftView;
        txtField.textColor = [UIColor colorWithHexString:@"0x000000"];
        txtField.font = FONT_REGULAR(13);
        txtField.delegate = self;
        txtField.clearsOnBeginEditing = NO;
        txtField.clearButtonMode = UITextFieldViewModeWhileEditing;
        txtField.keyboardType = UIKeyboardTypeASCIICapable;
        txtField.tag = 100+idx;
        txtField.text = idx==0 ? [UserManager sharedUserManager].curUserInfo.email: nil;

        if (idx == 1) {
            txtField.secureTextEntry = YES;
            txtField.delegate = self;
        }

        UIView *lineView = [UIView new];
        lineView.backgroundColor = [UIColor colorWithHexString:@"0x006241"];
        [_bgView addSubview:lineView];
        lineView.frame = CGRectMake(24, 176+idx*(50+19), kScreenWidth-24*2, .5);
        if (idx == 1) bottom_Height = lineView.bottom;
    }];
    
    _errorLab = [UILabel new];
    _errorLab.font = FONT_MEDIUM(15);
    _errorLab.textColor = [UIColor colorWithHexString:@"0xF72E47"];
    _errorLab.text = @"Password error！";
    [_bgView addSubview:_errorLab];
    _errorLab.hidden = YES;
    CGFloat errorWidth = [_errorLab.text getWidthWithHeight:24 Font:_errorLab.font];
    _errorLab.frame = CGRectMake(40, bottom_Height+9, errorWidth, 24);
    
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sureBtn setTitle:@"Confirm" forState:UIControlStateNormal];
    [_sureBtn setTitleColor:[UIColor colorWithHexString:@"0xFFFFFF"] forState:UIControlStateNormal];
    _sureBtn.titleLabel.font = FONT_MEDIUM(18);
    _sureBtn.backgroundColor = [UIColor colorWithHexString:@"0x006241"];
    [_bgView addSubview:_sureBtn];
    _sureBtn.frame = CGRectMake(26, 460-60-CONTACTS_SAFE_BOTTOM-24, kScreenWidth-26*2, 60);
    [UIView jaf_cutOptionalFillet:_sureBtn byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(30, 30)];
    [_sureBtn addTapBlock:^(UIButton *btn) {
        if ([weakself validInput]) {
            [[deviceManager getDevice] remove:^{
                KPostNotification(KNotificationLoginStateChange, @(kUserLoginStatusLoggedInUnboundDevice));
            } failure:^(NSError *error) {
                NSLog(@"remove failure: %@", error);
            }];
        }
    }];
}

// MARK: actions
- (BOOL)validInput {
    UITextField *accountTXT = [_bgView viewWithTag:100];
    UITextField *passTXT = [_bgView viewWithTag:101];
    
    if (!ValidStr(accountTXT.text)) {
        [UIViewController jaf_showHudTip:@"Account cannot be empty"];
        return NO;
    }
    
    if (!ValidStr(passTXT.text)) {
        [UIViewController jaf_showHudTip:@"Password cannot be empty"];
        return NO;
    }

    return YES;
}

// MARK: UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.tag == 101) _errorLab.hidden = YES;
}

@end
