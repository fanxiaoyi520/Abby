//
//  ABTurntableView.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/11.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABTurntableView.h"
@interface ABTurntableView ()

@property (nonatomic, assign) CGFloat rotationAngleInRadians;
@property (nonatomic, strong) NSMutableArray *labArray;// 周期lab数组

@end

@implementation ABTurntableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.frame.size.width / 2 ;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        _labArray = [NSMutableArray new];
        [self addGestureRecognizer:[[ABRotationGestureRecognizer alloc]initWithTarget:self action:@selector(changeMove:)]];
    }
    return self;
}

- (void)plantGrowthCycleLayout:(NSArray *)titleArray {
    for (int i = 0 ; i < titleArray.count; i++) {
        UIView *lineBgView = UIView.new;
        [self addSubview:lineBgView];
        lineBgView.frame = CGRectMake(0, 0, 1, ratioH(160));
        lineBgView.layer.anchorPoint = CGPointMake(0, 0);
        lineBgView.center = CGPointMake(CGRectGetHeight(self.frame)/2, CGRectGetHeight(self.frame)/2);
        CGFloat angle1 = M_PI*2/titleArray.count * i - M_PI*2/titleArray.count*2;
        lineBgView.transform = CGAffineTransformMakeRotation(angle1);
        lineBgView.tag = 100 + i;
        
        UIView *lineView = UIView.new;
        [lineBgView addSubview:lineView];
        lineView.frame = CGRectMake(0, -ratioH(156), 2, 7);
        lineView.tag = 2000;
        [_labArray addObject:lineBgView];
        ViewRadius(lineView, .5);
        
        UILabel *textLab = UILabel.new;
        textLab.text = titleArray[i];
        [lineBgView addSubview:textLab];
        textLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        textLab.font = FONT_BOLD(16);
        textLab.tag = 1000;
        textLab.textAlignment = NSTextAlignmentCenter;
        textLab.frame = CGRectMake(-49/2, lineView.bottom-2, 49, 32);
        
        if (i<2) {
            textLab.textColor = lineView.backgroundColor = [UIColor colorWithHexString:@"0xD5D5D5"];
        } else if (i==2) {
            textLab.textColor = lineView.backgroundColor = [UIColor whiteColor];
        } else {
            textLab.textColor = lineView.backgroundColor = [UIColor colorWithHexString:@"0x006241"];
        }
    }
}

/** 移动后btn的位置 */
- (void)changeMove:(ABRotationGestureRecognizer *)retation {
    self.transform = CGAffineTransformMakeRotation(self.rotationAngleInRadians+retation.rotation);
    self.rotationAngleInRadians = fabs(self.rotationAngleInRadians) >= M_PI*2 ? 0.0f : self.rotationAngleInRadians+ retation.rotation;

    if ([self.delegate respondsToSelector:@selector(turntableChangeMove:retation:)]) {
        [self.delegate turntableChangeMove:self.rotationAngleInRadians retation:retation];
    }
}

@end
