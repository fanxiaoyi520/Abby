//
//  ABPrivacyViewController.h
//  UniversalApp
//
//  Created by Baypac on 2021/11/25.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ABSureLoginDelegate <NSObject>
- (void)sureLogin;
- (void)openUrlWithTypeStr:(NSString *)typeStr;
@end

@interface ABPrivacyViewController : RootViewController

@property (nonatomic ,weak) id<ABSureLoginDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
