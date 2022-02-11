//
//  ABDeleteDeviceViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/9.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABDeleteDeviceViewController.h"

@interface ABDeleteDeviceViewController ()

@end

@implementation ABDeleteDeviceViewController
{
    UIView *_bgView;
    UIButton *_closeBtn;
    UILabel *_contentLab;
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
    _bgView.frame = CGRectMake(0, kScreenHeight-363, kScreenWidth, 363);
    [UIView jaf_cutOptionalFillet:_bgView byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(30, 30)];
    
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bgView addSubview:_closeBtn];
    [_closeBtn setImage:ImageName(@"icon_t_closure") forState:UIControlStateNormal];
    _closeBtn.frame = CGRectMake(kScreenWidth-24*2, 24, 24, 24);
    kWeakSelf(self);
    [_closeBtn addTapBlock:^(UIButton *btn) {
        [weakself dismissViewControllerAnimated:YES completion:nil];
    }];
    
    NSString *conStr = @"​After deleting the device, the device will no longer be associated with your account, and the device will restore to factory settings . Rest assured, your planting records will not be deleted after deleting the device.";
    _contentLab = [UILabel new];
    _contentLab.numberOfLines = 0;
    [ABUtils setTextColorAndFont:_contentLab str:conStr textArray:@[conStr] colorArray:@[[UIColor colorWithHexString:@"0x000000"]] fontArray:@[FONT_REGULAR(15)]];
    [_bgView addSubview:_contentLab];
    _contentLab.frame = CGRectMake(26, 72, kScreenWidth-26*2, 0);
    CGRect contentLabRect = [conStr boundingRectWithSize:CGSizeMake(kScreenWidth-26*2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:FONT_REGULAR(15)} context:nil];
    _contentLab.height = contentLabRect.size.height;
    [_contentLab sizeToFit];
    
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sureBtn setTitle:@"Delete Device" forState:UIControlStateNormal];
    [_sureBtn setTitleColor:[UIColor colorWithHexString:@"0xFFFFFF"] forState:UIControlStateNormal];
    _sureBtn.titleLabel.font = FONT_MEDIUM(18);
    _sureBtn.backgroundColor = [UIColor colorWithHexString:@"0xF72E47"];
    [_bgView addSubview:_sureBtn];
    _sureBtn.frame = CGRectMake(26, 363-60-CONTACTS_SAFE_BOTTOM-24, kScreenWidth-26*2, 60);
    [UIView jaf_cutOptionalFillet:_sureBtn byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(30, 30)];
    [_sureBtn addTapBlock:^(UIButton *btn) {
        [weakself dismissViewControllerAnimated:YES completion:^{
            if (weakself.block) weakself.block();
        }];
    }];
}
@end
