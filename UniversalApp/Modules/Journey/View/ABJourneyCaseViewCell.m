//
//  ABJourneyCaseViewCell.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/7.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABJourneyCaseViewCell.h"

@implementation ABJourneyCaseViewCell
// 防止滚动时图片错乱
- (void)prepareForReuse {
    [super prepareForReuse];
    // 重置image
    self.coverImgView.image = nil;
    // 更新位置
    self.coverImgView.frame = self.contentView.bounds;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KWhiteColor;
        self.userInteractionEnabled = YES;
        self.layer.cornerRadius = 10.f;
        self.layer.masksToBounds = YES;
        self.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        self.layer.shadowOffset = CGSizeMake(4.f, 4.f);
        self.layer.shadowOpacity = 1.f;
        self.layer.shadowRadius = 20.f;
    
        self.coverImgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width-ratioW(107))/2, (self.height-ratioH(176))/2, ratioW(107), ratioH(176))];
        self.coverImgView.userInteractionEnabled = YES;
        self.coverImgView.layer.masksToBounds = YES;
        self.coverImgView.layer.cornerRadius = 10.f;
        [self.contentView addSubview:self.coverImgView];
    }
    return  self;
}

@end
