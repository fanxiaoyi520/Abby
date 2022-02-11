//
//  ABTrendCell.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/1.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABTrentModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ABTrendCellFuncDelegate <NSObject>

- (void)trend_LikeAction:(UIButton *)sender;
- (void)trend_giftAction:(UIButton *)sender;
- (void)trend_downloadAction:(UIButton *)sender;
- (void)trend_moreAction:(UIButton *)sender;
- (void)trend_deviceDataPopAction:(UITapGestureRecognizer *)tap;
- (void)trend_updeteCellHeight:(UIButton *)sender;
@end
@interface ABTrendCell : UITableViewCell

@property (nonatomic ,strong) ABTrentModel *model;
@property (nonatomic ,weak) id <ABTrendCellFuncDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
