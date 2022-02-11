//
//  BaseModalPopUpViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/15.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "BaseModalPopUpViewController.h"

@interface BaseModalPopUpViewController ()
{
    UIView *_bgView;
    UIButton *_closeBtn;
    UILabel *_contentLab;
    UIButton *_sureBtn;
}
@end

@implementation BaseModalPopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor clearColor];
    [self setupUI1];
}

- (void)setupUI1 {
    self.bg_Height = self.bg_Height > 0 ? self.bg_Height : 400;
    _bgView = [UIView new];
    _bgView.backgroundColor = KWhiteColor;
    _bgView.frame = CGRectMake(0, self.view.height-self.bg_Height, kScreenWidth, self.bg_Height);
    [self.view addSubview:_bgView];

    [UIView jaf_cutOptionalFillet:_bgView byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(30, 30)];
    
    CGFloat loc = 0;
    loc = self.isLeft ? 24 : kScreenWidth-24-24;
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bgView addSubview:_closeBtn];
    [_closeBtn setImage:ImageName(@"icon_t_closure") forState:UIControlStateNormal];
    _closeBtn.frame = CGRectMake(loc, 24, 24, 24);
    kWeakSelf(self);
    [_closeBtn addTapBlock:^(UIButton *btn) {
        [weakself dismissViewControllerAnimated:YES completion:nil];
//        kStrongSelf(self)
//        //把最底部的视图控制器dismiss掉
//        UIViewController *parentVC = self.presentingViewController;
//        UIViewController *bottomVC;
//        while (parentVC) {
//            bottomVC = parentVC;
//            parentVC = parentVC.presentingViewController;
//        }
//        [bottomVC dismissViewControllerAnimated:YES completion:^{
//
//        }];
    }];
    
    self.content_Str = ValidStr(self.content_Str) ? self.content_Str: @"default";
    UIColor *titleColor = ValidStr(self.content_color_Str)?[UIColor colorWithHexString:self.content_color_Str]:[UIColor colorWithHexString:@"0x000000"];
    NSString *conStr = self.content_Str;
    _contentLab = [UILabel new];
    _contentLab.numberOfLines = 0;
    [ABUtils setTextColorAndFont:_contentLab str:conStr textArray:@[conStr] colorArray:@[titleColor] fontArray:@[FONT_REGULAR(15)]];
    [_bgView addSubview:_contentLab];
    _contentLab.frame = CGRectMake(26, 72, kScreenWidth-26*2, 0);
    CGRect contentLabRect = [conStr boundingRectWithSize:CGSizeMake(kScreenWidth-26*2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:FONT_REGULAR(15)} context:nil];
    _contentLab.height = contentLabRect.size.height;
    [_contentLab sizeToFit];
    
    self.btn_bg_Color = ValidStr(self.btn_bg_Color)?self.btn_bg_Color:@"0xC8C8C8";
    self.btn_Title = ValidStr(self.btn_Title)?self.btn_Title:@"sure";
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sureBtn setTitle:self.btn_Title forState:UIControlStateNormal];
    [_sureBtn setTitleColor:[UIColor colorWithHexString:@"0xFFFFFF"] forState:UIControlStateNormal];
    _sureBtn.titleLabel.font = FONT_MEDIUM(18);
    _sureBtn.backgroundColor = [UIColor colorWithHexString:self.btn_bg_Color];
    [_bgView addSubview:_sureBtn];
    _sureBtn.frame = CGRectMake(26, self.bg_Height-60-CONTACTS_SAFE_BOTTOM-24, kScreenWidth-26*2, 60);
    [UIView jaf_cutOptionalFillet:_sureBtn byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(30, 30)];
    [_sureBtn addTapBlock:^(UIButton *btn) {
        [weakself sureBtnFuncAction:btn];
    }];
}

- (void)sureBtnFuncAction:(UIButton *)sender {}

@end
