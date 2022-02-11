//
//  ABProfileCell.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/13.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABProfileModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABProfileCell : UITableViewCell
@property (nonatomic , strong) UIView *lineView;
@property (nonatomic ,strong,readonly) UIImageView *headImgView;
- (void)setModel:(ABProfileModel *)model withTitleStr:(NSString *)titleStr withIndexPath:(NSIndexPath *)myIndexPath;

@end

NS_ASSUME_NONNULL_END
