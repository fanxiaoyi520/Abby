//
// TuyaSmartBLEManager.h
// TuyaSmartBLEKit
//
// Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com)

#import <Foundation/Foundation.h>
#import "TYBLEAdvModel.h"
#import <TuyaSmartUtil/TuyaSmartUtil.h>
#import "TYBLEDeviceInfoProtocol.h"

typedef enum : NSUInteger {
    /// Is OTA controllable.
    TuyaSmartBLECapabilityOTAControlled = 0,
} TuyaSmartBLECapability;


typedef NS_ENUM(NSInteger,TYBLEScanType){
    TYBLEScanTypeNoraml = 1 << 0, //  0001  1
    TYBLEScanTypeQRCode = 1 << 1, //  0010  2
};

NS_ASSUME_NONNULL_BEGIN

typedef void (^TYBLEBigDataProgressBlock)(float progress);

@class TuyaSmartBLEManager;

/// The delegate for scanning and notifications of Bluetooth status changes.
@protocol TuyaSmartBLEManagerDelegate <NSObject>

@optional

/// The notification for Bluetooth status changes.
///
/// @param isPoweredOn      Indicates the Bluetooth status. Valid values: `on` and `off`.
- (void)bluetoothDidUpdateState:(BOOL)isPoweredOn;

/// The result of disconnecting the device.
///
/// @param devId        The device ID.
/// @param error        An error occurs while processing the request.
- (void)onCentralDidDisconnectFromDevice:(NSString *)devId error:(NSError *)error;

/// The result of scanning inactive devices.
///
/// @param uuid         The device UUID.
/// @param productKey   The product ID for the device.
/// @deprecated This method is deprecated. Use TuyaSmartBLEManager::didDiscoveryDeviceWithDeviceInfo: instead.
- (void)didDiscoveryDeviceWithUUID:(NSString *)uuid productKey:(NSString *)productKey __deprecated_msg("This method is deprecated, Use TuyaSmartBLEManager::didDiscoveryDeviceWithDeviceInfo: instead");

/// The result of scanning inactive devices.
///
/// @param deviceInfo   The advertisingData model for the inactive device.
- (void)didDiscoveryDeviceWithDeviceInfo:(TYBLEAdvModel *)deviceInfo;


/// The result of activating Bluetooth LE devices.
///
/// @param manager          The class.
/// @param deviceModel      Called when the task is finished. DeviceModel is returned.
/// @param error            Called when the task is interrupted by an error.
- (void)bleManager:(TuyaSmartBLEManager *)manager didFinishActivateDevice:(nullable id)deviceModel error:(nullable NSError *)error;

/// Receives the transmission data from the device.
///
/// @param data     Transmission data that is sent by the device.
/// @param devId    The device ID.
- (void)bleReceiveTransparentData:(NSData *)data devId:(NSString *)devId;
@end

/// @brief TuyaSmartBLEManager provides methods to manage Bluetooth LE devices by using multiple functions, such as activation, device control, and OTA updates.
///
/// The types of OTA updates: firmware and MCU.
@interface TuyaSmartBLEManager : NSObject

/// The single instance.
+ (instancetype)sharedInstance;

/// A Boolean value that indicates whether the mobile phone's Bluetooth is enabled or disabled.
@property (nonatomic, assign, readonly) BOOL isPoweredOn;

/// The delegate for scanning and notifications of Bluetooth status changes.
@property (nonatomic, weak) id<TuyaSmartBLEManagerDelegate> delegate;

@property (nonatomic, copy) TYFailureHandler failureHandler;

typedef void (^TYBLEScanHandler)(id<TYBLEDeviceInfoProtocol> devInfo, BOOL isWillRestoreState);

@property (nonatomic, copy) void (^success)(id deviceModel);

- (BOOL)checkBLEStatus;


/// 开始设备扫描
/// @param cache 是否清理已扫描到的设备
/// @param handler 设备扫描之后需要处理的业务功能
/// @param notify 接收蓝牙业务回调
/// @param scanType 扫描类型
- (void)startListenCore:(BOOL)cache
                handler:(nullable TYBLEScanHandler)handler
           configNotify:(id<TuyaSmartBLEConfigPackageNotify>)notify
               scanType:(TYBLEScanType)scanType;

- (void)stopListenCore:(BOOL)clearCache;

- (void)setScanDelegate:(id)delegate;

- (void)connectWithDeviceInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo localKey:(NSString *)localKey;

- (void)forceDeleteWithDeviceInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;


- (void)connectWithUUID:(NSString *)uuid
             capability:(NSUInteger)capability
              productId:(NSString *)productId
               localKey:(NSString *)localKey
            configMetas:(NSDictionary *)configMetas
        handlerDelegate:(id<TuyaSmartBLEActiveDelegate>)handlerDelegate
            scanHandler:(nullable TYBLEScanHandler)handler
                success:(nullable TYSuccessHandler)success
                failure:(nullable TYFailureHandler)failure;

/// Disconnect device
///
/// @param uuid         The UUID for the device.
/// @param success      When disconnect successfully, this block will be called success.
/// @param failure      This block will be called if some error occurred.
- (void)disconnectWithUUID:(NSString *)uuid
                   success:(nullable TYSuccessHandler)success
                   failure:(nullable TYFailureError)failure;

/// Active device
- (void)activeBLEWithDevice:(id<TYBLEDeviceInfoProtocol>)deviceInfo
            handlerDelegate:(id<TuyaSmartBLEActiveDelegate>)handlerDelegate;


/// Publish the transmitted data.
///
/// @param uuid         The UUID for the device.
/// @param data         Data to be transmitted to the device.
/// @param success      Transmission data returned by the device.
/// @param failure      This block will be called if some error occurred.
- (void)publishBleTransparentDataWithUUID:(NSString *)uuid
                                     data:(NSData *)data
                                  success:(nullable TYSuccessData)success
                                  failure:(nullable TYFailureError)failure;

/// Query device dp data by Bluetooth channel.
///
/// @param uuid             The UUID for the device.
/// @param dpsData      Array of dpId's to be queried.
/// @param success      When query successfully, this block will be called.
/// @param failure      This block will be called if some error occurred.
- (void)publishQueryDpCommandWithUUID:(NSString *)uuid
                              dpsData:(NSMutableData *)dpsData
                              success:(nullable TYSuccessBOOL)success
                              failure:(nullable TYFailureError)failure;

/// Get Bluetooth device capability value.This method is used to analyze the Bluetooth capability of the device.
/// @param i Enumeration value of Bluetooth capability to be obtained
/// @param hex The ability to analyze
- (BOOL)bleCapabilityIsSupport:(TuyaSmartBLECapability)i hex:(NSString *)hex;


- (void)sendPacketInfoWithDev:(id<TYBLEDeviceInfoProtocol>)dev
                         data:(NSData *)data
                         type:(TYBLEConfigType)type
               packageMaxSize:(NSInteger)maxSize
                      success:(nullable TYSuccessHandler)success
                      failure:(nullable TYFailureError)failure;

- (BOOL)pairBLEAdvertisingData:(NSData *)advertisingData;

@end

NS_ASSUME_NONNULL_END
