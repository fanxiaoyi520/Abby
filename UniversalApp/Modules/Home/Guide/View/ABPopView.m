//
//  ABPopView.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/15.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABPopView.h"

@interface ABPopView()

@property (nonatomic ,strong) UIButton *startBtn;
@property (nonatomic ,strong) UIButton *closeBtn;
@property (nonatomic ,strong) UILabel *titleLab;
@end

@implementation ABPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.image = ImageName(@"honme_Union_1");
        UIImage *image =ImageName(@"honme_Union_1");
        image = [image stretchableImageWithLeftCapWidth:image.size.width*0.6 topCapHeight:image.size.height*0.7];
        self.image = image;
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setIsHiddenClose:(BOOL)isHiddenClose {
    _isHiddenClose = isHiddenClose;
    self.closeBtn.hidden = isHiddenClose;
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-12);
        make.top.mas_equalTo(self.mas_top).offset(12);
        make.width.mas_equalTo(ratioW(20));
        make.height.mas_equalTo(ratioW(20));
    }];
    
    self.titleLab.text = titleStr;
    CGRect titleLabRect = [self.titleLab.text boundingRectWithSize:CGSizeMake(ratioW(261), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.titleLab.font} context:nil];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ratioW(16));
        make.right.mas_equalTo(ratioW(-16));
        make.top.mas_equalTo(ratioH(24));
        make.bottom.mas_equalTo(ratioH(-90));
    }];
    
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-12);
        make.bottom.mas_equalTo(-28);
        make.width.mas_equalTo(ratioW(80));
        make.height.mas_equalTo(ratioH(36));
    }];
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y+16-titleLabRect.size.height, self.width, ratioH((146-16+titleLabRect.size.height)));
}

- (void)setSureTag:(NSInteger)sureTag {
    _sureTag = sureTag;
    self.startBtn.tag = self.sureTag > 100 ? 101 : 100;
}

// MARK: Lazy loading
- (UIButton *)startBtn {
    if (!_startBtn) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _startBtn.backgroundColor = [UIColor colorWithHexString:@"0x026040"];
        [_startBtn setTitle:@"Start" forState:UIControlStateNormal];
        [_startBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [self addSubview:_startBtn];
        _startBtn.titleLabel.font = FONT_MEDIUM(15);
        ViewRadius(_startBtn, ratioH(18));
        kWeakSelf(self);
        [_startBtn addTapBlock:^(UIButton *btn) {
            if ([weakself.delegate respondsToSelector:@selector(startFuncAction:)]) {
                [weakself.delegate startFuncAction:btn];
            }
        }];
    }
    return _startBtn;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.hidden = YES;
        [_closeBtn setImage:ImageName(@"icon_t_closure") forState:UIControlStateNormal];
        [self addSubview:_closeBtn];
        kWeakSelf(self);
        [_closeBtn addTapBlock:^(UIButton *btn) {
            weakself.hidden = !weakself.hidden;
        }];
    }
    return _closeBtn;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = FONT_REGULAR(13);
        _titleLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        _titleLab.numberOfLines = 0;
        [_titleLab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self addSubview:_titleLab];
    }
    return _titleLab;
}
@end
