//
//  ABOxygenRewardViewController.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/18.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABOxygenRewardViewController.h"

@interface ABOxygenRewardViewController ()

@property (nonatomic ,strong) UIView *bgView;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIButton *closeBtn;
@property (nonatomic ,strong) UIButton *sureBtn;
@property (nonatomic ,strong) NSArray *dataList;
@property (nonatomic ,assign) NSInteger oldSelBtnTag;
@end

@implementation ABOxygenRewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataList = @[@"50g",@"100g",@"200g",@"300g",@"500g",@"800g"];
    [self setupUI];
}

- (void)setupUI {
    self.bgView.frame = CGRectMake(0, kScreenHeight-366, kScreenWidth, 366);
    [self.bgView addRoundedCorners:UIRectCornerAllCorners withRadii:CGSizeMake(19, 19)];
    
    self.closeBtn.frame = CGRectMake(24, 28, 24, 24);
    self.titleLab.frame = CGRectMake(24, 28, kScreenWidth-24*2, 22);
    self.sureBtn.frame = CGRectMake(24, self.bgView.height - CONTACTS_SAFE_BOTTOM - 24-60, kScreenWidth-24*2, 60);
    [self.sureBtn addRoundedCorners:UIRectCornerAllCorners withRadii:CGSizeMake(30, 30)];
    
    CGFloat Start_X = 24.0f;
    CGFloat Start_Y = self.titleLab.bottom + 34;
    CGFloat Width_Space = 29.0f;
    CGFloat Height_Space = 32.0f;
    CGFloat Button_Height = 50.0f;
    CGFloat Button_Width = (kScreenWidth-Width_Space*2-Start_X*2)/3;
    
    [_dataList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger index = idx%3;
        NSInteger page = idx/3;
        
        UIButton *o2Btn = UIButton.new;
        [self.bgView addSubview:o2Btn];
        [o2Btn setTitle:_dataList[idx] forState:UIControlStateNormal];
        o2Btn.tag = 100+idx;
        [o2Btn addTarget:self action:@selector(o2BtnAction:) forControlEvents:UIControlEventTouchUpInside];
        ViewRadius(o2Btn, 10);
        o2Btn.frame = CGRectMake(index*(Button_Width+Width_Space)+Start_X, page*(Button_Height+Height_Space)+Start_Y, Button_Width, Button_Height);
        o2Btn.selected = idx == 0 ? YES : NO;
        self.oldSelBtnTag = 100;
        
        if (o2Btn.selected) {
            o2Btn.backgroundColor = [UIColor colorWithHexString:@"0x006241"];
            [o2Btn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        } else {
            o2Btn.backgroundColor = [UIColor colorWithHexString:@"0xEBFAEE"];
            [o2Btn setTitleColor:[UIColor colorWithHexString:@"0x006241"] forState:UIControlStateNormal];
        }
    }];
}

// MARK: actions
- (void)closeBtnAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)o2BtnAction:(UIButton *)sender {
    UIButton *oldBtn = [self.bgView viewWithTag:self.oldSelBtnTag];
    
    if (oldBtn.tag != sender.tag) {
        sender.backgroundColor = [UIColor colorWithHexString:@"0x006241"];
        [sender setTitleColor:KWhiteColor forState:UIControlStateNormal];
        
        oldBtn.backgroundColor = [UIColor colorWithHexString:@"0xEBFAEE"];
        [oldBtn setTitleColor:[UIColor colorWithHexString:@"0x006241"] forState:UIControlStateNormal];
    }
    self.oldSelBtnTag = sender.tag;
}

- (void)sureBtnAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(oxygenReward_sureBtnAction:)]) {
            [self.delegate oxygenReward_sureBtnAction:_dataList[self.oldSelBtnTag-100]];
        }
    }];
}

// MARK: Lazy loading
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = UIView.new;
        [self.view addSubview:_bgView];
        _bgView.backgroundColor = KWhiteColor;
    }
    return _bgView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = UILabel.new;
        [self.bgView addSubview:_titleLab];
        _titleLab.font = FONT_MEDIUM(18);
        _titleLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.text = @"Tips";
    }
    return _titleLab;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = UIButton.new;
        [self.bgView addSubview:_closeBtn];
        [_closeBtn addTarget:self action:@selector(closeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_closeBtn setImage:ImageName(@"icon_t_closure") forState:UIControlStateNormal];
    }
    return _closeBtn;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = UIButton.new;
        [self.bgView addSubview:_sureBtn];
        [_sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_sureBtn setTitle:@"Ok" forState:UIControlStateNormal];
        _sureBtn.backgroundColor = [UIColor colorWithHexString:@"0x006241"];
        [_sureBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = FONT_MEDIUM(18);
    }
    return _sureBtn;
}
@end
