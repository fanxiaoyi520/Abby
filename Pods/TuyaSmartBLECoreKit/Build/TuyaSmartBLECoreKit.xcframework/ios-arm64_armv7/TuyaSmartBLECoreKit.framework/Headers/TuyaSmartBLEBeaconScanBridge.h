//
//  TuyaSmartBLEBeaconScanBridge.h
//  TuyaSmartBLECoreKit
//
//  Created by 余豪 on 2021/6/25.
//

#import <Foundation/Foundation.h>
#import <TYBluetooth/TYBluetooth.h>
#import "TYBLEDeviceInfoProtocol.h"

typedef void(^TYBLEBeaconScanCallback)(TYBLEPeripheral *p, id<TYBLEDeviceInfoProtocol> deviceInfo);

NS_ASSUME_NONNULL_BEGIN

@class TYBLEScan;
@interface TuyaSmartBLEBeaconScanBridge : NSObject

@property (nonatomic, strong) TYBLEScan *scan;

TYSDK_SINGLETON

- (void)stopBeaconScan;

- (void)startBleBeaconScanWithDeviceId:(NSString *)deviceId uuid:(NSString *)uuid callBack:(TYBLEBeaconScanCallback)callback;

- (void)stopScan;

@end

NS_ASSUME_NONNULL_END
