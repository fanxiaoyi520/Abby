//
//  TYBLEDataManager.h
//  TuyaSmartBLEKit
//
//  Created by liuguang on 2021/9/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYBLEDataManager : NSObject

@property (nonatomic, strong) NSMutableDictionary *dataMaxSizeDic;

TYSDK_SINGLETON

- (void)handleNotifyData:(NSData *)data deviceInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo type:(TYBLEConfigType)type completion:(void(^)(NSData *resultData, NSError * _Nullable error))completion;

- (void)handleNotifyData:(NSData *)data deviceInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo type:(TYBLEConfigType)type ackHeadData:(nullable NSData *)headData completion:(void(^)(NSData * _Nullable resultData, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
