//
//  ABSettingsHeaderView.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/9.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABSettingsHeaderView.h"

@implementation ABSettingsHeaderView
{
    NSInteger _oldTag;
    UIView *_bgView;
    UIView *_lineView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = KWhiteColor;
    bgView.frame = self.frame;
    [self addSubview:bgView];
    _bgView = bgView;
    
    UIView *lineView = [UIView new];
    [bgView addSubview:lineView];
    lineView.backgroundColor = [UIColor colorWithHexString:@"0x006241"];
    _lineView = lineView;
    _lineView.size = CGSizeMake(50, 3);
    _lineView.bottom = self.bottom;
    
    NSArray *array = @[@"Devices",@"App"];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [bgView addSubview:btn];
        [btn setTitle:array[idx] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"0xC8C8C8"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"0x006241"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(0+idx*(kScreenWidth/2), 0, kScreenWidth/2, self.height);
        btn.tag = 100+idx;
        if (idx==0) {
            _oldTag = btn.tag;
            btn.selected = YES;
            _lineView.left = btn.left+(btn.width-50)/2;
        }
    }];
}

// MARK: actions
- (void)switchAction:(UIButton *)sender {
    _lineView.left = sender.left+(sender.width-50)/2;
    UIButton *oldBtn = [_bgView viewWithTag:_oldTag];
    oldBtn.selected = NO;
    sender.selected = YES;
    _oldTag = sender.tag;
    
    if ([self.delegate respondsToSelector:@selector(switchSetting:)]) {
        [self.delegate switchSetting:sender];
    }
}
@end
