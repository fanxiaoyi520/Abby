//
//  UIButton+Common.h
//  teamwork
//
//  Created by 张俊彬 on 2019/9/18.
//  Copyright © 2019 Zhengzhou Yutong Bus Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GLButtonEdgeInsetsStyle) {
    GLButtonEdgeInsetsStyleTop, // image在上，label在下
    GLButtonEdgeInsetsStyleLeft, // image在左，label在右
    GLButtonEdgeInsetsStyleBottom, // image在下，label在上
    GLButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (Common)
-(void)jaf_imageTopTitleBottomWithDistance:(CGFloat)distance;
- (void)jaf_layoutButtonWithEdgeInsetsStyle:(GLButtonEdgeInsetsStyle)style
                            imageTitleSpace:(CGFloat)space;
-(void)jaf_imageTopTitleBottomWithDistanceCenter:(CGFloat)distance;

//扩大按钮的点击范围
- (void)jaf_setEnlargeEdgeWithTop:(CGFloat)top
                            right:(CGFloat)right
                           bottom:(CGFloat) bottom
                             left:(CGFloat) left;
@end

