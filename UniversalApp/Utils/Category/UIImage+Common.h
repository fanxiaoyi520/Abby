//
//  UIImage+Common.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/28.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Common)

/// 压缩图片方法
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
@end

NS_ASSUME_NONNULL_END
