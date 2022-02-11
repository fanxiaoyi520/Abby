//
//  ABConnectingViewController.h
//  UniversalApp
//
//  Created by Baypac on 2022/1/19.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABConnectingViewController : RootViewController

@property (nonatomic ,strong) TYBLEAdvModel *peripheral;
@property (nonatomic ,copy) NSString *PWD;
@end

NS_ASSUME_NONNULL_END
