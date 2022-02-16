//
//  AppManager.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/21.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "AppManager.h"
#import "AdPageView.h"
#import "RootWebViewController.h"
#import "XHLaunchAd.h"
@implementation AppManager


+(void)appStart{

    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];

    //配置广告数据
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration defaultConfiguration];
    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    imageAdconfiguration.imageNameOrURLString = @"qidong.gif";
    imageAdconfiguration.GIFImageCycleOnce = YES;
    imageAdconfiguration.skipButtonType = SkipTypeNone;
    imageAdconfiguration.duration = 2;
    //显示图片开屏广告
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
}

@end
