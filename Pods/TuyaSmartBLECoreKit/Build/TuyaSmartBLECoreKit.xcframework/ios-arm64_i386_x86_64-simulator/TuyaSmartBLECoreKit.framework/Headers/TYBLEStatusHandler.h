//
//  TYBLEStatusHandler.h
//  Pods
//
//  Created by 吴戈 on 2020/1/7.
//

#import <Foundation/Foundation.h>
#import "TYBLEStatusService.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TYBLEDeviceInfoProtocol;
@interface TYBLEStatusHandler : NSObject

TYSDK_SINGLETON

/// 是否在 batch 接口调用完后进行自动扫描连接
@property (nonatomic, assign) BOOL autoScanning;

/// 获取已扫描到的未配网设备
- (NSArray *)getUnActivedListInfo;

- (void)clearUnactiveList;

- (void)disconnectAllDevices;

//获取蓝牙外设的信号
- (NSInteger)getPeripheralRSSI:(NSString *)uuid;

#pragma mark - OTA Method
//当前是否在升级中
- (BOOL)isOTA:(NSString *)uuid;

- (NSInteger)getOTAStatus:(NSString *)uuid;

- (void)disconnectDevice:(id<TYBLEDeviceInfoProtocol>)deviceInfo;

#pragma mark - ConnectManage
/// 判断当前已连接设备是否达到阈值，并踢掉最不活跃的设备
- (BOOL)handleConnectedDevices:(NSString *)uuid;

@end

NS_ASSUME_NONNULL_END
