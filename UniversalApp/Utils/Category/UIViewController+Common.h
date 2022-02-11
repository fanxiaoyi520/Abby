//
//  UIViewController+Common.h
//  teamwork
//
//  Created by 张俊彬 on 2019/9/2.
//  Copyright © 2019 Zhengzhou Yutong Bus Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Common)

+ (UIViewController *)presentingVC;
+(UIViewController *)getCurrentVC;
+(BOOL)jaf_isBackgroudState;
-(BOOL)jaf_isTbbarRootController;
+(void)jaf_setDarkStatusBar;
+(void)jaf_setLightStatusBar;
+(UIStatusBarStyle)jaf_getDarkStatusBar;
+(UIStatusBarStyle)jaf_getLightStatusBar;
+(void)jaf_showHudTip:(NSString*)tipStr;

@end

