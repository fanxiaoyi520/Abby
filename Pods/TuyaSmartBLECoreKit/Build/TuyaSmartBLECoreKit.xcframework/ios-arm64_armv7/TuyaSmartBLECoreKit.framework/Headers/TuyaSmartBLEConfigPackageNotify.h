//
//  TuyaSmartBLEConfigPackageNotify.h
//  Pods
//
//  Created by 奥托 on 2021/7/1.
//

#ifndef TuyaSmartBLEConfigPackageNotify_h
#define TuyaSmartBLEConfigPackageNotify_h

#import "TuyaSmartBLEConfigNotifyItem.h"

@protocol TuyaSmartBLEConfigPackageNotify <NSObject>

- (void)classicConfigPackageWithDeviceInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo
                                notifyItem:(TuyaSmartBLEConfigNotifyItem *)notifyItem;

- (void)plusConfigPackageWithDeviceInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo
                             notifyItem:(TuyaSmartBLEConfigNotifyItem *)notifyItem;

- (void)secretConfigPackageWithDeviceInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo
                               notifyItem:(TuyaSmartBLEConfigNotifyItem *)notifyItem;

@end

#endif /* TuyaSmartBLEConfigPackageNotify_h */
