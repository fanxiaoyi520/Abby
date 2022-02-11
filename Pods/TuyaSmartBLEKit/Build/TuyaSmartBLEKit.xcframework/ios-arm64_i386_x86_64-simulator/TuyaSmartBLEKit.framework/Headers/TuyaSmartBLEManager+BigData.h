//
//  TuyaSmartBLEManager+BigData.h
//  TuyaSmartBLEKit
//
//  Created by yuguo on 2021/5/15.
//

#import <TuyaSmartBLECoreKit/TuyaSmartBLEManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartBLEManager (BigData)

/// Sending parameters data to the BLE device, whilc make device report data through big data channels.
///
/// @param devId        The device Id for the device.
/// @param paramsDict   A dictionary of parameter, defined by the protocol party.
/// @param success      When ota successfully, this block will be called success.
/// @param failure      This block will be called if some error occurred.
- (void)postBleBigDataChannel:(NSString *)devId params:(NSDictionary *)paramsDict success:(TYSuccessHandler)success failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use postBleBigDataChannel: params:  progress: success: failure: instead");



/// Sending parameters data to the BLE device, whilc make device report data through big data channels.
///
/// @param devId        The device Id for the device.
/// @param paramsDict   A dictionary of parameter, defined by the protocol party.
/// @param progress     This  progress   block will be called if  report data revicein,progress   value is 0-100.
/// @param success      When ota successfully, this block will be called success.
/// @param failure      This block will be called if some error occurred.
- (void)postBleBigDataChannel:(NSString *)devId params:(NSDictionary *)paramsDict  progress:(nullable TYBLEBigDataProgressBlock)progress success:(TYSuccessDict)success failure:(TYFailureError)failure;

@end

NS_ASSUME_NONNULL_END
