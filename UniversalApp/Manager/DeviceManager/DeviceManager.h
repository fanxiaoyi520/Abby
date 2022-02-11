//
//  DeviceManager.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/23.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#define deviceManager [DeviceManager sharedDeviceManager]
@interface DeviceManager : NSObject<TuyaSmartDeviceDelegate>
//单例
SINGLETON_FOR_HEADER(DeviceManager)

@property (nonatomic, strong) TuyaSmartDeviceModel *deviceModel;
@property (nonatomic, strong) ABDeviceDpsModel *dpsModel;

- (void)saveDeviceInfo:(TuyaSmartDeviceModel *)deviceModel;
// 加载缓存的设备信息
-(BOOL)loadDeviceInfo;
- (TuyaSmartDevice *)getDevice;
@end

NS_ASSUME_NONNULL_END
