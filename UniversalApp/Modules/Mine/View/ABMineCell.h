//
//  ABMineCell.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/7.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABMineModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABMineCell : BaseTableViewCell
@property (nonatomic, strong) UIView *lineView;//线条
@property (nonatomic, strong) UIView *newsTipsView;//消息提醒
@property (nonatomic , strong) ABMineModel * cellModel;
@end

NS_ASSUME_NONNULL_END
