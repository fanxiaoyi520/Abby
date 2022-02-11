//
//  ABSettingCell.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/9.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABSettingCell : BaseTableViewCell

@property (nonatomic ,strong) UIView *lineView;

- (void)layoutAndLoadData:(id)info isApp:(BOOL)isApp myIndexPath:(NSIndexPath *)myIndexPath ;

@end

NS_ASSUME_NONNULL_END
