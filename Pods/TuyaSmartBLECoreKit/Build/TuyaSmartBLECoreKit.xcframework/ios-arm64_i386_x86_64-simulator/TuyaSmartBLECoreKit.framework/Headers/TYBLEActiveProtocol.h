//
//  TYBLEActiveProtocol.h
//  Pods
//
//  Created by 温明妍 on 2020/1/7.
//

#ifndef TYBLEActiveProtocol_h
#define TYBLEActiveProtocol_h
#import <TuyaSmartUtil/TuyaSmartUtil.h>
#import "TuyaSmartBLEActiveDelegate.h"

NS_ASSUME_NONNULL_BEGIN

//TODO: wuge 配网失败的error类型可以归纳成enum

@protocol TYBLEActiveProtocol;
@protocol TYBLEDeviceInfoProtocol;
@protocol TuyaSmartBLEActiveDelegate;
@class TYBLEAdvModel;

@protocol TYBLEActiveDelegate <NSObject>

/// 配网结果回调
/// @param active activeManager
/// @param deviceInfo deviceInfo
/// @param result result
/// @param error error
- (void)activeManager:(id<TYBLEActiveProtocol>)active deviceInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo didActiveSuccess:(nullable id)result failure:(nullable NSError *)error;

/// 配网失败回调
/// @param active activeManager
/// @param deviceInfo deviceInfo
/// @param result result
/// @param error error
- (void)activeManager:(id<TYBLEActiveProtocol>)active deviceInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo activeFailRes:(nullable NSDictionary *)result failure:(nullable NSError *)error;


@end

/// 激活协议，老的方法目前因为降级的存在，暂时不能挪走，只能一并放在Core中
@protocol TYBLEActiveProtocol <NSObject>

@optional

@property(nonatomic, weak) id<TYBLEActiveDelegate> delegate;/// < 配网代理
@property(nonatomic, weak) id<TuyaSmartBLEActiveDelegate> handlerDelegate; //!<中间过程要外部补充数据的代理

/// 开始配网（Core）
/// @param deviceInfo   需要配网的设备
/// @param handlerDelegate 用于获取部分补充信息的代理对象
- (void)startActiveWithDevice:(id<TYBLEDeviceInfoProtocol>)deviceInfo
              handlerDelegate:(nullable id<TuyaSmartBLEActiveDelegate>)handlerDelegate;

/// 双模配网预连接（Core）
/// @param deviceInfo   需要配网的设备
- (void)startPreActiveWithDevice:(id<TYBLEDeviceInfoProtocol>)deviceInfo
                         success:(nullable TYSuccessID)success
                         failure:(nullable TYFailureError)failure;

/// 开始配网（Core）
/// @param deviceInfo   需要配网的设备
/// @param ssid         路由器热点名称
/// @param passwd       路由器热点密码
/// @param token        配网Token
/// @param handlerDelegate 用于获取部分补充信息的代理对象
/// @param success 成功回调
/// @param failure 失败回调
- (void)startActiveWithDevice:(id<TYBLEDeviceInfoProtocol>)deviceInfo
                         ssid:(NSString *)ssid
                       passwd:(NSString *)passwd
                        token:(NSString *)token
              handlerDelegate:(id<TuyaSmartBLEActiveDelegate>)handlerDelegate
                      success:(nullable TYSuccessID)success
                      failure:(nullable TYFailureError)failure;

/// Zigbee 双模子设备蓝牙配对（Core）
/// （包括蓝牙连接、获取子设备信息、配对操作）
/// @param deviceInfo  需要配网的设备
/// @param success     成功回调
/// @param failure     失败回调
- (void)pairZigbeeSubDeviceWithBleChannel:(id<TYBLEDeviceInfoProtocol>)deviceInfo
                                  success:(nullable TYSuccessID)success
                                  failure:(nullable TYFailureError)failure;

/// 下发网关信息给 Zigbee 双模子设备
/// @param deviceInfo  需要配网的设备
/// @param gatewayInfo  网关信息
/// @param success     成功回调
/// @param failure     失败回调
- (void)publishGatewayInfoWithBleChannel:(id<TYBLEDeviceInfoProtocol>)deviceInfo
                             gatewayInfo:(NSDictionary *)gatewayInfo
                                 success:(TYSuccessBOOL)success
                                 failure:(TYFailureError)failure;


/// 连接设备（双模、PlugPlay）（Core）
/// @param dev 需要配网的设备
/// @param success 成功回调
/// @param failure 失败回调
- (void)connectToDevice:(id<TYBLEDeviceInfoProtocol>)dev
                success:(TYSuccessHandler)success
                failure:(TYFailureError)failure;


/// 兜底激活（PlugPlay）（Core）
/// @param dev 需要配网的设备
/// @param success 成功回调
/// @param failure 失败回调
- (void)activeBLEBackUp:(id<TYBLEDeviceInfoProtocol>)dev
                  token:(NSString *)token
                success:(nullable TYSuccessID)success
                failure:(TYFailureError)failure;

/// 双模激活（PlugPlay）（Core）
/// @param devId 设备id
/// @param result result
/// @param ssid 路由器热点名称
/// @param password 路由器热点密码
/// @param callback 状态回调
/// @param failure 失败回调
- (void)activeDualDeviceWifiChannel:(NSString *)devId
                             result:(id)result
                               ssid:(NSString *)ssid
                           password:(NSString *)password
                        listenState:(void(^)(void))callback
                            failure:(TYFailureError)failure;

/// 清除重连设备数据
- (void)cleanReconnectDevice:(NSString *)uuid;

/// 结束配网
- (void)stopActive;

@end

NS_ASSUME_NONNULL_END

#endif /* TYBLEActiveProtocol_h */
