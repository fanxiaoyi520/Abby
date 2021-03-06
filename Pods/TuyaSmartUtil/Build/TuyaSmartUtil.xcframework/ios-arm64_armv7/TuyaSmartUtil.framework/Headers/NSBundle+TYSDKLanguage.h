//
//  NSBundle+TYSDKLanguage.h
//  TuyaSmartUtil
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com)
//

#import <Foundation/Foundation.h>

#define TYSDKLocalizedString(key, comment) \
    [NSBundle tysdk_localizedStringForKey:(key) value:@"" table:nil]

@interface NSBundle (TYSDKLanguage)

+ (NSBundle *)tysdk_bundle;

+ (NSString *)tysdk_getAppleLanguages;

+ (NSString *)tysdk_localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName;

@end
