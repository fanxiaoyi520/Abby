//
//  TYBLEConfigProtocol.h
//  Pods
//
//  Created by 温明妍 on 2020/1/7.
//

#ifndef TYBLEConfigProtocol_h
#define TYBLEConfigProtocol_h

#import "TYBLECryptologyProtcol.h"
#import "TYBLEWriteNotifyProtocol.h"
#import "TuyaSmartBLEActiveDelegate.h"
#import "TuyaSmartBLEConfigPackageNotify.h"
#import "TuyaSmartBLEManager.h"

@protocol TYBLEDeviceInfoProtocol;
@protocol TYBLECryptologyProtcol;
@protocol TYBLEWriteNotifyProtocol;
@protocol TYBLEConfigProtocol;

typedef enum : NSUInteger {
    TYBLESubPackageStatus_AllSuccess = 0,
    TYBLESubPackageStatus_CurrentSuccess,
    TYBLESubPackageStatus_CurrentFailure,
    TYBLESubPackageStatus_Failure,
} TYBLESubPackageStatus;

@protocol TYBLEConfigProtocol <NSObject>

@property (nonatomic, weak) id<TYBLEDeviceInfoProtocol> deviceInfo;
/// 用于对控制命令编解码
@property (nonatomic, strong) id<TYBLECryptologyProtcol> cryptologyManager;
/// 用于下发指令
@property (nonatomic, strong) id<TYBLEWriteNotifyProtocol> writeNotifyManager;

/// 中间过程要外部补充数据的代理
@property (nonatomic, weak) id<TuyaSmartBLEActiveDelegate> handlerDelegate;

/// 用于向业务层抛出收到的蓝牙包
@property (nonatomic, weak) id<TuyaSmartBLEConfigPackageNotify> packageNotify;


/// 向蓝牙设备发送控制指令
/// @param deviceInfo deviceInfo
/// @param type type
/// @param data 控制指令内容
/// @param success success
/// @param failure failure
- (void)publishCommandWithDeviceInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo
                                type:(TYBLEConfigType)type
                                data:(NSData *)data
                             success:(TYSuccessData)success
                             failure:(TYFailureError)failure;

/// 向蓝牙设备发送 dp 点
/// @param deviceInfo deviceInfo
/// @param dps dps
/// @param success success
/// @param failure failure
- (void)publishDpsWithDeviceInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo
                             dps:(NSDictionary *)dps
                             success:(TYSuccessHandler)success
                             failure:(TYFailureError)failure;

///// 接收蓝牙设备上报的控制指令
///// @param deviceInfo deviceInfo
///// @param type TYBLEConfigType
///// @param data 控制指令内容
///// @param success success
///// @param failure failure
//- (void)receiveCommandWithDeviceInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo
//                                type:(TYBLEConfigType)type
//                                data:(NSData *)data
//                             success:(TYSuccessData)success
//                             failure:(TYFailureError)failure;

/// 连接设备
/// @param deviceInfo deviceInfo
/// @param localKey localKey
/// @param success success
/// @param failure failure
- (void)connectWithDeviceInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo
                     localKey:(NSString *)localKey
                      success:(TYSuccessHandler)success
                      failure:(TYFailureError)failure;

/// 断开连接
/// @param deviceInfo deviceInfo
/// @param success success
/// @param failure failure
- (void)disconnectWithDeviceInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo
                         success:(TYSuccessHandler)success
                         failure:(TYFailureError)failure;


/// 移除设备
/// @param deviceInfo deviceInfo
/// @param success success
/// @param failure failure
- (void)removeWithDeviceInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo
                     success:(TYSuccessHandler)success
                     failure:(TYFailureError)failure;

/// 恢复出厂设置
/// @param deviceInfo deviceInfo
/// @param success success
/// @param failure failure
- (void)resetWithDeviceInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo
                    success:(TYSuccessHandler)success
                    failure:(TYFailureError)failure;

/// 发送OTA包，升级固件   升级前请务必保证设备已通过蓝牙连接
/// @param deviceInfo  deviceInfo
/// @param otaData     升级固件的数据
/// @param otaType     升级类型
/// @param otaVersion  升级版本
/// @param success     success
/// @param failure     failure
- (void)sendOTAPackWithDeviceInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo
                          otaData:(NSData *)otaData
                          otaType:(TuyaSmartBLEOTAType)otaType
                       otaVersion:(NSString *)otaVersion
                          success:(TYSuccessHandler)success
                          failure:(TYFailureError)failure;

/// 强制移除设备
/// @param deviceInfo deviceInfo
/// @param success success
/// @param failure failure
- (void)forceDeleteWithDeviceInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo
                          success:(TYSuccessHandler)success
                          failure:(TYFailureError)failure;


/// 发送透传数据（分包）
/// @param dev  deviceInfo
/// @param type   type
/// @param data   透传数据
/// @param success   success
/// @param failure   failure
- (void)publishIoTTransparentDataWithDeviceInfo:(id<TYBLEDeviceInfoProtocol>)dev
                                     type:(TYBLEConfigType)type
                                     data:(NSData *)data
                                  success:(TYSuccessHandler)success
                                  failure:(TYFailureError)failure;

/// 发送透传数据（可分包）
/// @param dev  deviceInfo
/// @param data   透传数据
/// @param success   success
/// @param failure   failure
- (void)publishTransparentDataWithDeviceInfo:(id<TYBLEDeviceInfoProtocol>)dev
                                     data:(NSData *)data
                                  success:(TYSuccessHandler)success
                                  failure:(TYFailureError)failure;



/// 处理 dp 上报
- (void)handleDpData:(NSData *)data
             ackData:(nullable NSData *)ackData
                type:(int)type
             dpsTime:(NSString *)dpsTime
          reportMode:(NSUInteger)mode;

/// 处理带时间戳的 dp 上报
- (void)handleDPTimeRequest:(NSString *)dataHexString
                    ackData:(nullable NSData *)ackData
            withCommandType:(int)type
                 reportMode:(NSUInteger)mode;

/// IoT数据通道
- (void)handleIoTTransparentData:(NSData *)data
                    businessData:(NSData *)businessData;

- (void)handleTransparentData:(NSData *)data;
@end

#endif /* TYBLEConfigProtocol_h */
