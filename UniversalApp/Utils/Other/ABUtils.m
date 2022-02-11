//
//  ABUtils.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/8.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABUtils.h"

@implementation ABUtils

//MARK: 读取本地json
+ (id)getJsonDataJsonname:(NSString *)jsonname
{
    NSString *path = [[NSBundle mainBundle] pathForResource:jsonname ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!jsonData || error) {
        //DLog(@"JSON解码失败");
        return nil;
    } else {
        return jsonObj;
    }
}

/**
*画虚线
@param lineView 视图
@param lineLength 单个虚线大小
@param lineSpacing 间隔
@param lineColor 虚线颜色
*/
+(void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor {
    CGRect rect = CGRectMake(0, 0, CGRectGetWidth(lineView.frame), CGRectGetHeight(lineView.frame));
    CGSize radii = CGSizeMake(5, 5);//圆角
    UIRectCorner corners = UIRectCornerAllCorners;
    //create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = lineColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 0.5;//line的高度
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    shapeLayer.lineDashPattern = @[[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing]];//画虚线(虚线宽、虚线间隔)
    //add it to our view
    [lineView.layer addSublayer:shapeLayer];
}

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
                  fontArray:(NSArray *)fontArray
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    [label setAttributedText:str];
    for (int i = 0 ; i < [textArray count]; i++ )
    {
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:9];
        [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [string length])];
        NSRange range1 = [[str string] rangeOfString:textArray[i]];
        [str addAttribute:NSForegroundColorAttributeName value:colorArray[i] range:range1];
        [str addAttribute:NSFontAttributeName value:fontArray[i] range:range1];
    }
   label.attributedText = str;
}
@end
