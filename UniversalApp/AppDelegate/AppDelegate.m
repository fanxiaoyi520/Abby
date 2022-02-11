//
//  AppDelegate.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/17.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    AppDelegate *myDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if(kScreenHeight > 480){ // 这里以(iPhone4S)为准
        myDelegate.autoSizeScaleX = kScreenWidth/320;
        myDelegate.autoSizeScaleY = kScreenHeight/568;
    }else{
        myDelegate.autoSizeScaleX = 1.0;
        myDelegate.autoSizeScaleY = 1.0;
    }

    //初始化window
    [self initWindow];
//    [self loadStartupDiagram];
    
    //初始化网络请求配置
    [self NetWorkConfig];
    
    //UMeng初始化
    [self initUMeng];
    
    //TuyaSmartSDK初始化
    [self initTuyaSmartSDK];
    //初始化app服务
    [self initService];
    
    //创建极光推送
    [self initAuroraPush:launchOptions];
    
    //初始化IM
    [[IMManager sharedIMManager] initIM];
    
    //初始化用户系统
    [self initUserManager];
    
    //网络监听
    [self monitorNetworkStatus];
    
    //广告页
    [AppManager appStart];

    
    // 添加Voip权限
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    PKPushRegistry *voipRegistry = [[PKPushRegistry alloc] initWithQueue:mainQueue];
    voipRegistry.delegate = self;
    // Set the push type to VoIP
    voipRegistry.desiredPushTypes = [NSSet setWithObject:PKPushTypeVoIP];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



// MARK: - PKPushRegistryDelegate
/// 系统返回VoipToken,上报给极光服务器
- (void)pushRegistry:(PKPushRegistry *)registry didUpdatePushCredentials:(PKPushCredentials *)pushCredentials forType:(PKPushType)type{
    [JPUSHService registerVoipToken:pushCredentials.token];
}

- (void)pushRegistry:(PKPushRegistry *)registry didReceiveIncomingPushWithPayload:(PKPushPayload *)payload forType:(PKPushType)type{
  // 提交回执给极光服务器
  [JPUSHService handleVoipNotification:payload.dictionaryPayload];
}

- (void)pushRegistry:(PKPushRegistry *)registry didReceiveIncomingPushWithPayload:(PKPushPayload *)payload forType:(PKPushType)type withCompletionHandler:(void(^)(void))completion{
  // 提交回执给极光服务器
  [JPUSHService handleVoipNotification:payload.dictionaryPayload];
}
@end
