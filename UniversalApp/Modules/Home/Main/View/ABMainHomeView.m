//
//  ABMainHomeView.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/17.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABMainHomeView.h"

@interface ABMainHomeView ()<ABMainHomeDelegate>

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIButton *skinBtn;
@end
@implementation ABMainHomeView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"0xF7F7F7"];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.titleLab.text = @"hey abby";
    [self.skinBtn setImage:ImageName(@"icon_h_skin-1") forState:UIControlStateNormal];
    
    [self addSubview:self.botanyView];
    [_botanyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(kScreenHeight*113.f/812.f);
        make.height.mas_equalTo(kScreenHeight*459.f/812.f);
    }];

    [self addSubview:self.funcView];
    [_funcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.equalTo(self.botanyView.mas_bottom).with.offset(kScreenHeight*24.f/812.f);
        make.height.mas_equalTo(kScreenHeight*113.f/812.f);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-kTabBarHeight-23);
    }];
    [self bringSubviewToFront:self.botanyView];
}

// MARK: ABMainHomeDelegate
- (void)mainHome_weekAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(mainHome_weekAction:)]) {
        [self.delegate mainHome_weekAction:sender];
    }
}

- (void)mainHome_StartFuncAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(mainHome_StartFuncAction:)]) {
        [self.delegate mainHome_StartFuncAction:sender];
    }
}

- (void)mainHone_customerServiceAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(mainHone_customerServiceAction:)]) {
        [self.delegate mainHone_customerServiceAction:sender];
    }
}

- (void)mainHone_OxygenCollectionAction:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(mainHone_OxygenCollectionAction:)]) {
        [self.delegate mainHone_OxygenCollectionAction:tap];
    }
}

// MARK: actions
- (void)skinBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(mainHone_skinAction:)]) {
        [self.delegate mainHone_skinAction:sender];
    }
}

// MARK: Lazy loading
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = FONT_BOLD(24);
        _titleLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        [self addSubview:self.titleLab];
        
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.right.mas_equalTo(-16);
            make.top.equalTo(self).with.offset(kScreenHeight*68.f/812.f);
            make.height.mas_equalTo(28);
        }];
    }
    return _titleLab;
}

- (UIButton *)skinBtn {
    if (!_skinBtn) {
        _skinBtn = UIButton.new;
        [self addSubview:_skinBtn];
        [_skinBtn addTarget:self action:@selector(skinBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_skinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((kScreenWidth-28-16));
            make.right.mas_equalTo(-16);
            make.top.equalTo(self).with.offset(kScreenHeight*68.f/812.f);
            make.width.height.mas_equalTo(28);
        }];
    }
    return _skinBtn;
}

- (ABBotanyView *)botanyView {
    if (!_botanyView) {
        _botanyView = [[ABBotanyView alloc] init];
        _botanyView.delegate = self;
    }
    return _botanyView;
}

- (ABFuncView *)funcView {
    if (!_funcView) {
        _funcView = [[ABFuncView alloc] init];
        _funcView.delegate = self;
    }
    return _funcView;
}
@end
