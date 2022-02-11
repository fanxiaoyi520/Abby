//
//  WaterFallCollectionViewCell.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/6/22.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "WaterFallCollectionViewCell.h"

@interface WaterFallCollectionViewCell()

@property(nonatomic,strong) UIImageView *photoImgView;
@property(nonatomic,strong) UILabel *titleLab;
@property(nonatomic,strong) UIView *lineView;
@end

@implementation WaterFallCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

//MARK: ————— 初始化页面 —————
-(void)setupUI{

    self.photoImgView.frame = CGRectMake((self.width-50*self.width/130)-16, (self.height-50*self.width/130)-16, 50*self.width/130, 50*self.width/130);
    self.titleLab.frame = CGRectMake(16, 16, self.width-16*2, 0);
    self.lineView.frame = CGRectMake(16, self.titleLab.bottom+8, 60, 2);
}

//MARK: ————— 数据渲染页面 —————
- (void)setModel:(ABHelpAndFBModel *)model {
    _model = model;
    
    [self.photoImgView setImage:ImageName(model.imageName)];
    self.titleLab.text = model.title;
    CGRect titleLabRect = [self.titleLab.text boundingRectWithSize:CGSizeMake(self.width-16*2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.titleLab.font} context:nil];
    [ABUtils setTextColorAndFont:self.titleLab str:model.title textArray:@[model.title] colorArray:@[[UIColor colorWithHexString:@"0xFFFFFF"]] fontArray:@[self.titleLab.font]];
    self.titleLab.height = titleLabRect.size.height;
    [self.titleLab sizeToFit];
    
    self.lineView.top = self.titleLab.bottom+8;
}


//MARK: ————— 控件 懒加载 —————
-(UIImageView *)photoImgView{
    if (!_photoImgView) {
        _photoImgView = [UIImageView new];
        _photoImgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_photoImgView];
    }
    return _photoImgView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = FONT_BOLD(12);
        _titleLab.textColor = [UIColor colorWithHexString:@"0xFFFFFF"];
        _titleLab.numberOfLines = 0;
        [self addSubview:_titleLab];
    }
    return _titleLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"0xFFFFFF"];
        [self addSubview:_lineView];
    }
    return _lineView;
}
@end
