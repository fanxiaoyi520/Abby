//
//  ABOxygenBillCell.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/8.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABOxygenBillCell.h"

@interface ABOxygenBillCell ()

@property (nonatomic ,strong) UILabel *rewardLab;
@property (nonatomic ,strong) UILabel *timeLab;
@property (nonatomic ,strong) UILabel *rewardNumLab;

@end

@implementation ABOxygenBillCell

- (void)setCellModel:(ABOxygenBillListModel *)cellModel {
    _cellModel = cellModel;
    
    self.lineView.frame = CGRectMake(24, 57.5, kScreenWidth-24*2, .5);
    
    self.rewardLab.text = cellModel.reward;
    CGFloat rewardLab_w = [self.rewardLab.text getWidthWithHeight:18 Font:self.rewardLab.font];
    self.rewardLab.frame = CGRectMake(24, 10, rewardLab_w, 18);
    
    self.timeLab.text = cellModel.time;
    CGFloat timeLab_w = [self.timeLab.text getWidthWithHeight:16 Font:self.timeLab.font];
    self.timeLab.frame = CGRectMake(24, self.rewardLab.bottom+1, timeLab_w, 16);
    
    self.rewardNumLab.text = [NSString stringWithFormat:@"+%@",cellModel.rewardNum];
    CGFloat rewardNumLab_w = [self.rewardNumLab.text getWidthWithHeight:28 Font:self.rewardNumLab.font];
    self.rewardNumLab.frame = CGRectMake(kScreenWidth-rewardNumLab_w-24, 15, rewardNumLab_w, 28);
}

// MARK: Lazy loading
- (UILabel *)rewardLab {
    if (!_rewardLab) {
        _rewardLab = [UILabel new];
        _rewardLab.font = FONT_MEDIUM(12);
        _rewardLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        [self addSubview:_rewardLab];
    }
    return _rewardLab;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [UILabel new];
        _timeLab.font = FONT_MEDIUM(9);
        _timeLab.textColor = [UIColor colorWithHexString:@"0xC8C8C8"];
        [self addSubview:_timeLab];
    }
    return _timeLab;
}

- (UILabel *)rewardNumLab {
    if (!_rewardNumLab) {
        _rewardNumLab = [UILabel new];
        _rewardNumLab.font = FONT_MEDIUM(18);
        _rewardNumLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        [self addSubview:_rewardNumLab];
    }
    return _rewardNumLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = kLineColor;
        [self addSubview:_lineView];
    }
    return _lineView;
}
@end
