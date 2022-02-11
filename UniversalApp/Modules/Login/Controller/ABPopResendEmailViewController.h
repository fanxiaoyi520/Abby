//
//  ABPopResendEmailViewController.h
//  UniversalApp
//
//  Created by Baypac on 2022/1/4.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ABPopResendEmailDelegate <NSObject>

- (void)resendEmail;

@end
@interface ABPopResendEmailViewController : RootViewController

@property (nonatomic ,weak) id <ABPopResendEmailDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
