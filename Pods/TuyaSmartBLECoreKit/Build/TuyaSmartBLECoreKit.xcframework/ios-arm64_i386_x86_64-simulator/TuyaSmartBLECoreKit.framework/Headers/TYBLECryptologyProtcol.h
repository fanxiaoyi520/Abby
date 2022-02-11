//
//  TYBLECryptologyProtcol.h
//  TuyaSmartBLEKit
//
//  Created by 吴戈 on 2020/1/10.
//

#ifndef TYBLECryptologyProtcol_h
#define TYBLECryptologyProtcol_h
#import "TuyaSmartBLEMutliTsfDefine.h"

@protocol TYBLEDeviceInfoProtocol;

typedef enum : NSUInteger {
    TYBLEConfigType_QRY_DEV_INFO        = 0,
    TYBLEConfigType_PAIR                = 1,
    TYBLEConfigType_CMD                 = 2,
    TYBLEConfigType_STAT                = 3, //ALL_DP
    TYBLEConfigType_SET_PWD             = 4,
    TYBLEConfigType_UNPAIR              = 5,
    TYBLEConfigType_RESET               = 6,
    TYBLEConfigType_OTA_START           = 12,
    TYBLEConfigType_OTA_INFO            = 13,
    TYBLEConfigType_OTA_INFO_AES        = 14,
    TYBLEConfigType_OTA_INFO_ASY        = 15,
    TYBLEConfigType_OTA_OFFSET          = 16,
    TYBLEConfigType_OTA_DATA            = 17,
    TYBLEConfigType_OTA_END             = 18,
    TYBLEConfigType_TEST                = 19,
    TYBLEConfigType_FORCE_UNPAIR        = 20,
    TYBLEConfigType_CERT_ONE            = 21,
    TYBLEConfigType_CERT_TWO            = 22,
    TYBLEConfigType_CERT_THREE          = 23,
    TYBLEConfigType_PP_QUERY_INFO       = 26,
    TYBLEConfigType_PP_ACTIVE_INFO      = 27,
    TYBLEConfigType_PP_NET_INFO         = 28,
    TYBLEConfigType_PRI_DATA_TRANS_INFO = 29,
    TYBLEConfigType_PP_WIFI_STATE_REPORT= 30,
    TYBLEConfigType_NET                 = 33,
    TYBLEConfigType_NET_STATE           = 34,
    TYBLEConfigType_DATA_TRANS          = 35,
    TYBLEConfigType_DP_SEND_256         = 36,
    
    TYBLEConfigType_ZIGBEE_GATEWAY_INFO = 40,
    TYBLEConfigType_ZIGBEE_COMMAND      = 41,
    
    TYBLEConfigType_EXPAND              = 80,
    TYBLEConfigType_ALL_DP              = 91,
    
    TYBLEConfigType_BT_DEV_INFO         = 96,//查询经典蓝牙信息
    
    TYBLEConfigType_MCU_STATE           = 8001,
    TYBLEConfigType_DPTIME              = 8003,
    TYBLEConfigType_MUT_DP              = 8004,
    TYBLEConfigType_MUT_DPTIME          = 8005,
    TYBLEConfigType_DP_256              = 8006,
    TYBLEConfigType_DPTIME_256          = 8007,
    TYBLEConfigType_TIMESTAMP1          = 8011,
    TYBLEConfigType_TIMESTAMP2          = 8012,
    TYBLEConfigType_APPTIME             = 8013,
    TYBLEConfigType_SUMMER_TIME         = 8014,
    TYBLEConfigType_WEATHER_REQ         = 8015,
    TYBLEConfigType_WEATHER_ACK         = 8016,
    TYBLEConfigType_WEATHER_LOCATION_REQ = 8017,
    TYBLEConfigType_WEATHER_LOCATION_ACK = 8018,
    
    TYBLEConfigType_QRY_IOT_DATA            = 8019,//设备请求IOT数据
    TYBLEConfigType_SEND_IOT_DATA            = 8020,//APP 下发 IOT 数据
    
    TYBLEConfigType_SEND_TRANSPARENT_DATA_REQ = 8021,
    TYBLEConfigType_SEND_TRANSPARENT_DATA_ACK = 8022,
    
    TYBLEConfigType_BIGDATA_SUMMARY     = 7,
    TYBLEConfigType_BIGDATA_BLOCKSUMMARY = 8,
    TYBLEConfigType_BIGDATA_ACK          = 9,
    TYBLEConfigType_BIGDATA_DEL        = 10,
    TYBLEConfigType_BIGDATA_SYNC        = 11,
} TYBLEConfigType;

/// 控制命令加解密
@protocol TYBLECryptologyProtcol <NSObject>

/// 加密控制指令
/// @param deviceInfo deviceInfo
/// @param configType TYBLEConfigType
/// @param data 控制指令内容
- (NSData *)encodeWithDeviceInfo:(id<TYBLEDeviceInfoProtocol>)deviceInfo
                      configType:(TYBLEConfigType)configType
                            data:(NSData *)data;

/// 解密控制指令
/// @param configType TYBLEConfigType
/// @param data 控制指令内容
- (NSData *)decodeWithConfigType:(TYBLEConfigType)configType
                            data:(NSData *)data;

/// 解密控制指令
/// @param data 控制指令内容
- (NSData *)decodeWithData:(NSData *)data;

- (NSData *)decodeWithPlusType:(frame_type_t)plusType data:(NSData *)data;

+ (TYBLEConfigType)protocolType2ConfigCharType:(frame_type_t)proType;

+ (TYBLEConfigType)protocolType2ConfigType:(frame_sec_type_t)proType;

+ (frame_type_t)configCharType2ProtocolType:(TYBLEConfigType)configType;

+ (frame_sec_type_t)configType2ProtocolType:(TYBLEConfigType)configType;

@property (nonatomic, copy) NSString *localKey;
@property (nonatomic, copy) NSString *sessionKey;
@property (nonatomic, copy) NSString *sessionKeyHex;
@property (nonatomic, copy) NSString *deviceSrand;// 设备生成的随机数
@end

#endif /* TYBLECryptologyProtcol_h */
