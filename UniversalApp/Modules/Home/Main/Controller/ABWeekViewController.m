//
//  ABWeekViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/20.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABWeekViewController.h"

@interface ABWeekViewController ()

@property (nonatomic , strong)UIImageView *tabImgView;
@property (nonatomic , strong)UILabel *titleLab;
@property (nonatomic , strong)UIView *lineView;
@end

@implementation ABWeekViewController

- (void)viewDidLoad {
    [self superConfigure];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)superConfigure {
    self.bg_Height = 363;
    self.content_Str = @"​Day 18, properly trim the leaves if necessary .";
    self.btn_bg_Color = @"0x006241";
    self.btn_Title = @"Learn more";
    self.isLeft = NO;
}

- (void)setupUI {
    
    self.tabImgView.frame = CGRectMake(25, 25, 22, 22);
    self.tabImgView.image = ImageName(@"icon_h_week");
    
    self.titleLab.text = @"Week";
    self.titleLab.frame = CGRectMake(self.tabImgView.right+9, 27, 200, 19);
    
    self.lineView.frame = CGRectMake(24, 67, kScreenWidth-24*2, 1);
    
    self.contentLab.top = self.lineView.bottom+24;
}

- (void)sureBtnFuncAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.kDelegate respondsToSelector:@selector(mainHone_learnMore:)]) {
            [self.kDelegate mainHone_learnMore:sender];
        }
    }];
}

// MARK: Lazy loading
- (UIImageView *)tabImgView {
    if (!_tabImgView) {
        _tabImgView = [UIImageView new];
        [self.bgView addSubview:_tabImgView];
    }
    return _tabImgView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = FONT_BOLD(16);
        _titleLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        [self.bgView addSubview:_titleLab];
    }
    return _titleLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = kLineColor;
        [self.bgView addSubview:_lineView];
    }
    return _lineView;
}
@end
