//
//  ABWifiListCell.h
//  UniversalApp
//
//  Created by Baypac on 2021/11/26.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABWifiListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ABWifiListCell : UITableViewCell

@property (nonatomic ,strong) ABWifiListModel *model;
@end

NS_ASSUME_NONNULL_END
