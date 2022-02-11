//
//  AppDelegate+PushService.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/25.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "AppDelegate+PushService.h"

@implementation AppDelegate (PushService)
// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
     [[HDClient sharedClient] bindDeviceToken:deviceToken];
    [JPUSHService registerDeviceToken:deviceToken];
}

// 注册deviceToken失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"error -- %@",error);
}
@end
