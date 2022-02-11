//
//  TuyaSmartBLEManager+OTA.h
//  TuyaSmartBLEKit
//
//  Created by yuguo on 2021/5/15.
//

#import <TuyaSmartBLECoreKit/TuyaSmartBLEManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartBLEManager (OTA)

/// Sends an OTA package to update the firmware.
///
/// The value of `otaData` can be obtained from TuyaSmartFirmwareUpgradeModel. You can get TuyaSmartFirmwareUpgradeModel by using TuyaSmartDevice::getFirmwareUpgradeInfo:failure:.
///
/// @note Your device must be connected over Bluetooth before the update.
///
/// @param uuid         The UUID of the device.
/// @param otaData      The OTA package data.
/// @param success      Called when the task is finished.
/// @param failure      Called when the task is interrupted by an error.
///
/// @deprecated This method is deprecated, Use TuyaSmartBLEManager::sendOTAPack:deviceModel:upgradeModel:success:failure: instead.
- (void)sendOTAPack:(NSString *)uuid
            otaData:(NSData *)otaData
            success:(TYSuccessHandler)success
            failure:(TYFailureHandler)failure __deprecated_msg("This method is deprecated, Use TuyaSmartBLEManager::sendOTAPack:deviceModel:upgradeModel:success:failure: instead");

/// Sends an OTA package to update the firmware.
///
/// The value of `otaData` can be obtained from TuyaSmartFirmwareUpgradeModel. You can get TuyaSmartFirmwareUpgradeModel by using TuyaSmartDevice::getFirmwareUpgradeInfo:failure:.
///
/// @note Your device must be connected over Bluetooth before the update.
///
/// @param uuid         The UUID of the device.
/// @param pid          The product ID of the device.
/// @param otaData      The OTA package data.
/// @param success      Called when the task is finished.
/// @param failure      Called when the task is interrupted by an error.
///
/// @deprecated This method is deprecated, Use TuyaSmartBLEManager::sendOTAPack:deviceModel:upgradeModel:success:failure: instead.
- (void)sendOTAPack:(NSString *)uuid
                pid:(NSString *)pid
            otaData:(NSData *)otaData
            success:(TYSuccessHandler)success
            failure:(TYFailureHandler)failure __deprecated_msg("This method is deprecated, Use TuyaSmartBLEManager::sendOTAPack:deviceModel:upgradeModel:success:failure: instead");

/// Sends an OTA package to update the firmware.
///
/// The values of `otaData`, `otaType`, and `otaVersion` can be obtained from TuyaSmartFirmwareUpgradeModel. You can get TuyaSmartFirmwareUpgradeModel by using TuyaSmartDevice::getFirmwareUpgradeInfo:failure:.
///
/// @note Your device must be connected over Bluetooth before the update.
///
/// @param uuid         The UUID of the device.
/// @param pid          The product ID of the device.
/// @param otaData      The OTA package data.
/// @param otaType      The OTA update type.
/// @param otaVersion   The OTA version.
/// @param success      Called when the task is finished.
/// @param failure      Called when the task is interrupted by an error.
///
/// @deprecated This method is deprecated, Use TuyaSmartBLEManager::sendOTAPack:deviceModel:upgradeModel:success:failure: instead.
- (void)sendOTAPack:(NSString *)uuid
                pid:(NSString *)pid
            otaData:(NSData *)otaData
            otaType:(TuyaSmartBLEOTAType)otaType
         otaVersion:(NSString *)otaVersion
            success:(TYSuccessHandler)success
            failure:(TYFailureHandler)failure __deprecated_msg("This method is deprecated, Use TuyaSmartBLEManager::sendOTAPack:deviceModel:upgradeModel:success:failure: instead");

/// Send OTA package to upgrade firmware.
/// @param otaData otaData.
/// @param deviceModel Device Model.
/// @param upgradeModel Firmware upgrade model.
/// @param success Called when the task finishes successfully.
/// @param failure Called when the task is interrupted by an error.
- (void)sendOTAPack:(NSData *)otaData
        deviceModel:(TuyaSmartDeviceModel *)deviceModel
       upgradeModel:(TuyaSmartFirmwareUpgradeModel *)upgradeModel
            success:(TYSuccessHandler)success
            failure:(TYFailureError)failure;

@end

NS_ASSUME_NONNULL_END
