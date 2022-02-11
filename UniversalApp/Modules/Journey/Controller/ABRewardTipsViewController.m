//
//  ABRewardTipsViewController.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/14.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABRewardTipsViewController.h"

@interface ABRewardTipsViewController ()

@property (nonatomic ,strong) UIView *bgView;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *tipsLab;
@property (nonatomic ,strong) UIView *lineView;
@property (nonatomic ,strong) UIButton *sureBtn;
@property (nonatomic ,strong) LOTAnimationView *lottieLogo;
@end

@implementation ABRewardTipsViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.lottieLogo play];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.lottieLogo pause];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI {
    self.bgView.frame = CGRectMake((kScreenWidth-ratioW(281))/2, (kScreenHeight-ratioH(320))/2, ratioW(281), ratioH(320));
    ViewRadius(self.bgView, 15);
    
    self.titleLab.text = @"Congratulations";
    self.titleLab.frame = CGRectMake(0, ratioH(32), self.bgView.width, ratioH(21));
    
    self.tipsLab.text = @"You get 5g O₂ Reward!";
    self.tipsLab.frame = CGRectMake(0, self.titleLab.bottom+ratioH(15), self.bgView.width, ratioH(18));
    
    self.lottieLogo.frame = CGRectMake((self.bgView.width-ratioH(109))/2, self.tipsLab.bottom+ratioH(24), ratioW(109), ratioH(138));
    
    self.lineView.frame = CGRectMake(0, self.bgView.height-ratioH(60), self.bgView.width, 1);
    self.sureBtn.frame = CGRectMake(0, self.lineView.bottom, self.bgView.width, ratioH(60));
}

// MARK: actions
- (void)okAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    }
    return _tipsLab;
}

- (LOTAnimationView *)lottieLogo {
    if (!_lottieLogo) {
        _lottieLogo = [LOTAnimationView animationNamed:@"o2dataqipao"];
        _lottieLogo.contentMode = UIViewContentModeScaleAspectFill;
        _lottieLogo.loopAnimation = YES;
        [self.bgView addSubview:self.lottieLogo];
    }
    return _lottieLogo;
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
        [_sureBtn setTitle:@"OK" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor colorWithHexString:@"0x006241"] forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = FONT_MEDIUM(18);
        [self.bgView addSubview:_sureBtn];
        [_sureBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
@end
