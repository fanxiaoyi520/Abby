//
//  TYSDKUtil.h
//  TuyaSmartUtil
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com)
//

#import <Foundation/Foundation.h>

void tysdk_dispatch_async_on_default_global_thread(dispatch_block_t block);
void tysdk_dispatch_async_on_main_thread(dispatch_block_t block);
void tysdk_dispatch_sync_on_main_thread(dispatch_block_t block);


extern void __ty_defer__(__strong void (^*operation)(void));

#ifndef tyDefer
#define __ty_defer_var_v__(X, Y) X##Y
#define __ty_defer_var_m__(X, Y) __ty_defer_var_v__(X, Y)
#define tyDefer \
        __strong void(^ __ty_defer_var_m__(_ty_defer_var , __COUNTER__ ))(void) __attribute__((cleanup(__ty_defer__), unused)) = ^
#endif


@interface TYSDKUtil : NSObject

#if TARGET_OS_IOS

+ (NSString *)tysdk_currentWifiSSID;

+ (NSString *)tysdk_currentWifiBSSID;

#endif

+ (uint32_t)tysdk_getIntValueByHex:(NSString *)str;

+ (NSString *)tysdk_getISOcountryCode;

+ (BOOL)tysdk_compareVesionWithDeviceVersion:(NSString *)deviceVersion appVersion:(NSString *)appVersion;

+ (NSData *)tysdk_xorEncodeData:(NSData *)sourceData keyData:(NSData *)keyData;

@end


extern NSString * const TYUtilHostAppExtensionString;
extern NSString * const TYUtilTodayWidgetExtensionString;
extern NSString * const TYUtilIntentExtensionString;
extern NSString * const TYUtilIntentUIExtensionString;
extern NSString * const TYUtilWatchKitExtensionString;

/**
 Recursively removes `NSNull` values from a JSON object.
*/
FOUNDATION_EXPORT id TYJSONObjectByRemovingKeysWithNullValues(id JSONObject, NSJSONReadingOptions readingOptions);

/**
 *  @category TYUtil(AppExtension)
 *  Checks the process in which the program runs (App/AppExtension/WatchKitExtension).
 */
@interface TYSDKUtil (AppSDKExtension)

+ (NSString *)tysdk_currentExtensionString;

+ (BOOL)tysdk_isHostApp;

+ (BOOL)tysdk_isAppExtension;

+ (BOOL)tysdk_isWatchKitExtension;

@end
