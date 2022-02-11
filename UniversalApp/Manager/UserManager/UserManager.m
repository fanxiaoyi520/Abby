//
//  UserManager.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/22.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

SINGLETON_FOR_CLASS(UserManager);

-(instancetype)init{
    self = [super init];
    if (self) {
        //被踢下线
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onKick)
                                                     name:KNotificationOnKick
                                                   object:nil];
    }
    return self;
}

#pragma mark ————— 三方登录 —————
-(void)login:(UserLoginType )loginType completion:(loginBlock)completion{
    [self login:loginType params:nil completion:completion];
}

#pragma mark ————— 带参数登录 —————
-(void)login:(UserLoginType )loginType params:(NSDictionary *)params completion:(loginBlock)completion{
    //账号登录 暂未提供
    [self loginToServer:params completion:completion];
}

#pragma mark ————— 手动登录到服务器 —————
-(void)loginToServer:(NSDictionary *)params completion:(loginBlock)completion{
    [MBProgressHUD showActivityMessageInView:@"登录中..."];
    [PPNetworkHelper POST:NSStringFormat(@"%@%@",URL_main,URL_user_login) parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        if ([[responseObject[@"code"] stringValue] isEqualToString:@"200"]) {
            self.curUserInfo = [UserInfo yy_modelWithDictionary:responseObject[@"data"]];
            [self saveUserInfo];
            [[TuyaSmartUser sharedInstance] loginByEmail:@"86" email:[params objectForKey:@"userName"] password:aesDecryptString([params objectForKey:@"password"], AES_KEY) success:^{
                [self LoginSuccess:responseObject completion:completion];
            } failure:^(NSError *error) {
                [MBProgressHUD hideHUD];
                if (completion) {
                    completion(NO,error.localizedDescription);
                }
            }];
        } else {
            [UIViewController jaf_showHudTip:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        if (completion) {
            completion(NO,error.localizedDescription);
        }
    }];
}

#pragma mark ————— 自动登录到服务器 —————
-(void)autoLoginToServer:(loginBlock)completion{
//    [MBProgressHUD showActivityMessageInView:@"登录中..."];
//    [[TuyaSmartUser sharedInstance] loginOrRegisterWithCountryCode:@"86" uid:[UserManager sharedUserManager].curUserInfo.email password:[UserManager sharedUserManager].curUserInfo.password createHome:YES success:^(id result) {
//        NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
//        [mDic setObject:[UserManager sharedUserManager].curUserInfo.password forKey:@"password"];
//        [mDic setValuesForKeysWithDictionary:result];
//        [self LoginSuccess:mDic completion:completion];
//    } failure:^(NSError *error) {
//        [MBProgressHUD hideHUD];
//        if (completion) {
//            completion(NO,error.localizedDescription);
//        }
//    }];
    
//    [PPNetworkHelper POST:NSStringFormat(@"%@%@",URL_main,URL_user_auto_login) parameters:nil success:^(id responseObject) {
//        [self LoginSuccess:responseObject completion:completion];
//    } failure:^(NSError *error) {
//        if (completion) {
//            completion(NO,error.localizedDescription);
//        }
//    }];
}

#pragma mark ————— 登录成功处理 —————
-(void)LoginSuccess:(id )responseObject completion:(loginBlock)completion{
    if (ValidDict(responseObject)) {
        if (ValidDict(responseObject[@"data"])) {
            NSDictionary *data = responseObject[@"data"];
            if (ValidStr(data[@"easemobId"]) && ValidStr(data[@"easemobUserName"])) {
                //登录IM
                [[IMManager sharedIMManager] IMLogin:data[@"easemobUserName"] IMPwd:aesDecryptString(data[@"easemobPassword"], AES_KEY) completion:^(BOOL success, NSString *des) {
                    [MBProgressHUD hideHUD];
                    if (success) {
                        self.isLogined = YES;
                        if (completion) {
                            completion(YES,nil);
                        }
//                        KPostNotification(KNotificationLoginStateChange, @YES);
                    }else{
                        if (completion) {
                            completion(NO,des);
                        }
//                        KPostNotification(KNotificationLoginStateChange, @NO);
                    }
                }];
            }
            else{
                if (completion) {
                    completion(NO,@"登录返回数据异常");
                }
                KPostNotification(KNotificationLoginStateChange, @NO);
            }
        }
    }else{
        if (completion) {
            completion(NO,@"登录返回数据异常");
        }
        KPostNotification(KNotificationLoginStateChange, @(kUserLoginStatusNotLoggedIn));
    }
}

#pragma mark ————— 储存用户信息 —————
-(void)saveUserInfo{
    if (self.curUserInfo) {
       [[YYCache cacheWithName:KUserCacheName] removeAllObjects];
        
        YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
        NSDictionary *dic = [self.curUserInfo yy_modelToJSONObject];
        [cache setObject:dic forKey:KUserModelCache];
    }
}

#pragma mark ————— 加载缓存的用户信息 —————
-(BOOL)loadUserInfo{
    YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
    NSDictionary * userDic = (NSDictionary *)[cache objectForKey:KUserModelCache];
    if (userDic) {
        self.curUserInfo = [UserInfo yy_modelWithJSON:userDic];
        return YES;
    }
    return NO;
}

#pragma mark ————— 被踢下线 —————
-(void)onKick{
    [self logout:nil];
}
#pragma mark ————— 退出登录 —————
- (void)logout:(void (^)(BOOL, NSString *))completion{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationLogout object:nil];//被踢下线通知用户退出直播间
    
    [ABLoginInterface login_loginExitLoginWithParams:@{@"token":[UserManager sharedUserManager].curUserInfo.token} success:^(id  _Nonnull responseObject) {
        DLog(@"logOut success");
    }];
    
    [[IMManager sharedIMManager] IMLogout];
    self.curUserInfo = nil;
    self.isLogined = NO;

    [[TuyaSmartUser sharedInstance] loginOut:^{
        DLog(@"logOut success");
    } failure:^(NSError *error) {
        DLog(@"logOut failure: %@", error);
    }];
    
//    //移除缓存
    YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
    [cache removeAllObjectsWithBlock:^{
        if (completion) {
            completion(YES,nil);
        }
    }];
    
    YYCache *deviceCache = [[YYCache alloc]initWithName:KDeviceCacheName];
    [deviceCache removeAllObjectsWithBlock:^{
        if (completion) {
            completion(YES,nil);
        }
    }];
    
    KPostNotification(KNotificationLoginStateChange, @(kUserLoginStatusNotLoggedIn));
}
@end
