//
//  TYBLECMDToken.h
//  TuyaSmartBLEKit
//
//  Created by 吴戈 on 2020/1/13.
//

#import <Foundation/Foundation.h>
#import "TYBLECryptologyProtcol.h"
NS_ASSUME_NONNULL_BEGIN

@interface TYBLECMDToken : NSObject

@property (nonatomic, assign) TYBLEConfigType               cmdType;

@property (nonatomic, copy, nullable) TYFailureError        failure;
@property (nonatomic, copy, nullable) TYSuccessData         success;
@property (nonatomic, strong) NSData                        *data;
@property (nonatomic, strong) id<TYBLEDeviceInfoProtocol>   deviceInfo;

@end

NS_ASSUME_NONNULL_END
