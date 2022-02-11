//
//  ABNickNameViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/13.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABNickNameViewController.h"

@interface ABNickNameViewController ()<UITextFieldDelegate>

@property (nonatomic , strong) UITextField *inputTXT;
@property (nonatomic , strong) UIButton *clearBtn;
@end

@implementation ABNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isHidenNaviBar = NO;
    self.isShowLiftBack = NO;
    [self addNavigationItemWithTitles
     :@[@"Cancel"] isLeft:YES target:self action:@selector(naviBtnClick:) tags:@[@1000]];
    [[ABGlobalNotifyServer sharedServer] jaf_addDelegate:self];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 57, 32);
    [btn setTitle:@"Save" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(navRightAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = SYSTEMFONT(17);
    [btn setTitleColor:[UIColor colorWithHexString:@"0xFFFFFF"] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithHexString:@"0x026040"];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [UIView jaf_cutOptionalFillet:btn byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(7, 7)];
    btn.tag = 2000;
    UIBarButtonItem * ribtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = ribtn;
     
    [self setupUI];
}

- (void)setupUI {
    
    self.inputTXT.frame = CGRectMake(0, 8, kScreenWidth, 60);
    self.inputTXT.text = self.nickName;
    
    self.clearBtn.frame = CGRectMake(kScreenWidth-18-24, 29, 18, 18);
}

// MARK: actions
- (void)naviBtnClick:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navRightAction:(UIButton *)btn {
    //校验
    if (self.inputTXT.text.length < 4) {
        [UIViewController jaf_showHudTip:@"Enter a minimum of 4 characters"];
        return;
    }

    if (self.inputTXT.text.length > 32) {
        [UIViewController jaf_showHudTip:@"Enter up to 32 characters"];
        return;
    }

    //后台查重
    [ABMineInterface mine_userNickNameWithParams:@{@"nickName":self.inputTXT.text} success:^(id  _Nonnull responseObject) {
        [[ABGlobalNotifyServer sharedServer] postChangeUserName:self.inputTXT.text];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)clearBtnAction:(UIButton *)sender {
    self.inputTXT.text = nil;
}

// MARK: UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.inputTXT) {
    //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
        if (range.length == 1 && string.length == 0) {
            return YES;
        }
        //so easy
        else if (self.inputTXT.text.length >= 32) {
            self.inputTXT.text = [textField.text substringToIndex:32];
            return NO;
        }
    }
    return YES;
}

// MARK: Lazy loading
- (UITextField *)inputTXT {
    if (!_inputTXT) {
        _inputTXT = [UITextField new];
        [self.view addSubview:_inputTXT];
        _inputTXT.placeholder = @"Input box text";
        _inputTXT.keyboardType = UIKeyboardTypeASCIICapable;
        _inputTXT.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _inputTXT.backgroundColor = KWhiteColor;
        _inputTXT.delegate = self;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 24, 0)];
        _inputTXT.leftView = view;
        _inputTXT.leftViewMode = UITextFieldViewModeAlways;
        _inputTXT.textColor = KBlackColor;
        UIView *r_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 24+18+10, 0)];
        _inputTXT.rightView = r_view;
        _inputTXT.rightViewMode = UITextFieldViewModeAlways;
    }
    return _inputTXT;
}

- (UIButton *)clearBtn {
    if (!_clearBtn) {
        _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_clearBtn];
        [_clearBtn setImage:ImageName(@"icon_t_closure") forState:UIControlStateNormal];
        [_clearBtn addTarget:self action:@selector(clearBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearBtn;
}
@end
