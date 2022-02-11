//
//  UIImage+Common.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/28.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "UIImage+Common.h"

@implementation UIImage (Common)
//压缩图片方法
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
