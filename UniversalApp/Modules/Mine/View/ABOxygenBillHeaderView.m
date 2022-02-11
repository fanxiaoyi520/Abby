//
//  ABOxygenBillHeaderView.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/8.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABOxygenBillHeaderView.h"

@interface ABOxygenBillHeaderView ()

@property (nonatomic ,strong) UILabel *totalLab;
@property (nonatomic ,strong) UILabel *totalNumLab;
@property (nonatomic ,strong) UILabel *dateLab;
@property (nonatomic ,strong) UILabel *incomeLab;
@property (nonatomic ,strong) UILabel *expenseLab;
@property (nonatomic ,strong) UIView *lineView;
@end
@implementation ABOxygenBillHeaderView

- (void)setHeaderModel:(ABOxygenBillModel *)headerModel {
    _headerModel = headerModel;
    
    self.lineView.frame = CGRectMake(24, 147.5, kScreenWidth-24*2, .5);
    [ABUtils drawDashLine:self.lineView lineLength:2 lineSpacing:2 lineColor:kLineColor];
    
    self.totalLab.text = @"Total";
    CGFloat totalLab_w = [self.totalLab.text getWidthWithHeight:18 Font:self.totalLab.font];
    self.totalLab.frame = CGRectMake(24, 24, totalLab_w, 18);
    
    self.totalNumLab.text = headerModel.total;
    CGFloat totalNumLab_w = [self.totalNumLab.text getWidthWithHeight:36 Font:self.totalNumLab.font];
    self.totalNumLab.frame = CGRectMake(24, self.totalLab.bottom+3, totalNumLab_w, 36);
    
    [ABUtils setTextColorAndFont:self.incomeLab str:[NSString stringWithFormat:@"Income %@g",headerModel.income] textArray:@[@"Income",[NSString stringWithFormat:@"%@g",headerModel.income]] colorArray:@[[UIColor colorWithHexString:@"0x000000"],[UIColor colorWithHexString:@"0xF72E47"]] fontArray:@[FONT_REGULAR(13),FONT_MEDIUM(13)]];
    CGFloat incomeLab_w = [self.incomeLab.text getWidthWithHeight:18 Font:self.incomeLab.font];
    self.incomeLab.frame = CGRectMake(24, self.totalNumLab.bottom+3, incomeLab_w, 18);
    
    [ABUtils setTextColorAndFont:self.expenseLab str:[NSString stringWithFormat:@"Expense %@g",headerModel.expense] textArray:@[@"Expense",[NSString stringWithFormat:@"%@g",headerModel.expense]] colorArray:@[[UIColor colorWithHexString:@"0x000000"],[UIColor colorWithHexString:@"0x006241"]] fontArray:@[FONT_REGULAR(13),FONT_MEDIUM(13)]];
    CGFloat expenseLab_w = [self.expenseLab.text getWidthWithHeight:18 Font:self.expenseLab.font];
    self.expenseLab.frame = CGRectMake(24, self.incomeLab.bottom+4, expenseLab_w, 18);
    
    self.dateLab.text = headerModel.date;
    CGFloat dateLab_w = [self.dateLab.text getWidthWithHeight:24 Font:self.dateLab.font];
    self.dateLab.frame = CGRectMake(kScreenWidth-dateLab_w-24, 24, totalNumLab_w, 24);
}

// MARK: Lazy loading
- (UILabel *)totalLab {
    if (!_totalLab) {
        _totalLab = [UILabel new];
        _totalLab.font = FONT_BOLD(12);
        _totalLab.textColor = [UIColor colorWithHexString:@"0xC8C8C8"];
        [self addSubview:_totalLab];
    }
    return _totalLab;
}

- (UILabel *)totalNumLab {
    if (!_totalNumLab) {
        _totalNumLab = [UILabel new];
        _totalNumLab.font = FONT_MEDIUM(24);
        _totalNumLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        [self addSubview:_totalNumLab];
    }
    return _totalNumLab;
}

- (UILabel *)incomeLab {
    if (!_incomeLab) {
        _incomeLab = [UILabel new];
        _incomeLab.font = FONT_REGULAR(13);
        _incomeLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        [self addSubview:_incomeLab];
    }
    return _incomeLab;
}

- (UILabel *)expenseLab {
    if (!_expenseLab) {
        _expenseLab = [UILabel new];
        _expenseLab.font = FONT_REGULAR(13);
        _expenseLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        [self addSubview:_expenseLab];
    }
    return _expenseLab;
}

- (UILabel *)dateLab {
    if (!_dateLab) {
        _dateLab = [UILabel new];
        _dateLab.font = FONT_BOLD(12);
        _dateLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        [self addSubview:_dateLab];
    }
    return _dateLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        [self addSubview:_lineView];
    }
    return _lineView;
}
@end
