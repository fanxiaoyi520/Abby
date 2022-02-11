//
//  NSObject+TYSDKSubValue.h
//  TuyaSmartBLEKit
//
//  Created by 吴戈 on 2019/7/15.
//

#import <Foundation/Foundation.h>

@interface NSData (TYSDKSubValue)

- (NSData *)tysdk_subdataWithRange:(NSRange)range;

@end


@interface NSString (TYSDKSubValue)

- (NSString *)tysdk_substringFromIndex:(NSUInteger)from;

- (NSString *)tysdk_substringToIndex:(NSUInteger)to;

- (NSString *)tysdk_substringWithRange:(NSRange)range;

@end
