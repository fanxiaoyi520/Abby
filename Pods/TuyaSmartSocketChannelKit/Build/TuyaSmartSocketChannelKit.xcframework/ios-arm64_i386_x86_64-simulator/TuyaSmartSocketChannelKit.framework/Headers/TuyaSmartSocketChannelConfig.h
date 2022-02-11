//
//  TuyaSmartSocketChannelConfig.h
//  Pods
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSocketChannelConfig : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) NSData *zigbeeActiveKey;
@property (nonatomic, strong) NSData *broadcastKey;
@property (nonatomic, strong) NSData *sendKey;

@end

NS_ASSUME_NONNULL_END
