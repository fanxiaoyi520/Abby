//
//  TYBLEUtils.h
//  TuyaSmartKit
//
//  Created by 冯晓 on 2017/2/9.
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com)
//

#import <Foundation/Foundation.h>
#import "NSObject+TYSDKSubValue.h"

@interface TYBLEUtils : NSObject


+ (NSString *)hexStrToBCDCode:(NSString *)hexStr;

// x.y.z 版本号字符串转成四字节十六进制字符串
+ (NSString *)versionStringToHexString:(NSString *)versionStr;

// string 转换成 hexString
+ (NSString *)hexStringFromString:(NSString *)string;

// hexString 转换成 String
+ (NSString *)stringFromHexString:(NSString *)hexString;

// 16进制字符串转10进制字符串
+ (NSString *)numberWithHexString:(NSString *)hexString;
// 十六进制转二进制
+ (NSString *)getBinaryByHex:(NSString *)hex;
// 二进制十六转进制
+ (NSString *)getHexByBinary:(NSString *)binary;

// 把int 变成 16进制的字符串
+ (NSString *)ToHex:(unsigned int)number;

// 十六进制转换为自定义字符串表
+ (NSString *)getCustomPariseByBinary:(NSString *)hex;

// 自定义字符串表转换为十六进制
+ (NSString *)getHexByCustomParise:(NSString *)string;

// 大端小端互转
+ (NSString *)dataTransfromBigOrSmall:(NSString *)string;

// 字符串前位补零操作
+ (NSString *)addZeroToFront:(NSString *)str withLength:(int)length;

// 字符串后位补零操作
+ (NSString *)addZeroToBack:(NSString *)str withLength:(int)length;

// CRC32
+ (int32_t)crc32:(NSData *)data;

+ (NSString *)md5WithData:(NSData *)data;

// 生成随机字符串
+ (NSString *)generateTradeNO:(int)kNumber;

+ (BOOL)containVisiableString:(NSString *)string;

+ (NSString *)tyHexString:(NSString *)str;
@end
