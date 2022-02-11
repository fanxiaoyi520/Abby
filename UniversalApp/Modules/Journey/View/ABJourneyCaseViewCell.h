//
//  ABJourneyCaseViewCell.h
//  UniversalApp
//
//  Created by Baypac on 2022/1/7.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#define JLXScreenSize               [UIScreen mainScreen].bounds.size                       //屏幕大小
#define JLXScreenOrigin             [UIScreen mainScreen].bounds.origin                     //屏幕起点

NS_ASSUME_NONNULL_BEGIN

@interface ABJourneyCaseViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *coverImgView;
@end

NS_ASSUME_NONNULL_END
