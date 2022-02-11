//
//  ABTaskViewController.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/17.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABTaskViewController.h"

@interface ABTaskViewController ()

@property (nonatomic ,strong) UIView *bgView;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *tipsLab;
@property (nonatomic ,strong) UIImageView *o2ImgView;
@property (nonatomic ,strong) UIView *lineView;
@property (nonatomic ,strong) UIButton *sureBtn;
@end

@implementation ABTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI {
    self.bgView.frame = CGRectMake((kScreenWidth-ratioW(281))/2, (kScreenHeight-ratioH(320))/2, ratioW(281), ratioH(320));
    ViewRadius(self.bgView, 15);
    
    self.titleLab.text = @"Task";
    self.titleLab.frame = CGRectMake(0, ratioH(32), self.bgView.width, ratioH(21));
    
    self.tipsLab.text = @"Complete the water change work to be completed last week to get a gift";
    CGRect tipsLabRect = [self.tipsLab.text boundingRectWithSize:CGSizeMake(self.bgView.width-16*2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.tipsLab.font} context:nil];
    self.tipsLab.frame = CGRectMake(16, self.titleLab.bottom+ratioH(15), self.bgView.width-16*2, tipsLabRect.size.height);
    
    
    self.o2ImgView.image = ImageName(@"icon_90_gift");
    self.o2ImgView.frame = CGRectMake((self.bgView.width-ratioH(63))/2, self.tipsLab.bottom+ratioH(34), ratioH(63), ratioH(63));
    
    self.lineView.frame = CGRectMake(0, self.bgView.height-ratioH(60), self.bgView.width, 1);
    self.sureBtn.frame = CGRectMake(0, self.lineView.bottom, self.bgView.width, ratioH(60));
}

// MARK: actions
- (void)okAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(task_startFuncAction:)]) {
            [self.delegate task_startFuncAction:sender];
        }
    }];
}

// MARK: Lazy loading
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = UIView.new;
        _bgView.backgroundColor = KWhiteColor;
        [self.view addSubview:_bgView];
    }
    return _bgView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = UILabel.new;
        [self.bgView addSubview:_titleLab];
        _titleLab.font = FONT_BOLD(16);
        _titleLab.textColor = [UIColor colorWithHexString:@"0x161B19"];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UILabel *)tipsLab {
    if (!_tipsLab) {
        _tipsLab = UILabel.new;
        [self.bgView addSubview:_tipsLab];
        _tipsLab.font = FONT_REGULAR(13);
        _tipsLab.textColor = [UIColor colorWithHexString:@"0x161B19"];
        _tipsLab.textAlignment = NSTextAlignmentCenter;
        _tipsLab.numberOfLines = 0;
    }
    return _tipsLab;
}

- (UIImageView *)o2ImgView {
    if (!_o2ImgView) {
        _o2ImgView = UIImageView.new;
        [self.bgView addSubview:_o2ImgView];
    }
    return _o2ImgView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = UIView.new;
        _lineView.backgroundColor = kLineColor;
        [self.bgView addSubview:_lineView];
    }
    return _lineView;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = UIButton.new;
        [_sureBtn setTitle:@"Start" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor colorWithHexString:@"0x006241"] forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = FONT_MEDIUM(18);
        [self.bgView addSubview:_sureBtn];
        [_sureBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

@end
