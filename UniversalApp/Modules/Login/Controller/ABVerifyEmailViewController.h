//
//  ABVerifyEmailViewController.h
//  UniversalApp
//
//  Created by Baypac on 2022/1/4.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABVerifyEmailViewController : RootViewController
@property (nonatomic, assign) FuncPattern funcPattern;
@property (nonatomic, copy) NSString *emailStr;
@end

NS_ASSUME_NONNULL_END
