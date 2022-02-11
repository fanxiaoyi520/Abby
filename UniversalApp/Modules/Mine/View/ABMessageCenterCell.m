//
//  ABMessageCenterCell.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/9.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABMessageCenterCell.h"

@interface ABMessageCenterCell()

@property (nonatomic ,strong) UIImageView *headerImgView;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *contentLab;
@property (nonatomic ,strong) UILabel *timeLab;
@property (nonatomic ,strong) UIImageView *arrowImgView;

@end

@implementation ABMessageCenterCell

- (void)setCellModel:(ABMessageCenterModel *)cellModel {
    _cellModel = cellModel;
    
    self.lineView.frame = CGRectMake(83, 93.5, kScreenWidth-83-24, .5);
    
    self.newsTipsView.frame = CGRectMake(9, 34, 8, 8);
    [UIView jaf_cutOptionalFillet:self.newsTipsView byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(4, 4)];
    
    [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:Default_Avatar];
    self.headerImgView.frame = CGRectMake(26, 15, 45, 45);
    [UIView jaf_cutOptionalFillet:self.headerImgView byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(45/2, 45/2)];
    
    self.titleLab.text = cellModel.title;
    CGFloat titleLab_w = [self.titleLab.text getWidthWithHeight:22 Font:self.titleLab.font];
    self.titleLab.frame = CGRectMake(self.headerImgView.right+12, 16, titleLab_w, 22);
    
    self.contentLab.text = cellModel.content;
    CGRect contentLabRect = [self.contentLab.text boundingRectWithSize:CGSizeMake(kScreenWidth-83-15, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:FONT_REGULAR(16)} context:nil];
    self.contentLab.frame = CGRectMake(self.headerImgView.right+12, self.titleLab.bottom+1, contentLabRect.size.width, contentLabRect.size.height);
    [self.contentLab sizeToFit];
    
    self.timeLab.text = cellModel.time;
    CGFloat timeLab_w = [self.timeLab.text getWidthWithHeight:20 Font:self.timeLab.font];
    self.timeLab.frame = CGRectMake(kScreenWidth-timeLab_w-44, 17, timeLab_w, 20);
    
    self.arrowImgView.image = ImageName(@"Controls_Small_Arrow_Fw");
    self.arrowImgView.frame = CGRectMake(self.timeLab.right, 0, 32, 32);
}

// MARK: Lazy loading
- (UIView *)newsTipsView {
    if (!_newsTipsView) {
        _newsTipsView = [UIView new];
        _newsTipsView.backgroundColor = KRedColor;
        _newsTipsView.hidden = YES;
        [self addSubview:_newsTipsView];
    }
    return _newsTipsView;
}

- (UIImageView *)headerImgView {
    if (!_headerImgView) {
        _headerImgView = [UIImageView new];
        [self addSubview:_headerImgView];
    }
    return _headerImgView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = FONT_MEDIUM(17);
        _titleLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        [self addSubview:_titleLab];
    }
    return _titleLab;
}

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [UILabel new];
        _contentLab.font = FONT_REGULAR(16);
        _contentLab.textColor = [UIColor colorWithHexString:@"0xC8C8C8"];
        _contentLab.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLab.numberOfLines = 2;
        [self addSubview:_contentLab];
    }
    return _contentLab;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [UILabel new];
        _timeLab.font = FONT_REGULAR(15);
        _timeLab.textColor = [UIColor colorWithHexString:@"0xC8C8C8"];
        [self addSubview:_timeLab];
    }
    return _timeLab;
}

- (UIImageView *)arrowImgView {
    if (!_arrowImgView) {
        _arrowImgView = [UIImageView new];
        [self addSubview:_arrowImgView];
    }
    return _arrowImgView;
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
