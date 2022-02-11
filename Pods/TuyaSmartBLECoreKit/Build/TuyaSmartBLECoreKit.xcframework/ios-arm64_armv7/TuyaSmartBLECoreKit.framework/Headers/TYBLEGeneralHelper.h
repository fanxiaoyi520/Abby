//
//  TYBLEGeneralHelper.h
//  TuyaSmartBLECoreKit
//
//  Created by 余豪 on 2021/6/24.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TYBLESupportConnect) {
    TYBLESupportConnect_DEFAULT   = 1,   /// 默认连接(未配置)
    TYBLESupportConnect_REQUEST   = 2,   /// 按需连接
    TYBLESupportConnect_KEEP      = 3,   /// 保持连接
    TYBLESupportConnect_NONEED    = 4,   /// 不连接
};

typedef NS_ENUM(NSUInteger, TYBLESupportDisconnect) {
    TYBLESupportDisconnect_INTIME               = 1,    /// 及时断连
    TYBLESupportDisconnect_REQUEST              = 2,    /// 按需断连
    TYBLESupportDisconnect_DEFAULT              = 3,    /// 不断连(未配置)
    TYBLESupportDisconnect_INTIME_REQUEST       = 4,    /// 退出面板/ app 退到后台 30s 断连
};

NS_ASSUME_NONNULL_BEGIN

@interface TYBLEGeneralHelper : NSObject

+ (TYBLESupportConnect)configConnect:(NSDictionary *)configMetas;

+ (TYBLESupportDisconnect)configDisconnect:(NSDictionary *)configMetas;

+ (NSString *)string2JSONString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
