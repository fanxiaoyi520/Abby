//
//  TuyaSmartBeaconManager+RNScan.h
//  TuyaSmartBLEKit
//
//  Created by Tuya on 2021/8/10.
//

#import "TuyaSmartBeaconManager.h"

NS_ASSUME_NONNULL_BEGIN


@interface TuyaSmartBeaconManager (RNScan)



/// If the beacon device is being scanned on the RN panel, return YES
- (BOOL)isScanningOnRNPanel;


/// If the device with the specified uuid is scanned, return yes
/// @param mac mac address
- (BOOL)isTheTargetDeviceForScanning:(nullable NSString*)mac;


- (void)scanForSharedBeaconWithDeviceId:(nullable NSString*)deviceId;


- (void)scanForSharedBeaconsWithDeviceIds:(nullable NSArray<NSString*>*)deviceIds;


/// Stop scanning beacon shared devices
- (void)stopShareBeaconScan;


/// Stop scanning the beacon shared device with the specified device id
/// @param deviceId deviceId
- (void)stopScanShareBeaconWithDeviceId:(nullable NSString*)deviceId;


/// Stop scanning for beacon shared devices containing a set of device IDs
/// @param deviceIds @[deviceId,deviceId]
- (void)stopScanSharedBeaconsWithDeviceIds:(nullable NSArray<NSString*>*)deviceIds;

@end

NS_ASSUME_NONNULL_END
