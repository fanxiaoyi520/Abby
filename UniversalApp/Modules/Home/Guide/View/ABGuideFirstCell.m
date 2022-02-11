//
//  ABGuideFirstCell.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/27.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABGuideFirstCell.h"

@interface ABGuideFirstCell ()

@property (nonatomic ,strong) UIButton *bgView;
@property (nonatomic ,strong) UILabel *contentLab;
@property (nonatomic ,strong) UIImageView *selImgView;
@end
@implementation ABGuideFirstCell

- (void)updateSelStatus:(BOOL)isSel {
    self.selImgView.image = isSel ? ImageName(@"Controls Small_Checkboxes_Ok_1") : ImageName(@"Controls Small_Checkboxes_Ok");
}

- (void)setModel:(ABGuideFirstModel *)model {
    _model = model;
    
    CGRect conRect = [model.content boundingRectWithSize:CGSizeMake(kScreenWidth-26*2-16-60, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.contentLab.font} context:nil];
        
    self.bgView.height = conRect.size.height+16+22;
    ViewRadius(self.bgView, 5);
     
    self.contentLab.text = model.content;
    self.contentLab.height = conRect.size.height;
    
    self.selImgView.image = ImageName(@"Controls Small_Checkboxes_Ok");
}

// MARK: actions
- (void)bgViewAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.selImgView.image = sender.selected ? ImageName(@"Controls Small_Checkboxes_Ok_1") : ImageName(@"Controls Small_Checkboxes_Ok");
    if ([self.delegate respondsToSelector:@selector(guideFirstAction:)]) {
        [self.delegate guideFirstAction:sender];
    }
}

// MARK: Lazy loading
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = UIButton.new;
        _bgView.backgroundColor = [UIColor colorWithHexString:@"0xF7F7F7"];
        [self.contentView addSubview:self.bgView];
        _bgView.frame = CGRectMake(24, 0, kScreenWidth-24*2, 0);
        [_bgView addTarget:self action:@selector(bgViewAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgView;
}

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = UILabel.new;
        _contentLab.font = FONT_BOLD(16);
        _contentLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        [self.bgView addSubview:self.contentLab];
        _contentLab.frame = CGRectMake(16, 16, self.bgView.width-16-60, 0);
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
}

- (UIImageView *)selImgView {
    if (!_selImgView) {
        _selImgView = UIImageView.new;
        [self.bgView addSubview:self.selImgView];
        _selImgView.frame = CGRectMake(self.bgView.width-28-16, (self.bgView.height-28)/2, 28, 28);
    }
    return _selImgView;
}
@end
