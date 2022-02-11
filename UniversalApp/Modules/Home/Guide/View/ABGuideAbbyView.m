//
//  ABGuideAbbyView.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/16.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABGuideAbbyView.h"
#import "ABPopView.h"


@interface ABGuideAbbyView()<ABMainHomeDelegate,ABPopViewDelegate>
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIImageView *bgImageView;
@property (nonatomic ,strong) UIImageView *plantBaseImgView;
@property (nonatomic ,strong) ABPopView *popView;
@end

@implementation ABGuideAbbyView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"0xF7F7F7"];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.titleLab.text = @"hey abby";
    UIImage *image = ImageName(@"home_botany_bg");
    image = [image stretchableImageWithLeftCapWidth:0 topCapHeight:image.size.height*.5];
    self.bgImageView.image = image;
    self.plantBaseImgView.image = ImageName(@"pic_plant_0_k");
    [self.plantBaseImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgImageView.mas_bottom).offset(-5);
        make.height.mas_equalTo(ratioH(310));
        make.width.mas_equalTo(ratioW(200));
    }];
    
    [self addSubview:self.popView];
}

// MARK: actions

// MARK: ABPopViewDelegate
- (void)startFuncAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(guide_addingWaterAction:)]) {
        [self.delegate guide_addingWaterAction:sender];
    }
}

- (void)updatePopView {
    self.popView.titleStr = @"Great! You have finished adding water,let's clone into the plant box.";
    self.popView.sureTag = 101;
}

// MARK: Lazy loading
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = FONT_BOLD(24);
        _titleLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        [self addSubview:self.titleLab];
        
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.right.mas_equalTo(-16);
            make.top.equalTo(self).with.offset(kScreenHeight*68.f/812.f);
            make.height.mas_equalTo(28);
        }];
    }
    return _titleLab;
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.userInteractionEnabled = YES;
        [self addSubview:_bgImageView];
        
        UITabBarController *tabBarVc =[[UITabBarController alloc] init];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(16);
            make.right.equalTo(-16);
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(12);
            make.bottom.mas_equalTo(-18-tabBarVc.tabBar.frame.size.height-CONTACTS_SAFE_BOTTOM);
        }];
    }
    return _bgImageView;
}

- (UIImageView *)plantBaseImgView {
    if (!_plantBaseImgView) {
        _plantBaseImgView = [UIImageView new];
        _plantBaseImgView.userInteractionEnabled = YES;
        [self.bgImageView addSubview:_plantBaseImgView];
        [_plantBaseImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bgImageView);
            make.bottom.mas_equalTo(self.bgImageView.mas_bottom).offset(-5);
            make.height.mas_equalTo(0);
            make.width.mas_equalTo(0);
        }];
    }
    return _plantBaseImgView;
}

- (ABPopView *)popView {
    if (!_popView) {
        UITabBarController *tabBarVc =[[UITabBarController alloc] init];
        _popView = [[ABPopView alloc] initWithFrame:CGRectMake((self.width-ratioW(261))/2, KScreenHeight-18-tabBarVc.tabBar.frame.size.height-CONTACTS_SAFE_BOTTOM-ratioH(111)-ratioH(130), ratioW(261), ratioH(130))];
        _popView.titleStr = @"Start adding water";
        _popView.delegate = self;
    }
    return _popView;
}
@end
