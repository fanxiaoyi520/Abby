//
//  ABMessageCenterCell.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/9.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABMessageCenterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABMessageCenterCell : BaseTableViewCell
@property (nonatomic ,strong) UIView *lineView;
@property (nonatomic ,strong) UIView *newsTipsView;
@property (nonatomic ,strong) ABMessageCenterModel *cellModel;
@end

NS_ASSUME_NONNULL_END
