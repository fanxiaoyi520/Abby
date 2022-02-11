//
//  TuyaSmartSocketThreadTool.h
//  Pods
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSocketThreadTool : NSObject

@property (nonatomic, class, readonly) TuyaSmartSocketThreadTool *sharedInstance;

- (void)dispatchOnSocketQueue:(dispatch_block_t)block async:(BOOL)async;

@end

NS_ASSUME_NONNULL_END
