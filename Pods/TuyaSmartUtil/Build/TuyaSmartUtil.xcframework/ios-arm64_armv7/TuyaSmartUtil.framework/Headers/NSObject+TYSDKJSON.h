//
//  NSObject+TYSDKJSON.h
//  TuyaSmartUtil
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com)
//

#import <Foundation/Foundation.h>

@interface NSString (TYSDKJSON)
- (id)tysdk_objectFromJSONString;
- (id)tysdk_objectFromJSONString:(NSJSONReadingOptions)serializeOptions error:(NSError **)error;
@end

@interface NSArray (TYSDKJSON)
- (NSString *)tysdk_JSONString;
- (NSString *)tysdk_JSONStringWithOptions:(NSJSONWritingOptions)serializeOptions error:(NSError **)error;
@end

@interface NSDictionary (TYSDKJSON)
- (NSString *)tysdk_JSONString;
- (NSString *)tysdk_JSONStringWithOptions:(NSJSONWritingOptions)serializeOptions error:(NSError **)error;
@end
