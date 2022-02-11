//
//  ABBotanyView.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/17.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABBotanyView.h"
#import "ABPopView.h"

@interface ABBotanyView ()<ABPopViewDelegate>
@property (nonatomic ,strong) UIImageView *bgImageView;
@property (nonatomic ,strong) UIImageView *plantBaseImgView;
@property (nonatomic ,strong) UIImageView *plantImgView;
@property (nonatomic ,strong) UIView *tipsBgView;
@property (nonatomic ,strong) UIImageView *tipsImgView1;
@property (nonatomic ,strong) UIImageView *tipsImgView2;
@property (nonatomic ,strong) UILabel *tipSplantHeightLab;

@property (nonatomic ,strong) ABPopView  *popView;
@property (nonatomic ,strong) UIView  *animationView;
@property (nonatomic ,strong) UIButton  *customerServiceBtn;
@end
@implementation ABBotanyView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    self.bgImageView.image = ImageName(@"home_botany_bg");
    self.plantBaseImgView.image = ImageName(@"Group 275");
    self.plantImgView.image = ImageName(@"Group 276");
    [self.customerServiceBtn setImage:ImageName(@"icon_h_cs-1") forState:UIControlStateNormal];
    self.tipsBgView.backgroundColor = [UIColor clearColor];
    self.tipsImgView1.image = ImageName(@"pic_cicic");
    self.tipsImgView2.image = ImageName(@"pic_jiantou");
    self.tipSplantHeightLab.text = [NSString stringWithFormat:@"%dmm",66];
    
    [self createAnimaition];
    
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    shake.fromValue = [NSNumber numberWithFloat:-5];
    shake.toValue = [NSNumber numberWithFloat:5];
    shake.duration = 0.1;//执行时间
    shake.autoreverses = YES; //是否重复
    shake.repeatCount = 2;//次数
    [self.plantImgView.layer addAnimation:shake forKey:@"shakeAnimation"];
    self.plantImgView.alpha = 1.0;
    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{
    } completion:nil];
}

// MARK: privite
- (void)createAnimaition{

    NSArray *array = @[@"20g",@"5g",@"34g",@"20g",@"42g",@"45g",@"90g"];
    NSMutableArray *btns = [NSMutableArray array];
    NSArray *topsArr = @[@(ratioH(120)),@(ratioH(65)),@(ratioH(37)),@(ratioH(27)),@(ratioH(37)),@(ratioH(65)),@(ratioH(120))];
    NSArray *spacingArr = @[@(ratioW(19)),@(ratioW(50)),@(ratioW(98)),@(ratioW(153)),@(ratioW(208)),@(ratioW(256)),@(ratioW(288))];
    NSArray *durationArr = @[@(.5f),@(1.0f),@(1.5f),@(2.0f),@(2.5f),@(3.0f),@(3.5f)];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *animationView = [UIImageView new];
        animationView.image = ImageName(@"home_animation_image");
        [self addSubview:animationView];
        [btns addObject:animationView];
        animationView.userInteractionEnabled = YES;
        animationView.size = CGSizeMake(ratioW(38.35), ratioW(38.35));
        animationView.left = [spacingArr[idx] floatValue];
        animationView.top = [topsArr[idx] floatValue]+ratioH(27);
        [self addAnimationView:animationView durationArr:[durationArr[idx] floatValue]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addAnimationAction:)];
        [animationView addGestureRecognizer:tap];
        
        UILabel *lab = [UILabel new];
        [animationView addSubview:lab];
        lab.font = FONT_BOLD(12);
        lab.textColor = [UIColor colorWithHexString:@"0x006241"];
        lab.text = array[idx];
        lab.frame = CGRectMake(0, (animationView.height-14)/2, animationView.width, 14);
        lab.textAlignment = NSTextAlignmentCenter;
        
        UILabel *lab_b = [UILabel new];
        [animationView addSubview:lab_b];
        lab_b.font = FONT_MEDIUM(12);
        lab_b.textColor = [UIColor colorWithHexString:@"0xFFFFFF"];
        lab_b.text = @"Grow";
        lab_b.frame = CGRectMake(0, animationView.height, animationView.width, 14);
        lab_b.textAlignment = NSTextAlignmentCenter;
    }];
}

- (void)addAnimationView:(UIView *)view durationArr:(CGFloat)duration1 {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    CGFloat duration = 3.0f;
    CGFloat height = 10.f;
    CGFloat currentY = view.transform.ty;
    animation.duration = duration;
    animation.beginTime = duration1;
    animation.removedOnCompletion = NO;
    animation.values = @[@(currentY),@(currentY - height/4),@(currentY - height/4*2),@(currentY - height/4*3),@(currentY - height),@(currentY - height/ 4*3),@(currentY - height/4*2),@(currentY - height/4),@(currentY)];
    animation.keyTimes = @[ @(0), @(0.025), @(0.085), @(0.2), @(0.5), @(0.8), @(0.915), @(0.975), @(1) ];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.repeatCount = HUGE_VALF;
    [view.layer addAnimation:animation forKey:@"kViewShakerAnimationKey"];
}

