//
//  ABUnlockLoopCell.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/14.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABUnlockLoopCell.h"

@interface ABUnlockLoopCell ()

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIImageView *conImageView;
@property (nonatomic ,strong) UIButton *selBtn;
@property (nonatomic ,strong) UILabel *selBtnLab;
@property (nonatomic ,strong) UIImageView *selBtnImgView;
@end
@implementation ABUnlockLoopCell

- (void)setModel:(ABUnlockLoopModel *)model {
    _model = model;
    
    CGRect titleLabRect = [model.title boundingRectWithSize:CGSizeMake(kScreenWidth-24*2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:FONT_MEDIUM(15)} context:nil];
    self.titleLab.text = model.title;
    self.titleLab.height = titleLabRect.size.height;
    
    self.conImageView.backgroundColor = KRedColor;
    self.conImageView.frame = CGRectMake(24, self.titleLab.bottom+16, kScreenWidth-24*2, ratioH(180));
    [self.conImageView addRoundedCorners:UIRectCornerAllCorners withRadii:CGSizeMake(10, 10)];
    
    self.selBtn.frame = CGRectMake(24, self.conImageView.bottom+16, kScreenWidth-24*2, 50);
    [self.selBtn addRoundedCorners:UIRectCornerAllCorners withRadii:CGSizeMake(5, 5)];
    
    self.selBtnLab.frame = CGRectMake(16, (self.selBtn.height-22)/2, self.selBtn.width-16-68, 22);
    self.selBtnImgView.frame = CGRectMake(self.selBtn.width-16-28, (self.selBtn.height-28)/2, 28, 28);
}

// MARK: actions
- (void)selBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.selBtnImgView.image = sender.selected ? ImageName(@"Controls Small_Checkboxes_Ok_1") : ImageName(@"Controls Small_Checkboxes_Ok");
    
    if ([self.delegate respondsToSelector:@selector(unlockLoopCell_selFuncAction:)]) {
        [self.delegate unlockLoopCell_selFuncAction:sender];
    }
}

// MARK: Lazy loading
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = UILabel.new;
        [self.contentView addSubview:_titleLab];
        _titleLab.font = FONT_REGULAR(15);
        _titleLab.textColor = [UIColor colorWithHexString:@"0x161B19"];
        _titleLab.numberOfLines = 0;
        _titleLab.frame = CGRectMake(24, 0, kScreenWidth-24*2, 0);
    }
    return _titleLab;
}

- (UIImageView *)conImageView {
    if (!_conImageView) {
        _conImageView = UIImageView.new;
        [self.contentView addSubview:_conImageView];
    }
    return _conImageView;
}

- (UIButton *)selBtn {
    if (!_selBtn) {
        _selBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_selBtn];
        [_selBtn addTarget:self action:@selector(selBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _selBtn.backgroundColor = KWhiteColor;
        _selBtn.selected = NO;
    }
    return _selBtn;
}

- (UILabel *)selBtnLab {
    if (!_selBtnLab) {
        _selBtnLab = UILabel.new;
        _selBtnLab.font = FONT_MEDIUM(15);
        _selBtnLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        _selBtnLab.text = @"Satisfy this condition";
        [self.selBtn addSubview:_selBtnLab];
    }
    return _selBtnLab;
}

- (UIImageView *)selBtnImgView {
    if (!_selBtnImgView) {
        _selBtnImgView = UIImageView.new;
        [self.selBtn addSubview:_selBtnImgView];
        self.selBtnImgView.image = ImageName(@"Controls Small_Checkboxes_Ok");
    }
    return _selBtnImgView;
}
@end
