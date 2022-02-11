//
//  ABCustomNavBar.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/24.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABCustomNavBar.h"
@interface ABCustomNavBar()

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIImageView *headImgView;
@end
@implementation ABCustomNavBar


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KWhiteColor;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.titleLab.text = @"Trend";
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:Default_Avatar];
}

// MAKR:
- (void)headImgClickAction:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(customNavBarClickEventAction:)]) {
        [self.delegate customNavBarClickEventAction:tap];
    }
}

// MARK:
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = FONT_BOLD(26);
        _titleLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(24);
            make.right.mas_equalTo(-24);
            make.top.mas_equalTo(60);
            make.height.mas_equalTo(22);
        }];
    }
    return _titleLab;
}

- (UIImageView *)headImgView {
    if (!_headImgView) {
        _headImgView = [UIImageView new];
        _headImgView.userInteractionEnabled = YES;
        [self addSubview:_headImgView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImgClickAction:)];
        [_headImgView addGestureRecognizer:tap];
        [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kScreenWidth-24-19);
            make.right.mas_equalTo(-19);
            make.top.mas_equalTo(60);
            make.width.height.mas_equalTo(24);
        }];
    }
    return _headImgView;
}
@end