// MARK: actions
- (void)clickPlantTipsAction:(UITapGestureRecognizer *)tap {
//    self.popView.hidden = NO;
}

- (void)customerServiceBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(mainHone_customerServiceAction:)]) {
        [self.delegate mainHone_customerServiceAction:sender];
    }
}

- (void)addAnimationAction:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(mainHone_OxygenCollectionAction:)]) {
        [self.delegate mainHone_OxygenCollectionAction:tap];
    }
}

// MARK: ABPopViewDelegate
- (void)startFuncAction:(UIButton *)sender {
//    self.popView.hidden = YES;
    if ([self.delegate respondsToSelector:@selector(mainHome_StartFuncAction:)]) {
        [self.delegate mainHome_StartFuncAction:sender];
    }
}

// MARK: Lazy loading
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.userInteractionEnabled = YES;
        [self addSubview:_bgImageView];
        
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(0);
        }];
    }
    return _bgImageView;
}

- (UIImageView *)plantBaseImgView {
    if (!_plantBaseImgView) {
        _plantBaseImgView = [UIImageView new];
        _plantBaseImgView.userInteractionEnabled = YES;
        [self.bgImageView addSubview:_plantBaseImgView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPlantTipsAction:)];
        [_plantBaseImgView addGestureRecognizer:tap];
        [_plantBaseImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bgImageView);
            make.bottom.mas_equalTo(self.bgImageView.mas_bottom).offset(-5);
            make.height.mas_equalTo(83);
            make.width.mas_equalTo(123);
        }];
    }
    return _plantBaseImgView;
}

- (UIImageView *)plantImgView {
    if (!_plantImgView) {
        _plantImgView = [UIImageView new];
        _plantImgView.userInteractionEnabled = YES;
        [self.bgImageView addSubview:_plantImgView];
        [_plantImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bgImageView);
            make.bottom.mas_equalTo(self.plantBaseImgView.mas_top);
            make.height.mas_equalTo(210);
            make.width.mas_equalTo(181);
        }];

    }
    return _plantImgView;
}

- (ABPopView *)popView {
    if (!_popView) {
        _popView = [[ABPopView alloc] init];
        
        _popView.delegate = self;
        [_popView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(24);
            make.bottom.mas_equalTo(self.plantBaseImgView.mas_top).offset(15);
            make.width.mas_equalTo(ratioW(261));
        }];
    }
    return _popView;
}

- (UIButton *)customerServiceBtn {
    if (!_customerServiceBtn) {
        _customerServiceBtn = UIButton.new;
        [self addSubview:_customerServiceBtn];
        [_customerServiceBtn addTarget:self action:@selector(customerServiceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_customerServiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-16);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-ratioH(67));
            make.width.height.mas_equalTo(ratioH(40));
        }];
    }
    return _customerServiceBtn;
}

- (UIView *)tipsBgView {
    if (!_tipsBgView) {
        _tipsBgView = UIView.new;
        [self addSubview:_tipsBgView];
        [_tipsBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(8);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-ratioH(66));
            make.width.mas_equalTo(ratioW(90));
            make.height.mas_equalTo(ratioH(75));
        }];
    }
    return _tipsBgView;
}

- (UIImageView *)tipsImgView1 {
    if (!_tipsImgView1) {
        _tipsImgView1 = UIImageView.new;
        [self.tipsBgView addSubview:_tipsImgView1];
        [_tipsImgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(ratioW(25));
        }];
    }
    return _tipsImgView1;
}

- (UIImageView *)tipsImgView2 {
    if (!_tipsImgView2) {
        _tipsImgView2 = UIImageView.new;
        [self.tipsBgView addSubview:_tipsImgView2];
        [_tipsImgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.tipsImgView1.mas_right).offset(ratioW(12));
            make.top.mas_equalTo(self.tipsBgView.mas_top).offset(ratioH(32));
            make.width.height.mas_equalTo(ratioH(29));
        }];
    }
    return _tipsImgView2;
}

- (UILabel *)tipSplantHeightLab {
    if (!_tipSplantHeightLab) {
        _tipSplantHeightLab = UILabel.new;
        _tipSplantHeightLab.font = FONT_MEDIUM(15);
        _tipSplantHeightLab.textColor = [UIColor colorWithHexString:@"0x25FA5E"];
        [self.tipsBgView addSubview:_tipSplantHeightLab];
        [_tipSplantHeightLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.tipsImgView1.mas_right);
            make.top.mas_equalTo(self.tipsBgView.mas_top).offset(ratioH(5));
            make.height.mas_equalTo(ratioH(22));
            make.width.mas_equalTo(ratioW(100));
        }];
    }
    return _tipSplantHeightLab;
}
@end
