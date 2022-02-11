//
//  ABBlueToothSearchCell.m
//  UniversalApp
//
//  Created by Baypac on 2021/11/26.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABBlueToothSearchCell.h"

@interface ABBlueToothSearchCell ()

@property (nonatomic ,strong)UILabel *nameLab;
@property (nonatomic ,strong)UIButton *addBtn;
@property (nonatomic ,strong)UIView *lineView;
@end

@implementation ABBlueToothSearchCell

// MARK: data
- (void)setPeripheral:(TYBLEAdvModel *)peripheral {
    [self.contentView addSubview:self.nameLab];
    self.nameLab.text = peripheral.uuid;
    CGFloat nameWidth = [self.nameLab.text getWidthWithHeight:24 Font:self.nameLab.font];
    self.nameLab.frame = CGRectMake(26, 18, nameWidth, 24);
    
    [self.contentView addSubview:self.addBtn];
    self.addBtn.frame = CGRectMake(KScreenWidth-70-26, 14, 70, 32);
    [UIView jaf_cutOptionalFillet:self.addBtn byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(16, 16)];
    [self.addBtn setTitle:@"Add" forState:UIControlStateNormal];
    
    [self.contentView addSubview:self.lineView];
    self.lineView.frame = CGRectMake(20, self.height-1, self.width-20*2, 1);
}

// MARK: actions
- (void)addBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(addBlueTooth:)]) {
        [self.delegate addBlueTooth:sender];
    }
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

- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setTitleColor:[UIColor colorWithHexString:@"0xFFFFFF"] forState:UIControlStateNormal];
        _addBtn.backgroundColor = [UIColor colorWithHexString:@"0x006241"];
        _addBtn.titleLabel.font = FONT_MEDIUM(15);
        [_addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = kLineColor;
    }
    return _lineView;
}
@end
