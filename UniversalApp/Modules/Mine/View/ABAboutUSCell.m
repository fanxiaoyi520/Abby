//
//  ABAboutUSCell.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/13.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABAboutUSCell.h"

@interface ABAboutUSCell()

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIImageView *arrowImgView;
@end
@implementation ABAboutUSCell

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    
    self.lineView.frame = CGRectMake(24, self.height-.5, kScreenWidth-24*2, .5);
    
    self.titleLab.text = titleStr;
    CGFloat titleLab_w = [self.titleLab.text getWidthWithHeight:25 Font:self.titleLab.font];
    self.titleLab.frame = CGRectMake(24, (self.height-25)/2, titleLab_w, 25);
    
    self.arrowImgView.image = ImageName(@"Table_con_more _1");
    self.arrowImgView.frame = CGRectMake(kScreenWidth-32-24, (self.height-32)/2, 32, 32);
}

// MARK: Lazy loading
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = kLineColor;
        [self addSubview:_lineView];
    }
    return _lineView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = FONT_MEDIUM(15);
        _titleLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        [self addSubview:_titleLab];
    }
    return _titleLab;
}

- (UIImageView *)arrowImgView {
    if (!_arrowImgView) {
        _arrowImgView = [UIImageView new];
        [self addSubview:_arrowImgView];
    }
    return _arrowImgView;
}
@end
