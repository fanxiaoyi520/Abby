//
//  ABSettingCell.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/9.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABSettingCell.h"

@interface ABSettingCell()
// MARK: app
@property (nonatomic ,strong)UILabel *a_titleLab;
@property (nonatomic ,strong)UILabel *a_versionLab;
@property (nonatomic ,strong)UIView *a_tipsView;
@property (nonatomic ,strong)UIImageView *a_arrowImgView;
@property (nonatomic ,strong)UISwitch *a_notiSwith;
@end
@implementation ABSettingCell


- (void)layoutAndLoadData:(id)info isApp:(BOOL)isApp myIndexPath:(NSIndexPath *)myIndexPath {
    self.lineView.frame = CGRectMake(24, self.height-.5, kScreenWidth-24*2, .5);
    
    self.a_titleLab.text = (NSString *)info;
    CGFloat a_titleLab_w = [self.a_titleLab.text getWidthWithHeight:29 Font:self.a_titleLab.font];
    self.a_titleLab.frame = CGRectMake(24, 22, a_titleLab_w, 29);
    self.a_titleLab.height = (myIndexPath.section == 0 && isApp) ? 29 : 25;
    self.a_titleLab.top = (self.height-self.a_titleLab.height)/2;
    self.a_titleLab.left = (!isApp&&myIndexPath.section==2) ? (kScreenWidth-a_titleLab_w)/2:24;
    self.a_titleLab.textColor = (!isApp&&((myIndexPath.section==1&&myIndexPath.row==1)||myIndexPath.section==2)) ?[UIColor colorWithHexString:@"0xF72E47"]:[UIColor colorWithHexString:@"0x000000"];
    
    self.a_versionLab.text = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];;
    CGFloat a_versionLab_w = [self.a_versionLab.text getWidthWithHeight:24 Font:self.a_versionLab.font];
    self.a_versionLab.frame = CGRectMake(kScreenWidth-a_versionLab_w-24, 18, a_versionLab_w, 24);
    self.a_versionLab.hidden = ((!isApp && myIndexPath.section==0&&myIndexPath.row==0)||(isApp&&myIndexPath.section==1&&myIndexPath.row==0)) ? NO:YES;
    
    self.a_tipsView.frame = CGRectMake(kScreenWidth-8-43, (self.height-8)/2, 8, 8);
    [UIView jaf_cutOptionalFillet:self.a_tipsView byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(4, 4)];
    self.a_tipsView.hidden = ((!isApp && myIndexPath.section==0&&myIndexPath.row==1)||(isApp&&myIndexPath.section==1&&myIndexPath.row==1)) ? NO:YES;
    
    self.a_arrowImgView.image = ImageName(@"Table_con_more _1");
    self.a_arrowImgView.frame = CGRectMake(kScreenWidth-32-24, (self.height-32)/2, 32, 32);
    self.a_arrowImgView.hidden = ((!isApp &&( (myIndexPath.section==0&&myIndexPath.row==1)||myIndexPath.section==1))||(isApp&&myIndexPath.section==1&&myIndexPath.row==1)) ? NO:YES;
    
    self.a_notiSwith.frame = CGRectMake(kScreenWidth-52-24, (self.height-32)/2, 52, 32);
    self.a_notiSwith.hidden = (isApp&&myIndexPath.section==0) ? NO : YES;
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

- (UILabel *)a_titleLab {
    if (!_a_titleLab) {
        _a_titleLab = [UILabel new];
        _a_titleLab.font = FONT_MEDIUM(15);
        _a_titleLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        [self addSubview:_a_titleLab];
    }
    return _a_titleLab;
}

- (UILabel *)a_versionLab {
    if (!_a_versionLab) {
        _a_versionLab = [UILabel new];
        _a_versionLab.font = FONT_MEDIUM(15);
        _a_versionLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        [self addSubview:_a_versionLab];
    }
    return _a_versionLab;
}

- (UIView *)a_tipsView {
    if (!_a_tipsView) {
        _a_tipsView = [UIView new];
        _a_tipsView.backgroundColor = [UIColor colorWithHexString:@"0xF72E47"];
        [self addSubview:_a_tipsView];
        _a_tipsView.hidden = YES;
    }
    return _a_tipsView;
}

- (UIImageView *)a_arrowImgView {
    if (!_a_arrowImgView) {
        _a_arrowImgView = [UIImageView new];
        [self addSubview:_a_arrowImgView];
        _a_arrowImgView.hidden = YES;
    }
    return _a_arrowImgView;
}

- (UISwitch *)a_notiSwith {
    if (!_a_notiSwith) {
        _a_notiSwith = [UISwitch new];
        [self addSubview:_a_notiSwith];
        _a_notiSwith.hidden = YES;
    }
    return _a_notiSwith;
}
@end
