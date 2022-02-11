//
//  ABWifiListViewController.h
//  UniversalApp
//
//  Created by Baypac on 2021/11/26.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^ABWifiClickBlock)(id info);
@interface ABWifiListViewController : RootViewController

@property (nonatomic ,copy)ABWifiClickBlock block;
@end

NS_ASSUME_NONNULL_END
