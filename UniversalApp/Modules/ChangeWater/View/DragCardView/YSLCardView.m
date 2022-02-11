//
//  YSLCardView.m
//  Crew-iOS
//
//  Created by yamaguchi on 2015/10/23.
//  Copyright © 2015年 h.yamaguchi. All rights reserved.
//

#import "YSLCardView.h"

@implementation YSLCardView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupCardView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCardView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupCardView];
    }
    return self;
}

- (void)setupCardView {
    self.layer.cornerRadius  = 15;
    self.layer.masksToBounds = NO;
    
    self.layer.shadowColor   = [UIColor colorWithHexString:@"0x000000"].CGColor;
    self.layer.shadowOffset  = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 0.1;
    self.layer.shadowRadius  = 20;
}


@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
