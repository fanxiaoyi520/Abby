//
//  ABGlobalNotifyServer.m
//  UniversalApp
//
//  Created by Baypac on 2021/11/30.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABGlobalNotifyServer.h"

@implementation ABGlobalNotifyServer
SingletonM(Server)

-(void)postResetDevice {
    [JAFProxy(GWGlobalNotifyServerDelegate) resetDeviceNext];
}

- (void)postChangeUserName:(NSString *)userName {
    [JAFProxy(GWGlobalNotifyServerDelegate) resetUserName:userName];
}

- (void)postChangeUserHeaderImage:(NSString *)imageStr {
    [JAFProxy(GWGlobalNotifyServerDelegate) resetUserHeaderImage:imageStr];
}

- (void)postTuyaSmartDeviceModel:(TuyaSmartDeviceModel *)deviceModel {
    [JAFProxy(GWGlobalNotifyServerDelegate) sendTuyaSmartDeviceModel:deviceModel];
}

- (void)postDeviceDpsUpdate:(NSDictionary *)dpsModel {
    [JAFProxy(GWGlobalNotifyServerDelegate) resetDeviceDps:dpsModel];
}

- (void)postForgetPassword:(NSString *)emailStr {
    [JAFProxy(GWGlobalNotifyServerDelegate) resetForgetPassword:emailStr];
}

@end
