//
//  ABOxygenBillHeaderView.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/8.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABOxygenBillModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ABOxygenBillHeaderView : UITableViewHeaderFooterView

@property (nonatomic , strong) ABOxygenBillModel * headerModel;
@end

NS_ASSUME_NONNULL_END
