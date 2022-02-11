//
//  ABProfileCell.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/13.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABProfileCell.h"
@interface ABProfileCell()

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIImageView *arrowImgView;
@property (nonatomic ,strong) UIImageView *headImgView;
@property (nonatomic ,strong) UILabel *nickNameLab;
@property (nonatomic ,strong) UILabel *abbyid;

@end
@implementation ABProfileCell

- (void)setModel:(ABProfileModel *)model withTitleStr:(NSString *)titleStr withIndexPath:(NSIndexPath *)myIndexPath {

    self.lineView.frame = CGRectMake(24, self.height-.5, kScreenWidth-24*2, .5);
    
    self.titleLab.text = titleStr;
    CGFloat titleLab_w = [self.titleLab.text getWidthWithHeight:25 Font:self.titleLab.font];
    self.titleLab.frame = CGRectMake(24, (self.height-25)/2, titleLab_w, 25);
    
    self.arrowImgView.image = ImageName(@"Table_con_more _1");
    self.arrowImgView.frame = CGRectMake(kScreenWidth-32-24, (self.height-32)/2, 32, 32);
    self.arrowImgView.hidden = (myIndexPath.section==1 || (myIndexPath.section==0&&myIndexPath.row==2)) ? YES : NO;
    
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:model.imageName] placeholderImage:Default_Avatar];
    self.headImgView.frame = CGRectMake(kScreenWidth-43-48, (self.height-43)/2, 43, 43);
    [UIView jaf_cutOptionalFillet:self.headImgView byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(43/2, 43/2)];
    self.headImgView.hidden = (myIndexPath.section==0&&myIndexPath.row==0) ? NO : YES;
    
    self.nickNameLab.text = model.nickName;
    CGFloat nickNameLab_w = [self.nickNameLab.text getWidthWithHeight:25 Font:self.nickNameLab.font];
    self.nickNameLab.frame = CGRectMake(kScreenWidth-nickNameLab_w-48, (self.height-25)/2, nickNameLab_w, 25);
    self.nickNameLab.hidden = (myIndexPath.section==0&&myIndexPath.row==1) ? NO : YES;
    
    self.abbyid.text = model.abbyId;
    CGFloat abbyid_w = [self.abbyid.text getWidthWithHeight:25 Font:self.nickNameLab.font];
    self.abbyid.frame = CGRectMake(kScreenWidth-abbyid_w-48, (self.height-25)/2, abbyid_w, 25);
    self.abbyid.hidden = (myIndexPath.section==0&&myIndexPath.row==2) ? NO : YES;
    
    if (myIndexPath.section==1) {
        self.titleLab.textColor = [UIColor colorWithHexString:@"0xF72E47"];
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        self.titleLab.left = (kScreenWidth-titleLab_w)/2;
    } else {
        self.titleLab.textColor = [UIColor colorWithHexString:@"0x000000"];
    }
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

- (UIImageView *)headImgView {
    if (!_headImgView) {
        _headImgView = [UIImageView new];
        [self addSubview:_headImgView];
        _headImgView.hidden = NO;
        _headImgView.userInteractionEnabled = YES;
    }
    return _headImgView;
}

- (UILabel *)nickNameLab {
    if (!_nickNameLab) {
        _nickNameLab = [UILabel new];
        _nickNameLab.font = FONT_MEDIUM(15);
        _nickNameLab.textColor = [UIColor colorWithHexString:@"0xC8C8C8"];
        [self addSubview:_nickNameLab];
        _nickNameLab.hidden = NO;
    }
    return _nickNameLab;
}

- (UILabel *)abbyid {
    if (!_abbyid) {
        _abbyid = [UILabel new];
        _abbyid.font = FONT_MEDIUM(15);
        _abbyid.textColor = [UIColor colorWithHexString:@"0xC8C8C8"];
        [self addSubview:_abbyid];
        _abbyid.hidden = NO;
    }
    return _abbyid;
}
@end

