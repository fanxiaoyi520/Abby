//
//  ABTaskViewController.h
//  UniversalApp
//
//  Created by Baypac on 2022/1/17.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ABTaskViewDelegate <NSObject>

- (void)task_startFuncAction:(UIButton *)sender;

@end
@interface ABTaskViewController : RootViewController

@property (nonatomic ,weak) id <ABTaskViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
