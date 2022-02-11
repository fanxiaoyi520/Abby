//
//  ABFuncView.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/17.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABFuncView.h"
@interface ABFuncView ()

@end
@implementation ABFuncView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 19;
        self.backgroundColor = KWhiteColor;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    NSArray *funcArr = @[@"icon_h_week",@"icon_h_o2",@"icon_h_Status"];
    NSArray *funcTitleArr = @[@"Week",@"Oxygen",@"Status"];
    NSArray *dataArr = @[@"0/7",@"0",@"Health"];
    NSDictionary *dic = @{
        @"imageStr":funcArr,
        @"title":funcTitleArr,
        @"data":dataArr,
    };
    NSMutableArray *btns = [NSMutableArray array];
    [funcArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 100+idx;
        [self addSubview:btn];
        [btns addObject:btn];
        [self layoutbgBtnSubViews:btn idx:idx conDic:dic];
        [btn addTarget:self action:@selector(weekAction:) forControlEvents:UIControlEventTouchUpInside];
    }];
    [btns mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:0 tailSpacing:0];
    [btns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.equalTo(ratioH(84));
    }];

    NSArray *lineArr = @[@"占位1",@"占位2"];
    NSMutableArray *linesArr = [NSMutableArray array];
    [lineArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *lineView = [UIView new];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        [linesArr addObject:lineView];
    }];
    [linesArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:ratioW(343/3)+2 leadSpacing:ratioW(343/3) tailSpacing:ratioW(343/3)];
    [linesArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.mas_equalTo(40);
        make.height.mas_equalTo(25);
    }];
}

- (void)layoutbgBtnSubViews:(UIButton *)btn idx:(NSInteger)idx conDic:(NSDictionary *)dic {
    UIImageView *imgView = [UIImageView new];
    NSArray *fArr = [dic objectForKey:@"imageStr"];
    imgView.image = ImageName(fArr[idx]);
    [btn addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ratioW(24));
        make.top.equalTo(ratioH(32));
        make.width.height.equalTo(ratioW(20));
    }];
    
    UILabel *lab = [UILabel new];
    NSArray *lArr = dic[@"title"];
    [btn addSubview:lab];
    lab.font = FONT_BOLD(12);
    lab.textColor = [UIColor colorWithHexString:@"0x006241"];
    lab.text = lArr[idx];
    CGFloat l_labw = [lab.text getWidthWithHeight:16 Font:lab.font];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imgView.mas_right).offset(4);
        make.centerY.mas_equalTo(imgView.mas_centerY);
        make.width.equalTo(l_labw);
        make.height.equalTo(16);
    }];
    
    UIImageView *arrowImgView = [UIImageView new];
    [btn addSubview:arrowImgView];
    arrowImgView.image = ImageName(@"icon_h_j");
    [arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab.mas_right).offset(4);
        make.centerY.mas_equalTo(imgView.mas_centerY);
        make.width.equalTo(8);
        make.height.equalTo(13);
    }];
    
    UILabel *dataLab = [UILabel new];
    NSArray *dArr = dic[@"data"];
    [btn addSubview:dataLab];
    dataLab.font = FONT_BOLD(17);
    dataLab.textColor = [UIColor colorWithHexString:@"0x006241"];
    if (idx==0) dataLab.text = [NSString stringWithFormat:@"%@ Day",dArr[idx]];
    if (idx==1) dataLab.text = [NSString stringWithFormat:@"%@ g",dArr[idx]];
    if (idx==2) dataLab.text = dArr[idx];
    CGFloat data_w = [dataLab.text getWidthWithHeight:20 Font:dataLab.font];
    [dataLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ratioW(24));
        make.top.mas_equalTo(imgView.mas_bottom).offset(ratioH(5));
        make.width.equalTo(data_w);
        make.height.equalTo(20);
    }];
}

// MARK: actions
- (void)weekAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(mainHome_weekAction:)]) {
        [self.delegate mainHome_weekAction:sender];
    }
}

// MARK: public
- (void)oxygenCollection:(UITapGestureRecognizer *)tap {
    [UIView animateWithDuration:1 animations:^{
        tap.view.center = CGPointMake(tap.view.superview.centerX, tap.view.superview.bottom);
    } completion:^(BOOL finished) {
        tap.view.hidden = YES;
    }];
}
@end
