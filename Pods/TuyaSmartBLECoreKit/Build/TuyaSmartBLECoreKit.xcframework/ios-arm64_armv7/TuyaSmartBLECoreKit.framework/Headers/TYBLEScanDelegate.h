//
//  TYBLEScanDelegate.h
//  Pods
//
//  Created by 余豪 on 2021/6/24.
//

#ifndef TYBLEScanDelegate_h
#define TYBLEScanDelegate_h

#import "TYBLEDeviceInfoProtocol.h"

@protocol TYBLEScanDelegate <NSObject>

@optional
/// 扫描到设备
/// @param deviceInfos deviceInfos
- (void)didScanDevices:(NSArray<id <TYBLEDeviceInfoProtocol>> *)deviceInfos;

- (void)bleOnCentralDidUpdateState:(BOOL)isPoweredOn;

- (void)syncDevice2Cloud:(id<TYBLEDeviceInfoProtocol>)dev;

- (void)scanHasStopped;

@end


#endif /* TYBLEScanDelegate_h */
