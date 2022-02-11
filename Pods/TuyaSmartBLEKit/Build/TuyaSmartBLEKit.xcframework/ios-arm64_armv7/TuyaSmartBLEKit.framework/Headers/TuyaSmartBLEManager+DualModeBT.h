//
//  TuyaSmartBLEManager+DualModeBT.h
//  TuyaSmartBLEKit
//
// Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com)

#import <TuyaSmartBLECoreKit/TuyaSmartBLEManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartBLEManager (DualModeBT)
/// Get BT information, such as  name ，macaddress，connect status.
/// @param deviceId The device id
/// @param success                        Called when the task is finished. btModel is returned.
/// @param failure                        Called when the task is interrupted by an error.
- (void)queryBLEDualModeBTInfoWithDeviceId:(NSString *)deviceId
                    success:(void(^)(TYBLEDualModeBTModel *btModel))success
                    failure:(TYFailureError)failure;
@end

NS_ASSUME_NONNULL_END
