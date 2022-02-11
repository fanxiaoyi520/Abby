//
//  TYBLEWriteService.h
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/8/11.
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com)
//

#import <Foundation/Foundation.h>
@class TYBLERequest;

@interface TYBLEWriteService : NSObject

- (void)addRequest:(TYBLERequest *)request;

- (BOOL)writeData:(TYBLECharacteristic *)writeCharacteristic data:(NSData *)data ifNeedTimeout:(double)timeout;

@end
