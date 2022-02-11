//
//  TYBLEBizTools.h
//  TuyaSmartBLEKit
//
//  Created by yuguo on 2021/5/17.
//

#import <Foundation/Foundation.h>
#import <TuyaSmartBLECoreKit/TYBLEDeviceInfoProtocol.h>
#import <TuyaSmartBLECoreKit/TYBLEGeneralHelper.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYBLEBizTools : NSObject

//大数据command
/// 获取大数据摘要信息
/// @param type type
+ (NSData *)bigDataSummary:(unsigned int)type;

/// 获取大数据块摘要信息
/// @param type 类型
/// @param index 序号
+ (NSData *)bigDataBlockSummaryType:(unsigned int)type index:(NSInteger)index;

/// 删除大数据指令
/// @param type type
+ (NSData *)bigDataDel:(unsigned int)type ;

/**
 * 通过 UUID 换取设备 TuyaSmartDeviceModel
 */
+ (TuyaSmartDeviceModel *)getDeviceModelWithUUID:(NSString *)uuid;

/**
 *  设备是否属于当前账号
 */
+ (BOOL)deviceIsActive:(NSString *)uuid;

/**
*  判断是否是双模多协议设备
*/
+ (BOOL)isDualModeDevice:(NSString *)uuid;

/**
*  判断双模多协议设备是否需要连接控制
*/
+ (BOOL)dualModeDeviceSupportBLEControl:(id <TYBLEDeviceInfoProtocol>)deviceInfo;

#pragma mark - 设备强制解绑
/**
 *  查询设备是否属于其他账号
 */
- (void)unbindDeviceHandle:(TYBLEAdvModel *)item success:(TYSuccessHandler)success failure:(TYFailureHandler)failure;

/**
 *  重置设备查询缓存
 */
- (void)removeUnbindDeviceFlag:(NSString *)unbindDeviceId;

+ (void)updateBLEDeviceOnline:(TuyaSmartDeviceModel *)device;

/// 获取设备连接类型
+ (TYBLESupportConnect)getConfigConnectType:(id<TYBLEDeviceInfoProtocol>)dev;

@end

NS_ASSUME_NONNULL_END
