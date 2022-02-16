//
//  ABShareView.m
//  UniversalApp
//
//  Created by Baypac on 2022/2/15.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABShareView.h"

@interface ABShareView()
@property (nonatomic ,assign) CGFloat con_height;

// Header
@property (nonatomic ,strong) UIView *headerView;
@property (nonatomic ,strong) UIImageView *headerImgView;
@property (nonatomic ,strong) UILabel *nameLab;

// Content
@property (nonatomic ,strong) UIView *conBgView;
@property (nonatomic ,strong) UILabel *conLab;
@property (nonatomic ,strong) UILabel *conTimeLab;
@property (nonatomic ,strong)UIView *photoBgView;
@property (nonatomic ,strong)UILabel *weekDayLab;
@property (nonatomic ,strong)UILabel *plantDataLab;
@property (nonatomic ,strong)UIView *lineView;

// Footer
@property (nonatomic ,strong) UIView *footerView;
@property (nonatomic ,strong) UIView *footerLineView;
@property (nonatomic ,strong) UILabel *footerTipsLab;
@end

@implementation ABShareView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.headerView];
    [self.headerView addSubview:self.headerImgView];
    [self.headerView addSubview:self.nameLab];
    
    [self addSubview:self.conBgView];
    [self.conBgView addSubview:self.conLab];
    [self.conBgView addSubview:self.conTimeLab];
    [self.conBgView addSubview:self.photoBgView];
    [self.photoBgView addSubview:self.weekDayLab];
    [self.photoBgView addSubview:self.lineView];
    [self.photoBgView addSubview:self.plantDataLab];
    
    [self addSubview:self.footerView];
    [self.footerView addSubview:self.footerTipsLab];
    [self.footerView addSubview:self.footerLineView];
}

- (void)loadData:(id)model {
    // Header
    [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:Default_Avatar];
    self.nameLab.text = @"Steve Jobs";
    
    // Content
    self.conLab.text = @"Your Apple ID, pinnachan7@gmail.com, was just used to download Mi Home - Xiaomi Smart Home on a computer or device that has not previously been used. You may also be receiving this email if you reset your password since your last purchase.";
    CGRect conLabRect = [self.conLab.text boundingRectWithSize:CGSizeMake(self.conLab.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.conLab.font} context:nil];
    self.conLab.height = conLabRect.size.height;
    
    self.conTimeLab.text = @"14:24   11/17/2021";
    CGRect conTimeLabRect = [self.conTimeLab.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.conTimeLab.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.conTimeLab.font} context:nil];
    self.conTimeLab.frame = CGRectMake(self.width-24-conTimeLabRect.size.width, self.conLab.bottom+16, conTimeLabRect.size.width, 16);
    
    self.photoBgView.top = self.conTimeLab.bottom + 31;
    ViewRadius(self.photoBgView, 10);
    self.weekDayLab.text = @"2 Week  7/12 day ";
    CGRect weekDayLabRect = [self.weekDayLab.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.weekDayLab.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.conTimeLab.font} context:nil];
    self.weekDayLab.frame = CGRectMake(self.photoBgView.width-24-weekDayLabRect.size.width, 16, conTimeLabRect.size.width, 18);
    
    self.plantDataLab.text = @"Plant data";
    CGRect plantDataLabRect = [self.plantDataLab.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.plantDataLab.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.conTimeLab.font} context:nil];
    self.plantDataLab.frame = CGRectMake(16, 16, plantDataLabRect.size.width, 18);
    
    NSArray *array = @[@"66mm",@"120F",@"110F",@"73%"];
    NSArray *imageArray = @[@"icon_16_c_n",@"icon_16_w_n",@"icon_16_s_n",@"icon_16_x_n"];
    NSMutableArray *mArray = [NSMutableArray array];
    [imageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setImage:ImageName(imageArray[idx]) forState:UIControlStateNormal];
        [btn setTitle:array[idx] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"0x161B19"] forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_MEDIUM(11);
        [self.photoBgView addSubview:btn];
        [mArray addObject:btn];

    }];
    [mArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:12 tailSpacing:12];
    [mArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@43);
        make.height.equalTo(40);
    }];
    
    NSArray *arr = @[@"http://192.168.3.6/2021/12/28/1640662584158929.jpg",@"http://192.168.3.6/2022/01/13/1642063904355730.jpg",@"http://192.168.3.6/2022/01/13/1642063921719238.jpg",@"http://192.168.3.6/2022/01/13/1642063921719238.jpg",@"http://192.168.3.6/2021/12/28/1640662584158929.jpg"];
    __block CGFloat img_H = 0;
    __block CGFloat old_bottom = 0;
    for (int i=0; i<arr.count; i++) {
        UIImageView *imgView = UIImageView.new;
        imgView.tag = 100+i;
        imgView.frame = CGRectMake(24, self.photoBgView.bottom+32+i*(100+32), self.width-24*2, 100);
        [self.conBgView addSubview:imgView];
        [imgView sd_setImageWithURL:[NSURL URLWithString:arr[i]] placeholderImage:Default_Avatar options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            CGSize size = image.size;
            CGFloat w = size.width;
            CGFloat H = size.height;
            img_H += H*((self.width-24*2)/w);
            imgView.height = H*((self.width-24*2)/w);
            
            UIImageView *oldImgView = [self.conBgView viewWithTag:100+i-1];
            old_bottom = !oldImgView ? self.photoBgView.bottom : oldImgView.bottom;
            imgView.top = old_bottom +32;
            if (i==arr.count-1) {
                self.conBgView.height = conLabRect.size.height+24+180+32*arr.count+img_H+79;
                self.contentSize = CGSizeMake(self.width, self.conBgView.height+self.footerView.height+self.headerView.height);

                UILabel *lab = UILabel.new;
                [self.conBgView addSubview:lab];
                lab.textColor = kLineColor;
                lab.textAlignment = NSTextAlignmentCenter;
                lab.text = @"Download abby App to see more";
                lab.font = FONT_MEDIUM(12);
                CGRect labRect = [lab.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 16) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:lab.font} context:nil];
                lab.frame = CGRectMake((self.width-labRect.size.width)/2, self.conBgView.height-32-16-20, labRect.size.width, 16);
                for (int i=0; i<2; i++) {
                    UIView *lineView = UIView.new;
                    [self.conBgView addSubview:lineView];
                    lineView.backgroundColor = kLineColor;
                    lineView.frame = CGRectMake(41+i*(30+16+labRect.size.width), self.conBgView.height-39-20, 30, 1);
                }
                
                // Footer
                self.footerView.top = self.headerView.bottom+self.conBgView.height;
            }
        }];
    }
        
    self.footerTipsLab.text = @"Interesting Plants In abby";
}

