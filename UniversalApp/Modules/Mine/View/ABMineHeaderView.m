//
//  ABMineHeaderView.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/2.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABMineHeaderView.h"

@interface ABMineHeaderView()
@property(nonatomic, strong) UIImageView *bgImgView; //背景图
@property(nonatomic, strong) UIButton *bgBtn; //背景btn
@property(nonatomic, strong) UILabel *nameLab;
@property(nonatomic, strong) UILabel *emailLab;
@property(nonatomic, strong) UIImageView *arrow_imgView;
@end

@implementation ABMineHeaderView
-(void)setModel:(ABMineServerModel *)model{
    _model = model;
    
    UIImage *bgImg = [UIImage imageNamed:@"mine_header_pic_1"];
    [self.bgImgView setImage:bgImg];
    self.bgImgView.frame = self.frame;
    self.bgImgView.top=0;
    
    self.bgBtn.frame = CGRectMake(0, 111, kScreenWidth, 67);
    
    self.headImgView.frame = CGRectMake(22, 0, 67, 67);
    [UIView jaf_cutOptionalFillet:self.headImgView byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(67/2, 67/2)];
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:model.avatarPicture] placeholderImage:Default_Avatar];

    self.nameLab.text = ValidStr(model.nickName) ? model.nickName: @"";
    self.nameLab.frame = CGRectMake(self.headImgView.right+18, 9, kScreenWidth-107-24+32, 28);
    
    self.emailLab.text = ValidStr(model.email) ? model.email: @"";
    self.emailLab.frame = CGRectMake(self.headImgView.right+18, self.nameLab.bottom, kScreenWidth-107-24+32, 18);
    
    self.arrow_imgView.image = ImageName(@"Table_icon_more_3");
    self.arrow_imgView.frame = CGRectMake(kScreenWidth-32-24, (self.bgBtn.height-32)/2, 32, 32);
}

// MARK: actions
-(void)headViewClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerViewClick)]) {
        [self.delegate headerViewClick];
    }
}

-(void)headerOrNameHandler {
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerViewClick)]) {
        [self.delegate headerViewClick];
    }
}

// MARK: Lazy loading
-(UIImageView *)bgImgView{
    if (!_bgImgView) {
        _bgImgView = [UIImageView new];
        [self addSubview:_bgImgView];
    }
    return _bgImgView;
}

- (UIButton *)bgBtn {
    if (!_bgBtn) {
        _bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_bgBtn];
        [_bgBtn addTarget:self action:@selector(headerOrNameHandler) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgBtn;
}

-(UIImageView *)headImgView{
    if (!_headImgView) {
        _headImgView = [UIImageView new];
        _headImgView.contentMode = UIViewContentModeScaleAspectFill;
        _headImgView.userInteractionEnabled = YES;
        [_headImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewClick)]];
        [self.bgBtn addSubview:_headImgView];
    }
    return _headImgView;
}

- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [UILabel new];
        _nameLab.font = FONT_MEDIUM(18);
        _nameLab.textColor = [UIColor colorWithHexString:@"0xFFFFFF"];
        [self.bgBtn addSubview:_nameLab];
    }
    return _nameLab;
}

- (UILabel *)emailLab {
    if (!_emailLab) {
        _emailLab = [UILabel new];
        _emailLab.font = FONT_MEDIUM(12);
        _emailLab.textColor = [UIColor colorWithHexString:@"0xFFFFFF"];
        [self.bgBtn addSubview:_emailLab];
    }
    return _emailLab;
}

- (UIImageView *)arrow_imgView {
    if (!_arrow_imgView) {
        _arrow_imgView = [UIImageView new];
        [self.bgBtn addSubview:_arrow_imgView];
    }
    return _arrow_imgView;
}
@end
