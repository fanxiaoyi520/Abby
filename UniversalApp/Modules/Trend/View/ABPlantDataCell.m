//
//  ABPlantDataCell.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/30.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABPlantDataCell.h"

@interface ABPlantDataCell()
@property (nonatomic ,strong) UIImageView *pImgView;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *detailLab;
@end
@implementation ABPlantDataCell

// MARK: data
- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    
    self.pImgView.image = ImageName([dic objectForKey:@"imageName"]);
    self.pImgView.frame = CGRectMake(self.pImgView.left, (self.height-self.pImgView.image.size.height)/2, self.pImgView.image.size.width, self.pImgView.image.size.height);
    
    self.titleLab.text = [dic objectForKey:@"title"];
    CGFloat titleW = [self.titleLab.text getWidthWithHeight:self.titleLab.height Font:self.titleLab.font];
    self.titleLab.width = titleW;
    
    self.detailLab.text = [dic objectForKey:@"detail"];
    CGFloat detailW = [self.detailLab.text getWidthWithHeight:self.detailLab.height Font:self.detailLab.font];
    self.detailLab.left = self.width - detailW - 14;
    self.detailLab.width = detailW;
    
    self.lineView.frame = CGRectMake(16, self.height-1, self.width-16*2, 1);
}

// MARK: Lazy loading
- (UIImageView *)pImgView {
    if (!_pImgView) {
        _pImgView = UIImageView.new;
        [self.contentView addSubview:_pImgView];
        _pImgView.frame = CGRectMake(21, (self.height - ratioH(18))/2, ratioW(10), ratioH(18));
    }
    return _pImgView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.font = FONT_REGULAR(13);
        _titleLab.textColor = [UIColor colorWithHexString:@"0x161B19"];
        [self.contentView addSubview:_titleLab];
        _titleLab.frame = CGRectMake(43, (self.height-ratioH(17))/2, 0, ratioH(17));
    }
    return _titleLab;
}

- (UILabel *)detailLab {
    if (!_detailLab) {
        _detailLab = UILabel.new;
        _detailLab.font = FONT_REGULAR(13);
        _detailLab.textColor = [UIColor colorWithHexString:@"0x161B19"];
        [self.contentView addSubview:_detailLab];
        _detailLab.frame = CGRectMake(0, (self.height-ratioH(17))/2, 0, ratioH(17));
    }
    return _detailLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = UIView.new;
        _lineView.backgroundColor = kLineColor;
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
    
}
@end
