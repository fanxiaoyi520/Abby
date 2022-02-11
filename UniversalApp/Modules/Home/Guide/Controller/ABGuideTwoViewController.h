//
//  ABGuideTwoViewController.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/16.
//  Copyright © 2021 徐阳. All rights reserved.
//

typedef NS_ENUM(NSInteger ,ABTipsStep) {
    First,
    Second,
    Third,
    Four,
};
#import "BaseModalPopUpViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABGuideTwoViewController : BaseModalPopUpViewController

- (instancetype)initWithTipStep:(ABTipsStep)tipsStep;
@end

NS_ASSUME_NONNULL_END
