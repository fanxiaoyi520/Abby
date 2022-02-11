//
//  TYSmartUtilLog.h
//  kit project
//
//  Created by ange on 2021/4/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

void TYSDKLog(NSInteger level, NSString *module, const char *file, const char *function, NSUInteger line, NSString *format, ...);

#undef TYLog
#undef TYSDKLogDebug
#undef TYSDKLogInfo
#undef TYSDKLogWarn
#undef TYSDKLogError

#define TYLog(...) \
    TYSDKLog(1, @"TuyaSmartKit", __FILE__, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define TYSDKLogDebug(...) \
    TYSDKLog(0, @"TuyaSmartKit", __FILE__, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define TYSDKLogInfo(...) \
    TYSDKLog(1, @"TuyaSmartKit", __FILE__, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define TYSDKLogWarn(...) \
    TYSDKLog(2, @"TuyaSmartKit", __FILE__, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define TYSDKLogError(...) \
    TYSDKLog(3, @"TuyaSmartKit", __FILE__, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

@interface TYSmartUtilLog : NSObject

+ (TYSmartUtilLog *)sharedInstance;
/// Debug mode, default is false. Verbose log will print into console if opened.
@property (nonatomic, assign) BOOL debugMode;
/// default is false.
@property (nonatomic, assign) BOOL logToTYLogLibrary;

@end

NS_ASSUME_NONNULL_END
