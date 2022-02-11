//
//  TYCRC32.h
//  TuyaSmartKitExample
//
//  Created by 吴戈 on 2018/9/14.
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com)
//

#import <Foundation/Foundation.h>

@interface TYCRC32 : NSObject

+ (NSString *)crc32:(NSString *)packageData;

@end
