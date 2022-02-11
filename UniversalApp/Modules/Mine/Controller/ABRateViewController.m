//
//  ABRateViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/13.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABRateViewController.h"
#import <StoreKit/StoreKit.h>
@interface ABRateViewController ()

@property (nonatomic ,strong) UIView *bgView;
@property (nonatomic ,strong) UIImageView *titleImgView;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *subTitleLab;
@property (nonatomic ,strong) UIView *w_lineView;
@property (nonatomic ,strong) UIView *h_lineView;
@end

@implementation ABRateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI {
    self.bgView.frame = CGRectMake(47, (kScreenHeight-(kScreenWidth-47*2))/2, kScreenWidth-47*2, 308);
    [UIView jaf_cutOptionalFillet:_bgView byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(15, 15)];
    
    self.titleImgView.image = ImageName(@"mine_pingfen_pic_1");
    self.titleImgView.frame = CGRectMake((self.bgView.width-55)/2, 32, 55, 52);
    
    self.titleLab.text = @"Rate Abby App";
    self.titleLab.frame = CGRectMake(0, self.titleImgView.bottom+12, self.bgView.width, 24);
    
    self.subTitleLab.text = @"Tap a star to give your rating";
    self.subTitleLab.frame = CGRectMake(0, self.titleLab.bottom+12, self.bgView.width, 24);
    
    self.w_lineView.frame = CGRectMake(0, self.bgView.height-60, self.bgView.width, 1);
    self.h_lineView.frame = CGRectMake(self.bgView.width/2-.5, self.bgView.height-60, 1, 60);
    
    for (int i=0; i<5; i++) {
        UIImageView *imgView = [UIImageView new];
        [self.bgView addSubview:imgView];
        imgView.image = ImageName(@"mine_pingfen_pic_2");
        imgView.frame = CGRectMake(32+i*(34+(self.bgView.width-5*34-2*32)/4), self.subTitleLab.bottom+30, 34, 32);
    }
    
    NSArray *btnArray = @[@"Cancel",@"Ok"];
    [btnArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bgView addSubview:btn];
        btn.frame = CGRectMake(idx*(self.bgView.width/2-.5+1), self.w_lineView.bottom, self.bgView.width/2-.5, 59);
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitle:btnArray[idx] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"0x006241"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+idx;
    }];
}


// MARK: Lazy loading
- (void)btnAction:(UIButton *)sender {
    if (sender.tag == 100) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self dismissViewControllerAnimated:NO completion:^{
            NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?action=write-review", @"com.cl.Abby"];
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
        }];
    }
}

// MARK: Lazy loading
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        [self.view addSubview:_bgView];
        _bgView.backgroundColor = KWhiteColor;
    }
    return _bgView;
}

- (UIImageView *)titleImgView {
    if (!_titleImgView) {
        _titleImgView = [UIImageView new];
        [self.bgView addSubview:_titleImgView];
    }
    return _titleImgView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = FONT_BOLD(16);
        _titleLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        [self.bgView addSubview:_titleLab];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UILabel *)subTitleLab {
    if (!_subTitleLab) {
        _subTitleLab = [UILabel new];
        _subTitleLab.font = FONT_REGULAR(13);
        _subTitleLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        [self.bgView addSubview:_subTitleLab];
        _subTitleLab.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:_subTitleLab];
    }
    return _subTitleLab;
}

- (UIView *)w_lineView {
    if (!_w_lineView) {
        _w_lineView = [UIView new];
        _w_lineView.backgroundColor = kLineColor;
        [self.bgView addSubview:_w_lineView];
    }
    return _w_lineView;
}

- (UIView *)h_lineView {
    if (!_h_lineView) {
        _h_lineView = [UIView new];
        _h_lineView.backgroundColor = kLineColor;
        [self.bgView addSubview:_h_lineView];
    }
    return _h_lineView;
}
@end
