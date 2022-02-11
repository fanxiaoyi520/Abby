//
//  ABOxygenBillCell.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/8.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABOxygenBillModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ABOxygenBillCell : BaseTableViewCell

@property (nonatomic, strong) UIView *lineView;//线条
@property (nonatomic , strong) ABOxygenBillListModel * cellModel;
@end

NS_ASSUME_NONNULL_END
