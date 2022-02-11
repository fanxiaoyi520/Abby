//
//  TYBLEActiveUtils.h
//  TuyaSmartBLEKit
//
//  Created by yuguo on 2021/4/13.
//

NS_ASSUME_NONNULL_BEGIN

@interface TYBLEActiveUtils : NSObject

+ (void)fetchEncryptionKeyFromServe:(TYBLEAdvModel *)advModel
                             homeId:(long long)homeId
                            success:(TYSuccessID)success
                            failure:(TYFailureError)failure;

+ (void)activeDMDevice:(NSDictionary *)postData success:(TYSuccessID)success failure:(TYFailureError)failure;

+ (void)getEnvWithSuccess:(TYSuccessID)success failure:(TYFailureError)failure;

@end

NS_ASSUME_NONNULL_END
