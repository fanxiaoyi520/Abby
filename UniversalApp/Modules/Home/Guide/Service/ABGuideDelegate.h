//
//  ABGuideDelegate.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/16.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ABGuideViewDelegate <NSObject>
@optional
// start
- (void)guide_startFuncAction:(UIButton *)sender;
// 第一步
- (void)guide_setpOneNextAction:(UIButton *)sender;
// 第二步
- (void)guide_addingWaterStartAction:(UIButton *)sender;
// 第三步
- (void)guide_addingWaterAction:(UIButton *)sender;
// 第四步
- (void)guide_guideSecondAction:(UIButton *)sender;
@end
