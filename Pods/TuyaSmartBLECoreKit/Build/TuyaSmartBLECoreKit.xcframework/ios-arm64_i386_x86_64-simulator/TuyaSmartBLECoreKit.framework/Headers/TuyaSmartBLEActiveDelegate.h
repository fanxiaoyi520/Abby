//
//  TuyaSmartBLEActiveDelegate.h
//  Pods
//
//  Created by yuguo on 2021/4/25.
//

#ifndef TuyaSmartBLEActiveDelegate_h
#define TuyaSmartBLEActiveDelegate_h

#import "TYBLEDeviceInfoProtocol.h"
#import "TYBLEAdvModel.h"
#import <TuyaSmartUtil/TuyaSmartUtil.h>
#import "TuyaSmartBLECoreEnums.h"
#import "TYBLEDevInfo.h"

typedef NS_ENUM(NSUInteger, TuyaSmartBLEEncKeyType) {
    TuyaSmartBLEEncKeyTypeActive = 1, //!< 激活时秘钥
    TuyaSmartBLEEncKeyTypeRemove, //!< 移除时秘钥
};

NS_ASSUME_NONNULL_BEGIN

@protocol TYBLEDeviceInfoProtocol;
/// 用于处理解耦后的BLEKitCore在激活/解绑阶段想要的一些数据回调，比如秘钥、注册的gid等等，回头要拆到public里
@protocol TuyaSmartBLEActiveDelegate <NSObject>

@optional

/// 激活、解绑过程传递秘钥给 SDK
/// @param advModel 设备信息
/// @param encKeyType 激活、解绑
/// @param handler 业务层使用handler传递秘钥给SDK
/// @param error error
- (void)transEncKeyWithAdvModel:(TYBLEAdvModel *)advModel
                     encKeyType:(TuyaSmartBLEEncKeyType)encKeyType
                        handler:(nullable void(^)(id _Nullable key))handler
                        failure:(nullable TYFailureError)error;

/// 注册设备到云端
- (void)registerToServe:(NSString *)uuid devId:(nullable NSString *)devId encryptedAuthKey:(NSString *)encryptedAuthKey productKey:(NSString *)productKey pv:(NSString *)pv sv:(NSString *)sv mac:(nullable NSString *)mac isRegisterKey:(BOOL)isRegisterKey isShare:(BOOL)isShare options:(NSDictionary *)options success:(TYSuccessDict)success failure:(TYFailureError)failure;

- (void)validateBLEBeaconCapability:(nullable TYBLESecurityDevInfo *)devInfo;

/// 激活流程加签
/// @param deviceInfo 设备信息
/// @param success success
/// @param failure failure
- (void)handleChipEncrypt:(id<TYBLEDeviceInfoProtocol>)deviceInfo
                  success:(TYSuccessHandler)success
                  failure:(TYFailureError)failure;

/// 同步设备信息，业务根据 devId 获取 device 并处理后传递给 SDK
/// @param devId devId
/// @param handler 业务层使用 handler 传递 device 给SDK
/// @param error error
- (void)syncDeviceInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo
                 devId:(NSString *)devId
               handler:(nullable TYSuccessID)handler
               failure:(nullable TYFailureError)error;

/// 激活失败
/// @param devId 设备id
- (void)activeFailed:(NSString *)devId;

/// 设备解绑
/// @param deviceInfo 设备信息
/// @param handler handler
/// @param error error
- (void)unbindDevice:(id<TYBLEDeviceInfoProtocol>)deviceInfo
             handler:(nullable TYSuccessHandler)handler
             failure:(nullable TYFailureHandler)error;

/// 更新设备信息
/// @param deviceInfo 设备信息
- (void)updateDeviceInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo;

/// 上报dp点
- (void)reportDps:(NSDictionary *)dps devId:(NSString *)devId dpsTime:(NSString *)dpsTime mode:(NSUInteger)mode reportType:(NSUInteger)type;

/// 更新OTA信息
/// @param deviceInfo 设备信息
/// @param otaType OTA类型
/// @param otaVersion OTA版本
- (void)updateOTAVersion:(id<TYBLEDeviceInfoProtocol>)deviceInfo otaType:(TuyaSmartBLEOTAType)otaType otaVersion:(NSString *)otaVersion;

/// 更新设备在线状态
/// @param deviceInfo 设备信息
/// @param isOnline 是否在线
- (void)updateBLEOnlineStatus:(id<TYBLEDeviceInfoProtocol>)deviceInfo isOnline:(BOOL)isOnline;

/// 发现大数据通道
/// @param deviceInfo 设备信息
/// @param services services
- (void)discoverBleChannel:(id<TYBLEDeviceInfoProtocol>)deviceInfo services:(NSArray *)services;

@end

NS_ASSUME_NONNULL_END

#endif /* TuyaSmartBLEActiveDelegate_h */
