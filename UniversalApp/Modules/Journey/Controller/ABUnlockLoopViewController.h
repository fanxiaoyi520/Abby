//
//  ABUnlockLoopViewController.h
//  UniversalApp
//
//  Created by Baypac on 2022/1/14.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ABUnlockLoopViewVCDelegate <NSObject>
@optional
- (void)rewardTips;

@end
@interface ABUnlockLoopViewController : RootViewController

@property (nonatomic ,weak) id<ABUnlockLoopViewVCDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
