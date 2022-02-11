//
//  ABLoginInterface.h
//  UniversalApp
//
//  Created by Baypac on 2022/1/5.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABLoginInterface.h"
#import "ABNationModel.h"
typedef NS_ENUM(NSInteger ,FuncPattern) {
    Register,
    ForgetPassword,
};

NS_ASSUME_NONNULL_BEGIN

@interface ABLoginInterface : NSObject

/// 注册向app注册
+ (void)login_registerWithParams:(NSDictionary *)params success:(void(^)(id responseObject))success;
/// 注册校验验证码
+ (void)login_registerVerificationCodeWithParams:(NSDictionary *)params success:(void(^)(id responseObject))success;
/// 注册设置密码
+ (void)login_registerSetPasswordWithParams:(NSDictionary *)params success:(void(^)(id responseObject))success;
///用户忘记密码后在app设置新密码
+ (void)login_registerForgetPasswordWithParams:(NSDictionary *)params success:(void(^)(id responseObject))success;
/// 获取国家列表
+ (void)login_registerSysParamsNationWithParams:(NSDictionary * _Nullable)params success:(void(^)(id responseObject))success;

/// 退出登陆
+ (void)login_loginExitLoginWithParams:(NSDictionary * _Nullable)params success:(void(^)(id responseObject))success;
@end

NS_ASSUME_NONNULL_END