// MARK: lazy Loading
// Header
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = UIView.new;
        _headerView.backgroundColor = [UIColor colorWithHexString:@"0x006D48"];
        _headerView.frame = CGRectMake(0, 0, self.width, 137);
    }
    return _headerView;
}

- (UIImageView *)headerImgView {
    if (!_headerImgView) {
        _headerImgView = UIImageView.new;
        _headerImgView.frame = CGRectMake(24, 50, 40, 40);
    }
    return _headerImgView;
}

- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = UILabel.new;
        _nameLab.textColor = [UIColor colorWithHexString:@"0xFFFFFF"];
        _nameLab.font = FONT_BOLD(16);
        _nameLab.frame = CGRectMake(24, self.headerImgView.bottom, self.width-24*2, 21);
    }
    return _nameLab;
}

// Content
- (UIView *)conBgView {
    if (!_conBgView) {
        _conBgView = UIView.new;
        _conBgView.backgroundColor = KWhiteColor;
        _conBgView.frame = CGRectMake(0, self.headerView.bottom, self.width, 0);
    }
    return _conBgView;
}

- (UILabel *)conLab {
    if (!_conLab) {
        _conLab = UILabel.new;
        _conLab.textColor = [UIColor colorWithHexString:@"0x161B19"];
        _conLab.font = FONT_REGULAR(15);
        _conLab.frame = CGRectMake(24, 24, self.width-24*2, 0);
        _conLab.numberOfLines = 0;
    }
    return _conLab;
}

- (UILabel *)conTimeLab {
    if (!_conTimeLab) {
        _conTimeLab = UILabel.new;
        _conTimeLab.textColor = [UIColor colorWithHexString:@"0x161B19"];
        _conTimeLab.font = FONT_REGULAR(13);
        _conTimeLab.frame = CGRectMake(0, 0, 0, 16);
    }
    return _conTimeLab;
}

- (UIView *)photoBgView {
    if (!_photoBgView) {
        _photoBgView = [UIView new];
        _photoBgView.userInteractionEnabled = YES;
        _photoBgView.backgroundColor = [UIColor colorWithHexString:@"0xF7F7F7"];
        _photoBgView.frame = CGRectMake(24, 0, self.width-24*2, 83);
    }
    return _photoBgView;
}

- (UILabel *)weekDayLab {
    if (!_weekDayLab) {
        _weekDayLab = [UILabel new];
        _weekDayLab.font = FONT_MEDIUM(11);
        _weekDayLab.textColor = [UIColor colorWithHexString:@"0x161B19"];
        _weekDayLab.frame = CGRectMake(0, 16, 0, 18);
        _weekDayLab.textAlignment = NSTextAlignmentRight;
    }
    return _weekDayLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = UIView.new;
        _lineView.backgroundColor = KWhiteColor;
        _lineView.frame = CGRectMake(16, 45, self.photoBgView.width-16*2, 1);
    }
    return _lineView;
}

- (UILabel *)plantDataLab {
    if (!_plantDataLab) {
        _plantDataLab = [UILabel new];
        _plantDataLab.font = FONT_BOLD(11);
        _plantDataLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        _plantDataLab.frame = CGRectMake(16, 16, 0, 18);
    }
    return _plantDataLab;
}

// Footer
- (UIView *)footerView {
    if (!_footerView) {
        _footerView = UIView.new;
        _footerView.backgroundColor = [UIColor colorWithHexString:@"0x006D48"];
        _footerView.frame = CGRectMake(0, 0, self.width, 110);
    }
    return _footerView;
}

- (UILabel *)footerTipsLab {
    if (!_footerTipsLab) {
        _footerTipsLab = UILabel.new;
        _footerTipsLab.textColor = [UIColor colorWithHexString:@"0xFFFFFF"];
        _footerTipsLab.font = FONT_BOLD(16);
        _footerTipsLab.frame = CGRectMake(24, 25, self.width-24*2, 21);
    }
    return _footerTipsLab;
}

- (UIView *)footerLineView {
    if (!_footerLineView) {
        _footerLineView = UIView.new;
        _footerLineView.backgroundColor = [UIColor colorWithHexString:@"0xFFFFFF"];
        _footerLineView.frame = CGRectMake(24, self.footerTipsLab.bottom+8, 30, 3);
    }
    return _footerLineView;
}
@end
