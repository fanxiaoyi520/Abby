//
//  STLoopProgressView+BaseConfiguration.m
//  STLoopProgressView
//
//  Created by TangJR on 7/1/15.
//  Copyright (c) 2015 tangjr. All rights reserved.
//

#import "STLoopProgressView+BaseConfiguration.h"

#define DEGREES_TO_RADOANS(x) (M_PI * (x) / 180.0) // 将角度转为弧度

@implementation STLoopProgressView (BaseConfiguration)

+ (UIColor *)startColor {
    
    return [UIColor colorWithHexString:@"0x006241"];
}

+ (UIColor *)centerColor {
    
    return [UIColor colorWithHexString:@"0x006241"];
}

+ (UIColor *)endColor {
    
    return [UIColor colorWithHexString:@"0x006241"];
}

+ (UIColor *)backgroundColor {
    
    return [UIColor colorWithHexString:@"0xE5E5E5"];
}

+ (CGFloat)lineWidth {
    
    return 10;
}

+ (CGFloat)startAngle {
    
    return DEGREES_TO_RADOANS(-270);
}

+ (CGFloat)endAngle {
    
    return DEGREES_TO_RADOANS(90);
}

+ (STClockWiseType)clockWiseType {
    return STClockWiseNo;
}

@end
