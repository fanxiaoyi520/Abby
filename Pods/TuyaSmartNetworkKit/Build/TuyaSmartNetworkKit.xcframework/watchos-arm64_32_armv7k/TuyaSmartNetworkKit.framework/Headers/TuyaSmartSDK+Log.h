//
// TuyaSmartSDK+Log.h
// TuyaSmartBaseKit
//
// Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com)

#ifndef TuyaSmartSDK_Log_h
#define TuyaSmartSDK_Log_h

#import "TuyaSmartSDK.h"

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSDK (Log)

/// Debug mode, default is false. Verbose log will print into console if opened.
@property (nonatomic, assign) BOOL debugMode;

@end

NS_ASSUME_NONNULL_END

#endif /* TuyaSmartSDK_Log_h */
