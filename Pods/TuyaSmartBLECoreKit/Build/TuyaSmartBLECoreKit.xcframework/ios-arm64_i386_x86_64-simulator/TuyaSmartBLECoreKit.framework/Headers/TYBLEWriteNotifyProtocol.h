//
//  TYBLEWriteNotifyProtocol.h
//  TuyaSmartBLEKit
//
//  Created by 吴戈 on 2020/1/10.
//

#ifndef TYBLEWriteNotifyProtocol_h
#define TYBLEWriteNotifyProtocol_h

#import "TYBLECryptologyProtcol.h"
#import "TuyaSmartBLEMutliTsfDefine.h"

@class TYBLEWriteNotify;
@protocol TYBLEWriteNotifyDelegate <NSObject>

@optional

- (void)didPackagedNotifyData:(NSData *)data;

- (void)didPackagedNotifyType:(frame_type_t)type data:(NSData *)data;

@end

@protocol TYBLEDeviceInfoProtocol;
@protocol TYBLEWriteNotifyProtocol <NSObject>

@property (nonatomic, strong) TYBLEWriteNotify *writeNotify;

@property(nonatomic, weak) id<TYBLEWriteNotifyDelegate> delegate;/// < 接受数据代理

/// 向蓝牙设备下发数据
/// @param deviceInfo deviceInfo
/// @param type type
/// @param data data
/// @param success success
/// @param failure failure

- (void)writeDataWithDeviceInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo
                           type:(TYBLEConfigType)type
                           data:(NSData *)data
                        success:(TYSuccessData)success
                        failure:(TYFailureError)failure;

@end

#endif /* TYBLEWriteNotifyProtocol_h */
