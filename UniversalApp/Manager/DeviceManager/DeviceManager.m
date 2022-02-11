//
//  DeviceManager.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/23.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "DeviceManager.h"
@interface DeviceManager()
@property (nonatomic ,strong)TuyaSmartDevice *device;
@end
@implementation DeviceManager
SINGLETON_FOR_CLASS(DeviceManager);

#pragma mark ————— 储存设备信息 —————
- (void)saveDeviceInfo:(TuyaSmartDeviceModel *)deviceModel {
    self.deviceModel = deviceModel;
    self.dpsModel = [ABDeviceDpsModel yy_modelWithDictionary:self.deviceModel.dps];
    if (self.deviceModel) {
        YYCache *cache = [[YYCache alloc]initWithName:KDeviceCacheName];
        NSDictionary *dic = [self.deviceModel yy_modelToJSONObject];
        [cache setObject:dic forKey:KDeviceModelCache];
    }
}

#pragma mark ————— 加载缓存的设备信息 —————
-(BOOL)loadDeviceInfo{
    YYCache *cache = [[YYCache alloc]initWithName:KDeviceCacheName];
    NSDictionary * userDic = (NSDictionary *)[cache objectForKey:KDeviceModelCache];
    if (userDic) {
        self.deviceModel = [TuyaSmartDeviceModel yy_modelWithJSON:userDic];
        return YES;
    }
    return NO;
}

#pragma mark ————— 初始化设备 —————
- (TuyaSmartDevice *)getDevice {
    self.device = [TuyaSmartDevice deviceWithDeviceId:deviceManager.deviceModel.devId];
    self.device.delegate = self;
    return self.device;
}

#pragma mark - TuyaSmartDeviceDelegate
- (void)device:(TuyaSmartDevice *)device dpsUpdate:(NSDictionary *)dps {
    // 设备的 dps 状态发生变化，刷新界面 UI
    [self.dpsModel updateModelWithDic:dps];
    [[ABGlobalNotifyServer sharedServer] postDeviceDpsUpdate:dps];
}

- (void)deviceInfoUpdate:(TuyaSmartDevice *)device {
    //当前设备信息更新 比如 设备名称修改、设备在线离线状态等
    self.dpsModel = [ABDeviceDpsModel yy_modelWithDictionary:device.deviceModel.dps];
}

- (void)deviceRemoved:(TuyaSmartDevice *)device {
    //当前设备被移除
    DLog(@"1");
}

- (void)device:(TuyaSmartDevice *)device signal:(NSString *)signal {
    // Wifi信号强度
    DLog(@"1");
}

- (void)device:(TuyaSmartDevice *)device firmwareUpgradeProgress:(NSInteger)type progress:(double)progress {
    // 固件升级进度
    DLog(@"1");
}

- (void)device:(TuyaSmartDevice *)device firmwareUpgradeStatusModel:(TuyaSmartFirmwareUpgradeStatusModel *)upgradeStatusModel {
    // 设备升级状态的回调
    DLog(@"1");
}
@end
