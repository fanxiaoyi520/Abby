//
//  ABPopUpgradeViewController.h
//  UniversalApp
//
//  Created by Baypac on 2022/1/25.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ABPopUpgradeDelegate <NSObject>

- (void)abPop_upgradeSuccess:(UIButton *)sender;

@end
@interface ABPopUpgradeViewController : RootViewController

@property (nonatomic ,weak)id <ABPopUpgradeDelegate> delegate;
@end


NS_ASSUME_NONNULL_END
