//
//  ABOxygenRewardViewController.h
//  UniversalApp
//
//  Created by Baypac on 2022/1/18.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ABOxygenRewardDelegate <NSObject>

- (void)oxygenReward_sureBtnAction:(NSString *)o2NumStr;

@end
@interface ABOxygenRewardViewController : RootViewController

@property (nonatomic ,weak) id <ABOxygenRewardDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
