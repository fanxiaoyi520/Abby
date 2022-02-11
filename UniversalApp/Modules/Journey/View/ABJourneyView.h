//
//  ABJourneyView.h
//  UniversalApp
//
//  Created by Baypac on 2022/1/7.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ABJourneyViewDelegate <NSObject>

- (void)journey_unlockFuncAction:(UIButton *)sender;
- (void)journey_taskFuncAction:(UIButton *)sender;
@end
@interface ABJourneyView : UIView
@property (nonatomic, strong) UIButton *lockBtn;
@property (nonatomic ,weak) id<ABJourneyViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
