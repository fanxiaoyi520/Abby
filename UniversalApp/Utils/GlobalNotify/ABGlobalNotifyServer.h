//
//  ABGlobalNotifyServer.h
//  UniversalApp
//
//  Created by Baypac on 2021/11/30.
//  Copyright © 2021 徐阳. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <JAFMultiDelegate/NSObject+JAFMultiProxyAddition.h>
#import "ABDeviceDpsModel.h"
#import "ABNationModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol GWGlobalNotifyServerDelegate <NSObject>
@optional
/** 重制设备状态 */
-(void)resetDeviceNext;
/** 修改用户名  */
-(void)resetUserName:(NSString *)userName;
/** 修改用户头像  */
-(void)resetUserHeaderImage:(NSString *)imageStr;
/** 登陆成功传递deviceModel */
-(void)sendTuyaSmartDeviceModel:(TuyaSmartDeviceModel *)deviceModel;
/** 设备数据发送 */
-(void)resetDeviceDps:(NSDictionary *)dpsModel;
/** 重置密码填写账号 */
-(void)resetForgetPassword:(NSString *)emailStr;
@end

@interface ABGlobalNotifyServer : NSObject
SingletonH(Server)

-(void)postResetDevice;
-(void)postChangeUserName:(NSString *)userName;
-(void)postChangeUserHeaderImage:(NSString *)imageStr;
-(void)postTuyaSmartDeviceModel:(TuyaSmartDeviceModel *)deviceModel;
-(void)postDeviceDpsUpdate:(ABDeviceDpsModel *)dpsModel;
-(void)postForgetPassword:(NSString *)emailStr;
@end

NS_ASSUME_NONNULL_END
