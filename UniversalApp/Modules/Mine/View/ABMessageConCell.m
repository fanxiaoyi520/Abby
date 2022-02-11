//
//  ABMessageConCell.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/24.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABMessageConCell.h"

@interface ABMessageConCell ()

@property (nonatomic ,strong) UIImageView *headImgView;
@property (nonatomic ,strong) UIImageView *conBgView;
@property (nonatomic ,strong) UILabel *contentLab;
@property (nonatomic ,strong) UILabel *timeLab;
@end
@implementation ABMessageConCell


- (void)setModel:(ABMessageConModel *)model {
    _model = model;
    
    self.headImgView.frame = CGRectMake(15, 20, 36, 36);
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:Default_Avatar];
    
    self.contentLab.text = @"In order to improve the efficiency of the consultation, please upload the necessary pictures and write instructions first.";
    CGFloat con_W = [_contentLab.text getWidthWithHeight:self.contentLab.font.lineHeight Font:self.contentLab.font];
    if (con_W < kScreenWidth-51-16-6) {
        self.conBgView.frame = CGRectMake(51+6, 20, con_W+24, self.contentLab.font.lineHeight+20);
        self.contentLab.frame = CGRectMake(12, 12, con_W, self.contentLab.font.lineHeight);
    } else {
        CGRect contentLabRect = [_contentLab.text boundingRectWithSize:CGSizeMake(kScreenWidth-51-16-24-6, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.contentLab.font} context:nil];
        self.contentLab.height = contentLabRect.size.height;
        _conBgView.frame = CGRectMake(51+6, 20, contentLabRect.size.width+24, contentLabRect.size.height+20);
        self.contentLab.frame = CGRectMake(12, 12, contentLabRect.size.width, contentLabRect.size.height);
    }
    
    self.timeLab.text = @"10:28  10/25  2021";
    self.timeLab.frame= CGRectMake(0, self.conBgView.bottom+20, kScreenWidth, 16);
}

// MARK: Lazy loading
- (UIImageView *)headImgView {
    if (!_headImgView) {
        _headImgView = UIImageView.new;
        [self.contentView addSubview:_headImgView];
    }
    return _headImgView;
}

- (UIImageView *)conBgView {
    if (!_conBgView) {
        _conBgView = UIImageView.new;
        [self.contentView addSubview:_conBgView];
        _conBgView.image = ImageName(@"Rectangle_bg_126");
        
    }
    return _conBgView;
}

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = UILabel.new;
        [self.conBgView addSubview:_contentLab];
        _contentLab.font = FONT_REGULAR(13);
        _contentLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = UILabel.new;
        [self.contentView addSubview:_timeLab];
        _timeLab.font = FONT_MEDIUM(12);
        _timeLab.textColor = [UIColor colorWithHexString:@"0xC9C9C9"];
        _timeLab.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLab;
}
@end
