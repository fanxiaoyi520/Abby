//
//  NSObject+TYSDKCategory.h
//  TuyaSmartUtil
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com)
//

#import <Foundation/Foundation.h>

@interface NSObject (TYSDKCategory)

/// String or Number to Int.
/// e.g. @"1A" -> 1, @"-10xc" -> -10, @(10) or @"10" -> 10
- (NSInteger)tysdk_toInt;

/// String or Number to UInt.
/// e.g. @"1A" -> 1, @"-10xc" -> NSUIntegerMax, @(10) or @"10" -> 10
- (NSUInteger)tysdk_toUInt;

/// Hex string or data to UInt.
/// e.g. @"0x0010" -> 16, @(10) -> 16, NSData bytes 0x0010 -> 16
- (NSUInteger)tysdk_hexToUInt;

- (NSString *)tysdk_toString;

- (float)tysdk_toFloat;

- (double)tysdk_toDouble;

- (NSArray *)tysdk_toArray;

- (NSDictionary *)tysdk_toDictionary;

- (BOOL)tysdk_toBool;

+ (BOOL)tysdk_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;

+ (BOOL)tysdk_swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;

@end
