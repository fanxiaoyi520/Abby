//
//  UIViewController+Common.m
//  teamwork
//
//  Created by 张俊彬 on 2019/9/2.
//  Copyright © 2019 Zhengzhou Yutong Bus Co.,Ltd. All rights reserved.
//

#import "UIViewController+Common.h"
#import "AppDelegate.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>


@implementation UIViewController (Common)

+ (UIViewController *)presentingVC{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    return result;
}

+(UIViewController *)getCurrentVC{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
    
}
+(UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
    
}

+(BOOL)jaf_isBackgroudState{
    if([UIApplication sharedApplication].applicationState == UIApplicationStateBackground){
           return YES;
       }else{
           return NO;
       }
}


+(void)jaf_setDarkStatusBar{
    if (@available(iOS 13.0, *)) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDarkContent];
    } else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
}

+(void)jaf_setLightStatusBar{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

+(UIStatusBarStyle)jaf_getDarkStatusBar{
    if (@available(iOS 13.0, *)) {
        return UIStatusBarStyleDarkContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

+(UIStatusBarStyle)jaf_getLightStatusBar{
    return UIStatusBarStyleLightContent;
}

+(void)jaf_showHudTip:(NSString*)tipStr{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (tipStr && tipStr.length > 0) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
            hud.userInteractionEnabled = NO;
            hud.mode = MBProgressHUDModeText;
            hud.detailsLabelText = tipStr;
            hud.margin = 14.f;
            hud.detailsLabelFont = [UIFont systemFontOfSize:14.0f];
            hud.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:.85];
            hud.detailsLabelColor = [UIColor whiteColor];
            hud.removeFromSuperViewOnHide = YES;
            hud.cornerRadius = 5.0;
            [hud hide:YES afterDelay:1.5];
        }
    });
}

@end
