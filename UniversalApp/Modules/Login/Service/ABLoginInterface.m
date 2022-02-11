//
//  ABLoginInterface.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/5.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABLoginInterface.h"

@implementation ABLoginInterface
+ (void)login_registerWithParams:(NSDictionary *)params success:(void(^)(id responseObject))success{
    [MBProgressHUD showActivityMessageInWindow:@""];
    [PPNetworkHelper GET:NSStringFormat(@"%@%@",URL_main,URL_user_verify_email) parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        if ([[responseObject[@"code"] stringValue] isEqualToString:@"200"]) {
            [MBProgressHUD hideHUD];
            if (success)success(responseObject);
        } else {
            [UIViewController jaf_showHudTip:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [UIViewController jaf_showHudTip:error.localizedDescription];
    }];
}

+ (void)login_registerVerificationCodeWithParams:(NSDictionary *)params success:(void(^)(id responseObject))success {
    [MBProgressHUD showActivityMessageInWindow:@""];
    [PPNetworkHelper GET:NSStringFormat(@"%@%@",URL_main,URL_user_verify_code) parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        if ([[responseObject[@"code"] stringValue] isEqualToString:@"200"]) {
            if (success)success(responseObject);
        } else {
            [UIViewController jaf_showHudTip:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [UIViewController jaf_showHudTip:error.localizedDescription];
    }];
}

+ (void)login_registerSetPasswordWithParams:(NSDictionary *)params success:(void(^)(id responseObject))success {
    [MBProgressHUD showActivityMessageInWindow:@""];
    [PPNetworkHelper POST:NSStringFormat(@"%@%@",URL_main,URL_user_app_register) parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        if ([[responseObject[@"code"] stringValue] isEqualToString:@"200"]) {
            if (success)success(responseObject);
        } else {
            [UIViewController jaf_showHudTip:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [UIViewController jaf_showHudTip:error.localizedDescription];
    }];
}

+ (void)login_registerForgetPasswordWithParams:(NSDictionary *)params success:(void(^)(id responseObject))success {
    [MBProgressHUD showActivityMessageInWindow:@""];
    [PPNetworkHelper POST:NSStringFormat(@"%@%@",URL_main,URL_user_app_updatePwd) parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        if ([[responseObject[@"code"] stringValue] isEqualToString:@"200"]) {
            if (success)success(responseObject);
        } else {
            [UIViewController jaf_showHudTip:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [UIViewController jaf_showHudTip:error.localizedDescription];
    }];
}

+ (void)login_registerSysParamsNationWithParams:(NSDictionary * _Nullable)params success:(void(^)(id responseObject))success {
    [PPNetworkHelper GET:NSStringFormat(@"%@%@",URL_main,URL_sysParams_nation) parameters:params success:^(id responseObject) {
        if ([[responseObject[@"code"] stringValue] isEqualToString:@"200"]) {
            if (success)success(responseObject);
        } else {
            [UIViewController jaf_showHudTip:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [UIViewController jaf_showHudTip:error.localizedDescription];
    }];
}

+ (void)login_loginExitLoginWithParams:(NSDictionary * _Nullable)params success:(void(^)(id responseObject))success {
    [PPNetworkHelper GET:NSStringFormat(@"%@%@",URL_main,URL_user_logout) parameters:params success:^(id responseObject) {
        if ([[responseObject[@"code"] stringValue] isEqualToString:@"200"]) {
            if (success)success(responseObject);
        } else {
            [UIViewController jaf_showHudTip:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [UIViewController jaf_showHudTip:error.localizedDescription];
    }];
}
@end
