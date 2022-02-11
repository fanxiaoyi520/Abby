//
//  UILabel+Common.h
//  teamwork
//
//  Created by 张俊彬 on 2020/8/26.
//  Copyright © 2020 Zhengzhou Yutong Bus Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TextConfigure;
@interface UILabel (Common)

//是否开启自动换行
@property (nonatomic , getter=isAutoWrap) BOOL isAutoWrap;
//自动换行配置属性
@property (nonatomic , getter=textConfigure) TextConfigure * _Nullable textConfigure;
//获取自动换行后的宽度
- (CGFloat)getTextWidth;
//获取自动换行后的高度
- (CGFloat)getTextHeight;
-(void)jaf_setLinspace:(CGFloat)linspace;
@end

@interface TextConfigure : NSObject
NS_ASSUME_NONNULL_BEGIN
+ (TextConfigure *)shareTextConfigure;
@property (nonatomic ,assign) CGFloat lineSpaing;
@property (nonatomic ,assign) CGFloat wordSpaing;
NS_ASSUME_NONNULL_END
@end
