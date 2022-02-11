//
//  ABUtils.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/8.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABUtils : NSObject

//读取本地json
+ (id)getJsonDataJsonname:(NSString *)jsonname;
/**
*画虚线
@param lineView 视图
@param lineLength 单个虚线大小
@param lineSpacing 间隔
@param lineColor 虚线颜色
*/
+(void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;
/**
 * 设置UILable 的字体和颜色
 @ label            :要设置的控件
 @ str                :要设置的字符串
 @ textArray      :有几个文字需要设置
 @ colorArray     :有几个颜色
 @ fontArray      :有几个字体
 */
+(void) setTextColorAndFont:(UILabel *)label
                        str:(NSString *)string
                  textArray:(NSArray *)textArray
                  colorArray:(NSArray *)colorArray
                  fontArray:(NSArray *)fontArray;
@end

NS_ASSUME_NONNULL_END
