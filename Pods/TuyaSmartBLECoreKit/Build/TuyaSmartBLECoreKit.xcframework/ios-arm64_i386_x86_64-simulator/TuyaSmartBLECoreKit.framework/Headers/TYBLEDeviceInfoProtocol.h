//
//  TYBLEDeviceInfoProtocol.h
//  Pods
//
//  Created by 温明妍 on 2020/1/7.
//  用于存放蓝牙的配网和控制的设备model

#ifndef TYBLEDeviceInfoProtocol_h
#define TYBLEDeviceInfoProtocol_h

#import "TYBLEActiveProtocol.h"
#import "TYBLEConfigProtocol.h"

#import <TYBluetooth/TYBluetooth.h>

typedef void (^TYBLEBigDataProgressBlock)(float progress);

typedef enum : NSUInteger {
    TYBLEEncryptTypeNormal = 1, ///< 一般加密
    TYBLEEncryptTypeAdvanced,   ///< 高级加密
} TYBLEEncryptType;

typedef enum : NSUInteger {
    TYSmartBLEDeviceStateUnactive = 1,  ///< 未激活
    TYSmartBLEDeviceStateUnstable,      ///< 激活中
    TYSmartBLEDeviceStateActived,       ///< 已激活
    TYSmartBLEDeviceStateReconnect,     ///< 重连中
    TYSmartBLEDeviceStateOTA,           ///< OTA中
    TYSmartBLEDeviceStateOffline,       ///< 已离线
} TYSmartBLEDeviceState;

typedef enum : NSUInteger {
    TYSmartBLEBusinessTypeDefault = 0,   ///< 普通设备设备
    TYSmartBLEBusinessTypeMulitUser,     ///< 共享类设备
} TYSmartBLEBusinessType;

@protocol TYBLEConfigProtocol;
@protocol TYBLEDeviceInfoProtocol <NSObject>

@property (nonatomic, strong) TYBLEAgent *agent;

@property (nonatomic, assign) TYSmartBLEDeviceState state;

@property (nonatomic, strong) NSString            *uuid;
@property (nonatomic, strong) NSString            *devId;
@property (nonatomic, strong) NSString            *pid;

@property (nonatomic, strong) TYBLEPeripheral     *peripheral;
@property (nonatomic, strong) TYBLEAdvModel       *advModel;

@property (nonatomic, assign) int32_t             sn;
@property (nonatomic, assign) int32_t             ack;

@property (nonatomic, strong) NSDictionary        *schemaDict;

@property (nonatomic, strong) TYBLECharacteristic *notifyCharacteristic;
@property (nonatomic, strong) TYBLECharacteristic *writeCharacteristic;
@property (nonatomic, strong) TYBLECharacteristic *otaCharacteristic;

@property (nonatomic, assign) BOOL                bondState;   ///<  NO = 未绑定 YES = 已绑定
@property (nonatomic, assign) BOOL                isSIGMesh;

@property (nonatomic, assign) NSTimeInterval      activeTime;

// bleSecret
//加密方式
@property (nonatomic, assign) TYBLEEncryptType      encryptType;
//设备业务类型
@property (nonatomic, assign) TYSmartBLEBusinessType businessType;

@property (nonatomic, strong) NSMutableDictionary *bizExt;

@property (nonatomic, assign) BOOL        certCheck;            ///< 是否需要云端双向验证证书(大于 4.0 的协议)
@property (nonatomic, assign) BOOL        advanceEncrypt;       ///< 是否支持高级加密（即双向认证）(大于 4.0 的协议)
@property (nonatomic, assign) BOOL        isSupportBeaconkey;   ///< 是否需要获取 beaconKey

//==== Plug&Play 双模字段 ======= //
@property (nonatomic, assign) BOOL        isBLEChannelFirst; ///<  蓝牙通道是否是最高优先级
@property (nonatomic, assign) BOOL        isSupportPlugPlay; ///<  设备是否支持 Plug&Play
@property (nonatomic, strong) NSString    *bleMac;    ///<  ble 的 mac
@property (nonatomic, strong) NSString    *zigbeeMac; ///<  zigbee 子设备的 mac

//安全协议版本
@property (nonatomic, assign) int                 bleProtocolV;

@property (nonatomic, assign) NSUInteger          maxMtuLen;

@property (nonatomic, strong) NSString            *pv;

@property (nonatomic, strong) NSString            *dv;  ///< 硬件版本号1：取硬件版本号2的高2位，例如v1.1
@property (nonatomic, strong) NSString            *dv2; ///< 硬件版本号2：例如0x010000代表v1.1.0
@property (nonatomic, strong) NSString            *sv;  ///< 固件版本号1：取固件版本号2的高2位，例如V1.2
@property (nonatomic, strong) NSString            *sv2; ///< 固件版本号2：例如0x010200代表v1.2.0
@property (nonatomic, assign) BOOL                use_sv2;///< 固件版本是否用 sv2？ true = sv2 false = sv
@property (nonatomic, assign) BOOL                use_dv2;///< 硬件版本是否用 dv2？ true = dv2 false = dv
@property (nonatomic, strong) NSString            *mcuDv; ///< mcu 硬件版本号
@property (nonatomic, strong) NSString            *mcuSv; ///< mcu 固件版本号
@property (nonatomic, strong) NSString            *authKey; ///< mcu 固件版本号

@property (nonatomic, strong) NSMutableArray      *channel_modules; //设备支持的通道 modules
@property (nonatomic, strong) NSString            *bleCapability;/// 蓝牙能力
@property (nonatomic, assign) NSInteger packetMaxSize;

- (void)handlePeripheral:(TYBLEPeripheral *)peripheral;

/// 更新设备活跃时间
- (void)updateActiveEvent;

- (void)configSchemaDict:(NSString *)json;

@property (nonatomic, strong) id<TYBLEActiveProtocol> activeManager;

@property (nonatomic, strong) id<TYBLEConfigProtocol> configManager;

@end


#endif /* TYBLEDeviceInfoProtocol_h */
