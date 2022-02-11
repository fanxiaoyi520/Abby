//
//  NSData+TYCoreCategory.h
//  Pods
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (TYCoreCategory)

- (NSString *)tyCore_UTF8String;

- (NSData*)tyCore_dataByHealingUTF8Stream;

@end

NS_ASSUME_NONNULL_END
