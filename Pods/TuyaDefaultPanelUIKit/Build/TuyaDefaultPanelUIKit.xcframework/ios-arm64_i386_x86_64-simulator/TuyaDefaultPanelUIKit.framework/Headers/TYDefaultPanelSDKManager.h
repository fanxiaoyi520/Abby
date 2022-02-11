//
//  TYDefaultPanelSDKManager.h
//  TuyaDefaultPanelUI
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)

#import <Foundation/Foundation.h>
@class TYDefaultPanelModel;

#define TYPanelRGBHexAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define TYPanelWeakSelf(type) __weak typeof(type) weak##type = type;
#define TYPanelStrongSelf(type) __strong typeof(weak##type) strong##type = weak##type;

NS_ASSUME_NONNULL_BEGIN

@interface TYDefaultPanelSDKManager : NSObject

+ (TYDefaultPanelSDKManager *)sharedInstance;
@property (nonatomic, strong) UIColor *themeColor;
@property (nonatomic, strong) TYDefaultPanelModel *model;
@property (nonatomic, copy) NSString *confirm;
@property (nonatomic, copy) NSString *cancel;

+ (NSString *)dpValueEncodeWithDP:(NSString *)dp position:(NSInteger)position;

@end

NS_ASSUME_NONNULL_END
