//
//  ABWifiListCell.m
//  UniversalApp
//
//  Created by Baypac on 2021/11/26.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABWifiListCell.h"

@interface ABWifiListCell()

@property (nonatomic ,strong)UILabel *nameLab;
@property (nonatomic ,strong)UIView *lineView;
@property (nonatomic ,strong)UIButton *selectBtn;
@end

@implementation ABWifiListCell
// MARK: data
- (void)setModel:(ABWifiListModel *)model {
    
    [self.contentView addSubview:self.nameLab];
    self.nameLab.text = @"Wework";
    CGFloat nameWidth = [self.nameLab.text getWidthWithHeight:24 Font:self.nameLab.font];
    self.nameLab.frame = CGRectMake(26, 18, nameWidth, 24);

    [self.contentView addSubview:self.lineView];
    self.lineView.frame = CGRectMake(20, self.height-1, self.width-20*2, 1);
}

// MARK: Lazy loading
- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [UILabel new];
        _nameLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        _nameLab.font = FONT_MEDIUM(15);
    }
    return _nameLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = kLineColor;
    }
    return _lineView;
}

- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:ImageName(@"") forState:UIControlStateNormal];
        [_selectBtn setImage:ImageName(@"") forState:UIControlStateSelected];
    }
    return _selectBtn;
}

@end
