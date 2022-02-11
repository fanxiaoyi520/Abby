//
//  TYDefaultPanelModel.h
//  TuyaDefaultPanelUI
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)

#import <Foundation/Foundation.h>
@class TYDefaultPanelFunctionsModel;

NS_ASSUME_NONNULL_BEGIN

@interface TYDefaultPanelModel : NSObject

@property (nonatomic, copy) NSArray <TYDefaultPanelFunctionsModel *> *functions;
@property (nonatomic, copy) NSString *theme;
@property (nonatomic, copy) NSString *deviceName;
@property (nonatomic, copy) NSString *devId;
@property (nonatomic, strong) TYDefaultPanelFunctionsModel *powerModel; /// 底部开关功能点

- (instancetype)initWithPanelConfigDictionary:(NSDictionary*)dictionary;


@end

NS_ASSUME_NONNULL_END
