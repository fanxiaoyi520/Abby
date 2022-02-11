//
//  NSError+BLEError.h
//  TuyaSmartBLEKit
//
//  Created by 吴戈 on 2019/8/15.
//

#import <Foundation/Foundation.h>

#define TYBLEErrorDomain @"com.ble.www"

/**
 *
 * APP错误码枚举定义
 */
typedef enum {
    
    //用户主动取消配网
    TUYA_BLE_CONFIG_CANCEL = 100,
    
    //蓝牙连错误败
    TUYA_BLE_CONNECT_FAILURE = 101,
    
    //发现蓝牙服务错误
    TUYA_BLE_FIND_SERVICE_FAILURE = 102,
    
    //打开蓝牙通讯通道失败
    TUYA_BLE_CHARACTER_FAILURE = 103,
    
    //获取设备信息失败
    TUYA_BLE_QRY_DEV_INFO_FAILURE = 104,
    
    //配对失败
    TUYA_BLE_PAIR_FAILURE = 105,
    
    //配网超时
    TUYA_BLE_TIMEOUT = 106,
    
    //发送配网信息失败
    TUYA_BLE_CONFIG_INFO_FAILURE = 107,
    
    //Token 失效
    TUYA_BLE_TOKEN_INVALID = 108,
    
    //获取蓝牙加密密钥失败
    TUYA_BLE_GET_KEY_FAILURE = 109,
    
    //设备不存在
    TUYA_BLE_DEVICE_NOT_EXIST = 110,
    
    //设备云端注册失败
    TUYA_BLE_REGISTER_FAILURE = 111,
    
    //设备云端激活失败
    TUYA_BLE_ACTIVE_FAILTURE = 112,
    
    //设备强绑定
    TUYA_BLE_ALREADY_BIND = 113,
    
    //蓝牙状态变化
    TUYA_BLE_CHECK_FAILURE = 114,
    
    //同步设备信息失败
    TUYA_BLE_SYNC_DEVICE_FAILURE = 115,
    
    //多协议设备已通过其他途径配网
    TUYA_BLE_ALREADY_CONFIG_FAILURE = 116,
    
    //OTA升级失败
    TUYA_BLE_OTA_FAILURE = 117,
    
    //OTA升级超时
    TUYA_BLE_OTA_TIMEOUT = 118,
    
    //WIFI配网传参校验失败
    TUYA_BLE_WIFI_CONFIG_CHECK_FAILURE = 119,
    
    //发送密钥失败
    TUYA_BLE_PWD_FAILURE = 120,
    
    //发现蓝牙连接对象失败
    TUYA_BLE_FIND_PERP_FAILURE = 121,
    
    //没有蓝牙对象
    TUYA_BLE_DEVICEINFO_NOT_EXIST = 122,
    
    //游客不支持强绑定
    TUYA_BLE_GUEST_NOT_SUPPORT_STRONG_BIND = 123,
    
    TUYA_BLE_COMMON_FAILURE = 124,
    
    // Notify 打开失败
    TUYA_BLE_NOTIFY_OPEN_FAILURE = 125,
    
    //硬件加密设备端错误
    TUYA_BLE_CHIP_DEVICE_FAILURE = 126,
    
    //硬件加密云端错误
    TUYA_BLE_CHIP_CLOUD_FAILURE = 127,
    
    //非 cat.1 设备双模配网失败未输入 password
    TUYA_BLE_DUAL_ACTIVAT_PSD_FAILURE = 128,
    
    //获取 token 失败
    TUYA_BLE_GET_TOKEN_FAILURE = 129,
    
    //配网传参错误
    TUYA_BLE_PP_PARAM_ERROR = 130,
    
    //查询设备 Wi-Fi 信息失败
    TUYA_BLE_PP_QUERY_WIFI_INFO_FAIL = 131,
    
    //tuya.m.dm.device.active 接口报错
    TUYA_BLE_PP_ACTIVE_FAIL = 132,
    
    //发送设备激活信息失败
    TUYA_BLE_PP_SEND_ACTIVE_INFO_FAIL = 133,
    
    //设备云端上线失败导致超时
    TUYA_BLE_DEVICE_MQ_ONLINE_FAIL = 134,
    
    //设备响应OTA异常
    TUYA_BLE_OTA_DEVICE_STATE_FAIL = 200,
    
    //设备文件校验失败
    TUYA_BLE_OTA_DEVICE_FILE_CHECK_FAIL,
    
    //设备偏移量异常
    TUYA_BLE_OTA_OFFSET_INDEX_FAIL,
    
    //设备返回大包ack失败
    TUYA_BLE_OTA_ACK_FAIL,
    
    //固件发送失败
    TUYA_BLE_OTA_SEND_FAIL,
    
    //设备最终返回升级失败
    TUYA_BLE_OTA_RESULT_FAIL,
    
    //ota超时
    BLE_OTA_TIME_OUT,
    
    //大数据传输失败
    TUYA_BLE_BIGDATA_RESULT_FAIL,
    
    /// 网关不支持 zigbee 双模配网
    TUYA_BLE_ZIGBEE_GATEWAY_NOT_SUPPORET = 400,
    
    /// 收到 zigbee 子设备设备信息错误
    TUYA_BLE_RECEIVE_ZIGBEE_INFO_FAIL,
    
    /// 收到 zigbee 子设备指令信息错误
    TUYA_BLE_RECEIVE_ZIGBEE_COMMAND_FAIL,
    
    /// 收到 zigbee 网关上报的配网错误
    TUYA_BLE_RECEIVE_ZIGBEE_GATEWAY_ERROR,
    
    /// 收到 zigbee 网关上报的数据解析错误
    TUYA_BLE_RECEIVE_ZIGBEE_GATEWAY_INFO_ERROR,
    
    /// zigbee 双模配网，下发网关信息失败
    TUYA_BLE_SEND_ZIGBEE_GATEWAY_INFO_FAIL,
    
    /// zigbee 双模配网，设备回复网关信息无效
    TUYA_BLE_SEND_ZIGBEE_GATEWAY_INFO_ERROR,
    
    /// 参数错误
    TUYA_BLE_PARAM_ERROR,
    
    /// 设备正在 OTA 中
    TUYA_BLE_INSTRUCTION_STATE_OTA_FAIL = 600,
    
    /// 设备正在 OTA 中
    TUYA_BLE_INSTRUCTION_OFFLINE_FAIL,
    
} TYBLEErrorCode;


@interface NSError (BLEError)

+ (instancetype)tysdk_BLEErrorWithErrorCode:(TYBLEErrorCode)errorCode errorMsg:(NSString *)errorMsg;

+ (NSError *)tysdk_BLEErrorWithErrorCode:(TYBLEErrorCode)errorCode;

@end
