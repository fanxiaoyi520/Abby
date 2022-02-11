//
//  ABBluetoothSearchViewController.h
//  UniversalApp
//
//  Created by Baypac on 2021/11/25.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABBluetoothSearchViewController : RootViewController
@property (nonatomic ,assign) int timeNum;
@property (nonatomic ,strong) ZYGCDTimer *timer;

@end

NS_ASSUME_NONNULL_END
