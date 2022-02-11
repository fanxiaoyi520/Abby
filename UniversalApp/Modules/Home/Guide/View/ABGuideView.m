//
//  ABGuideView.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/14.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABGuideView.h"
#import "ABPopView.h"
@interface ABGuideView()<ABPopViewDelegate>

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) ABPopView *popView;
@property (nonatomic ,strong) UIImageView *deviceImgView;

@end

@implementation ABGuideView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.titleLab.text = @"hey abby";
    self.titleLab.frame = CGRectMake(0, 68, kScreenWidth, 28);
    [self addSubview:self.titleLab];
    
    self.deviceImgView.frame = CGRectMake((kScreenWidth-ratioW(200))/2, self.titleLab.bottom+ratioH(145), ratioW(200), ratioH(450));
    [self addSubview:self.popView];
}

// MARK: ABPopViewDelegate
- (void)startFuncAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(guide_startFuncAction:)]) {
        [self.delegate guide_startFuncAction:sender];
    }
}

// MARK: Lazy loading
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = FONT_BOLD(24);
        _titleLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (ABPopView *)popView {
    if (!_popView) {
        _popView = [[ABPopView alloc] initWithFrame:CGRectMake(ratioW(16), self.titleLab.bottom+ratioH(45), ratioW(261), ratioH(146))];
        _popView.titleStr = @"Let us complete two steps and start the planting journey together.";
        _popView.delegate = self;
    }
    return _popView;
}

- (UIImageView *)deviceImgView {
    if (!_deviceImgView) {
        _deviceImgView = [UIImageView new];
        _deviceImgView.image = ImageName(@"pic_111");
        [self addSubview:_deviceImgView];
    }
    return _deviceImgView;
}
@end
