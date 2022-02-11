//
//  ABMineCell.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/7.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABMineCell.h"

@interface ABMineCell ()

@property (nonatomic, strong) UIImageView *titleIcon;//标题图标
@property (nonatomic, strong) UILabel *titleLbl;//标题
@property (nonatomic, strong) UILabel *detaileLbl;//内容
@property (nonatomic, strong) UIImageView *arrowIcon;//右箭头图标

@end

@implementation ABMineCell

// MAKR: model
- (void)setCellModel:(ABMineModel *)cellModel {
    _cellModel = cellModel;
    
    self.lineView.frame = CGRectMake(24, 59, kScreenWidth-24*2, 1);
    if (cellModel) {
        if (cellModel.imageName) {
            [self.titleIcon setImage:ImageName(cellModel.imageName)];
            self.titleIcon.frame = CGRectMake(KNormalSpace, 14, 32, 32);
        }else{
            self.titleIcon.frame = CGRectZero;
        }
        
        if (cellModel.name) {
            self.titleLbl.text = cellModel.name;
            self.titleLbl.frame = CGRectMake(self.titleIcon.right+8, 19, kScreenWidth-64-91, 24.62);
        }

        if (cellModel.arrow_icon) {
            [self.arrowIcon setImage:ImageName(cellModel.arrow_icon)];
            self.arrowIcon.frame = CGRectMake(kScreenWidth-32-KNormalSpace, 13, 32, 32);
        }else{
            self.arrowIcon.frame = CGRectZero;
        }
        
        self.newsTipsView.frame = CGRectMake(kScreenWidth-43-8, (60-8)/2, 8, 8);
        [UIView jaf_cutOptionalFillet:self.newsTipsView byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(4, 4)];
    }
}


// MARK: Lazy loading
-(UIImageView *)titleIcon{
    if (!_titleIcon) {
        _titleIcon = [UIImageView new];
        [self addSubview:_titleIcon];
    }
    return _titleIcon;
}
-(UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.font = FONT_MEDIUM(15);
        _titleLbl.textColor = [UIColor colorWithHexString:@"0x000000"];
        [self addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = kLineColor;
        [self addSubview:_lineView];
    }
    return _lineView;
}

-(UIImageView *)arrowIcon{
    if (!_arrowIcon) {
        _arrowIcon = [UIImageView new];
        [self addSubview:_arrowIcon];
        
        [_arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-KNormalSpace);
            make.top.mas_equalTo(13);
            make.width.height.mas_equalTo(32);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _arrowIcon;
}

- (UIView *)newsTipsView {
    if (!_newsTipsView) {
        _newsTipsView = [UIView new];
        [self addSubview:_newsTipsView];
        _newsTipsView.backgroundColor = KRedColor;
        _newsTipsView.hidden = YES;
    }
    return _newsTipsView;
}
@end
