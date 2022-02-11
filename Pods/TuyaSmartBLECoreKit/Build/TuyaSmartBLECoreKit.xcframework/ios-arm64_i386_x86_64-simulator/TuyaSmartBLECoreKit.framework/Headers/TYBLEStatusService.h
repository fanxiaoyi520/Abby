//
//  TYBLEStatusService.h
//  TuyaSmartBLEKit
//
//  Created by 吴戈 on 2019/9/17.
//

#import <Foundation/Foundation.h>
#import "TYBLEDeviceInfoProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@class TYBLEWriteNotifyService;
@interface TYBLEStatusService : NSObject

TYSDK_SINGLETON

- (id<TYBLEDeviceInfoProtocol>)addDeviceInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo;

- (void)updateDeviceInfo:(NSString *)uuid state:(TYSmartBLEDeviceState)state;

- (id<TYBLEDeviceInfoProtocol>)findDeviceInfoWithUUID:(NSString *)uuid;

- (NSDictionary<NSString *, id<TYBLEDeviceInfoProtocol>> *)findAllDeviceInfo;

- (void)offlineDevcieInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo;

- (void)removeDevcieInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo;

#pragma mark - reconnectList

- (void)addReconnectDevice:(TYBLEPeripheral *)peripheral forKey:(NSString *)key;

- (TYBLEPeripheral *)getReconnectDeviceWithKey:(NSString *)key;

- (void)removeReconnectDeviceWithKey:(NSString *)key;

- (void)removeAllReconnectDevice;

#pragma mark - otaStatusList

- (void)addOtaStatusDevice:(id)anObject forKey:(NSString *)key;

- (id)getOtaStatusDeviceWithKey:(NSString *)key;

- (void)removeOtaStatusDeviceWithKey:(NSString *)key;

- (void)removeAllOtaStatusDevice;

@end

NS_ASSUME_NONNULL_END
