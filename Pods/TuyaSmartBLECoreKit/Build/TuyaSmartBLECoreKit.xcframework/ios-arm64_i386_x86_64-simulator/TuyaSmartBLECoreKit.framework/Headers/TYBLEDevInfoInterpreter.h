//
//  TYBLEDevInfoInterpreter.h
//  TuyaSmartBLEKit
//
//  Created by 吴戈 on 2019/7/18.
//

#import <Foundation/Foundation.h>
#import "TYBLEDevInfo.h"

typedef enum : NSUInteger {
    TYBLEAdvEncryptAuthkey              = 00,
    TYBLEAdvEncryptECC                  = 01,
    TYBLEAdvEncryptPassthrough          = 02, ///
    TYBLEAdvEncryptCompress             = 03, /// PID 加密 需要压缩 pid （在 4.0 以上协议无效）
    TYBLEAdvEncryptAdvance              = 04, /// 高级加密
    TYBLEAdvEncryptQRCode               = 05, /// 只支持扫码配网的基于auth key和device id的一般加密设备
} TYBLEAdvEncryptMode;

typedef enum : NSUInteger {
    TYBLEAdvProductId            = 00,
    TYBLEAdvProductKey           = 01,
} TYBLEAdvProductType;


@interface FrameControlModel : NSObject

@property (nonatomic, assign) BOOL               timestampInclude;  /// 是否包含时间戳
@property (nonatomic, assign) BOOL               dpDataEncrypted;   /// dp data 是否加密
@property (nonatomic, assign) BOOL               dpDataInclude;     ///是否包含 dp data，如果为 1 需同时包含 Frame Counter，如 果加密还需要包含 MIC 字段。
@property (nonatomic, assign) BOOL               idInclude;         /// 是否包含 id 字段
@property (nonatomic, assign) BOOL               requestConnection; /// 是否请求连接
@property (nonatomic, assign) BOOL               sharedFlag;        /// 是否为共享类设备
@property (nonatomic, assign) BOOL               boundFlag;         /// 是否绑定
@property (nonatomic, strong) NSString           *version;          /// 设备版本号

@end


@interface TYBLEDevInfoInterpreter : NSObject

/**
 *  解析单点设备的广播包
 */
+ (TYBLEAdvModel *)getBLEDeviceBroadcastInfo:(TYBLEPeripheral *)p;

/**
 *  通过设备返回的 data 解析成老协议的设备信息 Model
 */
+ (TYBLEDevInfo *)getBaseDevInfo:(NSString *)hexStr withUUID:(NSString *)uuid;


+ (TYBLEDevInfo *)getPlusDevInfo:(NSString *)hexStr withUUID:(NSString *)uuid;

/**
 *  通过设备返回的 data 解析成安全协议的设备信息 Model
 */
+ (TYBLESecurityDevInfo *)getSecurityDevInfo:(NSString *)hexStr;


/**
 *  通过设备返回的 data 解析成 PlugPlay 设备信息 Model
 */
+ (TYBLEPlugPlayDevInfo *)getPlugPlayDeviceInfo:(NSString *)hexStr;


/// 通过设备广播包判断是否支持多用户场景（即共享类设备）
+ (BOOL)deviceSupportMultiUser:(TYBLEPeripheral *)p;

+ (FrameControlModel *)frameControlResolution:(NSString *)data;

@end
