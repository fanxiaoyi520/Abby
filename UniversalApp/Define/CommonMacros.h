//
//  CommonMacros.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/31.
//  Copyright © 2017年 徐阳. All rights reserved.
//

//全局标记字符串，用于 通知 存储

#ifndef CommonMacros_h
#define CommonMacros_h

#pragma mark - ——————— 用户相关 ————————
//登录状态改变通知
#define KNotificationLoginStateChange @"loginStateChange"

//tabbar改变通知
#define KNotificationTabbarStateChange @"tabbarStateChange"

//自动登录成功
#define KNotificationAutoLoginSuccess @"KNotificationAutoLoginSuccess"

//被踢下线
#define KNotificationOnKick @"KNotificationOnKick"

//用户信息缓存 名称
#define KUserCacheName @"KUserCacheName"

//dps信息缓存 名称
#define KDpsCacheName @"KDpsCacheName"

//设备信息缓存 名称
#define KDeviceCacheName @"KDeviceCacheName"

//用户model缓存
#define KUserModelCache @"KUserModelCache"
//dps缓存
#define KDpsModelCache @"KDpsModelCache"
//设备model缓存
#define KDeviceModelCache @"KDeviceModelCache"


#pragma mark - ——————— 网络状态相关 ————————

//网络状态变化
#define KNotificationNetWorkStateChange @"KNotificationNetWorkStateChange"

#pragma mark - ——————— 数据库相关 ————————
#define DBName_DPS @"dps.sqlite"

#endif /* CommonMacros_h */
