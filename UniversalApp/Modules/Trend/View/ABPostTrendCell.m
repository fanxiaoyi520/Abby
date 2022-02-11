//
//  ABPostTrendCell.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/29.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABPostTrendCell.h"

@interface ABPostTrendCell ()
@property (nonatomic ,strong) UIImageView *tImageView;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UISwitch *controlSwitch;
@property (nonatomic ,strong) UIView *lineView;
@end
@implementation ABPostTrendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.tImageView];
    self.tImageView.frame = CGRectMake(24, (60-32)/2, 32, 32);
    [self.contentView addSubview:self.titleLab];
    self.titleLab.frame = CGRectMake(self.tImageView.right+3, (60-22)/2, 0, 22);
    [self addSubview:self.controlSwitch];
    self.controlSwitch.frame = CGRectMake(kScreenWidth-52-25, (60-32)/2, 52, 32);
    [self.contentView addSubview:self.lineView];
    self.lineView.frame = CGRectMake(20, 60-1, kScreenWidth-20*2, 1);
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    self.tImageView.image = ImageName([dic objectForKey:@"imageName"]);
    
    self.titleLab.text = [dic objectForKey:@"title"];
    CGFloat titleW = [self.titleLab.text getWidthWithHeight:22 Font:self.titleLab.font];
    self.titleLab.width = titleW;
}

// MARK: actions
- (void)tell {
    DLog(@"1");
}

// MARK: Lazy loading
- (UIImageView *)tImageView {
    if (!_tImageView) {
        _tImageView = UIImageView.new;
    }
    return _tImageView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.font = FONT_MEDIUM(15);
        _titleLab.textColor = [UIColor colorWithHexString:@"0x161B19"];
    }
    return _titleLab;
}

- (UISwitch *)controlSwitch {
    if (!_controlSwitch) {
        _controlSwitch = UISwitch.new;
        [_controlSwitch setOn:YES];
        [_controlSwitch addTarget:self action:@selector(tell) forControlEvents:UIControlEventTouchUpInside];
    }
    return _controlSwitch;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = UIView.new;
        _lineView.backgroundColor = kLineColor;
    }
    return _lineView;
}
@end
