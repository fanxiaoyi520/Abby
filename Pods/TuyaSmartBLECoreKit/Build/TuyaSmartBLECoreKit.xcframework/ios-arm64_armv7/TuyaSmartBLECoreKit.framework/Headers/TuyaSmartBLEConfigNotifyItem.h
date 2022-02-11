//
//  TuyaSmartBLEConfigNotifyItem.h
//  TuyaSmartBLEKit
//
//  Created by yuguo on 2021/5/19.
//

#import <Foundation/Foundation.h>
#import "TYBLECMDToken.h"
#import "TuyaSmartBLEMutliTsfDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartBLEConfigNotifyItem : NSObject

@property (nonatomic, strong, nullable) NSData *businessData;
@property (nonatomic, strong, nullable) NSData *decryptData;
@property (nonatomic, strong, nullable) NSData *snData;
@property (nonatomic, strong, nullable) NSData *ackData;
@property (nonatomic, strong, nullable) NSData *functionData;

@property (nonatomic, assign) frame_sec_type_t frameSecType; // frame_sec_type_t, secret
@property (nonatomic, assign) frame_type_t frameType; // frame_type_t, classic、plus
@property (nonatomic, assign) TYBLEConfigType configType; // type or functionDataType -> configType

@property (nonatomic, strong) TYBLECMDToken *token;

@end

NS_ASSUME_NONNULL_END
