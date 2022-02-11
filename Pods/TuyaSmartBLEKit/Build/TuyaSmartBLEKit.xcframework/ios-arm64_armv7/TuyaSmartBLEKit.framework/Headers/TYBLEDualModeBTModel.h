//
//  TYBLEDualModeBTModel.h
//  TuyaSmartBLEKit
//
// Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com)
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, TYBLEDualModeBTState) {
    TYBLEDualModeBTStateDisconnected = 0,
    TYBLEDualModeBTStateConnecting,
    TYBLEDualModeBTStateConnected,
};

@interface TYBLEDualModeBTModel : NSObject
/// The deviceName of the Bluetooth BT device.
@property (nonatomic, strong) NSString *deviceName;
/// The MacAddress of the Bluetooth BT device.
@property (nonatomic, strong) NSString *deviceMacAddress;
/// The Connect state of the Bluetooth BT device.
@property (nonatomic, assign) TYBLEDualModeBTState state;
/// The CTKD state of the Bluetooth BT device.
@property (nonatomic, assign) BOOL supportCTKD;
/// The Bond state of the Bluetooth BT device.
@property (nonatomic, assign) BOOL bond;

- (instancetype)initWithData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
