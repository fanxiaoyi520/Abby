//
//  ABPopBgView.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/30.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABPopBgView.h"

@interface ABPopBgView()
@property (nonatomic ,assign) ABPopType popType;

//ABReport & ABDelete
@property (nonatomic ,assign) UIButton *bgBtn;
@property (nonatomic ,assign) UILabel *titleLab;
@property (nonatomic ,assign) UIImageView *logoImgView;

//ABDeleteAndSync

@end
@implementation ABPopBgView

+ (ABPopBgView *)loadPopBgViewWith:(ABPopType)popType {
    return [[ABPopBgView alloc] initWithFrame:CGRectZero withPopType:popType];
}

- (instancetype)initWithFrame:(CGRect)frame withPopType:(ABPopType)popType {
    self = [super initWithFrame:frame];
    if (self) {
        _popType = popType;
        
        switch (_popType) {
            case ABReport:
                [self loadABReport];
                break;
            case ABDelete:
                [self loadABDelete];
                break;
            case ABDeleteAndSync:
                [self loadABDeleteAndSync];
                break;
            default:
                [self loadABReport];
                break;
        }
    }
    return self;
}

- (void)layoutSubviews {
    [self updateSubViews];
}

- (void)updateSubViews {
    if (_popType == ABReport) {
        self.bgBtn.frame = self.frame;
        CGFloat titleW = [self.titleLab.text getWidthWithHeight:16 Font:self.titleLab.font];
        self.titleLab.frame = CGRectMake(15, (self.bgBtn.height-16)/2, titleW, 16);
        self.logoImgView.frame = CGRectMake(self.bgBtn.width-20-12, (self.bgBtn.height-20)/2, 20, 20);
        
    } else if (_popType == ABDelete) {

        self.bgBtn.frame = self.frame;
        CGFloat titleW = [self.titleLab.text getWidthWithHeight:16 Font:self.titleLab.font];
        self.titleLab.frame = CGRectMake(15, (self.bgBtn.height-16)/2, titleW, 16);
        self.logoImgView.frame = CGRectMake(self.bgBtn.width-20-12, (self.bgBtn.height-20)/2, 20, 20);
    } else if (_popType == ABDeleteAndSync) {
        UIButton *btn1 = [self viewWithTag:100];
        btn1.frame = CGRectMake(0, 0, self.width, self.height/2);
        UIButton *btn2 = [self viewWithTag:101];
        btn2.frame = CGRectMake(0, self.height/2, self.width, self.height/2);
        
        UIView *lineView = [self viewWithTag:500];
        lineView.frame = CGRectMake(16, self.height/2, self.width-16*2, 1);

        UIImageView *delImgView = [self viewWithTag:300];
        delImgView.frame = CGRectMake(btn1.width-20-16, (btn1.height-20)/2, 20, 20);
        
        UISwitch *sh = [self viewWithTag:400];
        sh.transform = CGAffineTransformMakeScale( 0.5, 0.5);//缩放
        sh.frame = CGRectMake(btn2.width-sh.width-16, (btn1.height-sh.height)/2, sh.width, sh.height);
        
        UILabel *lab = [btn1 viewWithTag:200];
        CGFloat lab1W = [lab.text getWidthWithHeight:16 Font:lab.font];
        lab.frame = CGRectMake(15, (btn1.height-16)/2, lab1W, 16);
        
        UILabel *lab2 = [btn2 viewWithTag:200];
        CGFloat lab2W = [lab2.text getWidthWithHeight:16 Font:lab2.font];
        lab2.frame = CGRectMake(15, (btn2.height-16)/2, lab2W, 16);

    }
}

- (void)loadABReport {
    UIButton *btn = UIButton.new;
    [self addSubview:btn];
    [btn addTarget:self action:@selector(reportAction:) forControlEvents:UIControlEventTouchUpInside];
    self.bgBtn = btn;
    
    UILabel *lab = UILabel.new;
    [btn addSubview:lab];
    lab.font = FONT_BOLD(12);
    lab.textColor = [UIColor colorWithHexString:@"0x000000"];
    self.titleLab = lab;
    lab.text = @"Report";
    
    UIImageView *imageView = UIImageView.new;
    [self addSubview:imageView];
    self.logoImgView = imageView;
    imageView.image = ImageName(@"icon_t_tips");
}

- (void)loadABDelete {
    UIButton *btn = UIButton.new;
    [self addSubview:btn];
    [btn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    self.bgBtn = btn;
    
    UILabel *lab = UILabel.new;
    [btn addSubview:lab];
    lab.font = FONT_BOLD(12);
    lab.textColor = [UIColor colorWithHexString:@"0x000000"];
    self.titleLab = lab;
    lab.text = @"Delete";
    
    UIImageView *imageView = UIImageView.new;
    [self addSubview:imageView];
    self.logoImgView = imageView;
    imageView.image = ImageName(@"icon_20_dl");
}

- (void)loadABDeleteAndSync {
    NSArray *array = @[@"Delete",@"Sync to trend"];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = UIButton.new;
        [self addSubview:btn];
        btn.tag = 100+idx;
        
        UILabel *lab = UILabel.new;
        lab.font = FONT_BOLD(12);
        lab.textColor = [UIColor colorWithHexString:@"0x000000"];
        [btn addSubview:lab];
        lab.text = array[idx];
        lab.tag = 200;
        
        UIImageView *imageView = UIImageView.new;
        if (idx == 0) [btn addSubview:imageView];
        imageView.image = ImageName(@"icon_20_dl");
        imageView.tag = 300;
        
        UISwitch *sh = UISwitch.new;
        sh.onTintColor = [UIColor colorWithHexString:@"0x026040"];
        if (idx == 1) [btn addSubview:sh];
        [sh setOn:YES];
        [sh addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
        sh.tag = 400;
        
        UIView *lineView = UIView.new;
        [self addSubview:lineView];
        lineView.backgroundColor = kLineColor;
        lineView.tag = 500;
    }];
}

// MARK: actions
- (void)reportAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(popBg_reportAction:)]) {
        [self.delegate popBg_reportAction:sender];
    }
}

- (void)deleteAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(popBg_delegeAction:)]) {
        [self.delegate popBg_delegeAction:sender];
    }
}

- (void)switchAction:(UISwitch *)sender {
    if ([self.delegate respondsToSelector:@selector(popBg_syncAndTrendAction:)]) {
        [self.delegate popBg_syncAndTrendAction:sender];
    }
}


@end

