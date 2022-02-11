//
//  TYDefaultPanelFunctionsModel.h
//  TuyaDefaultPanelUI
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYDefaultPanelSchemaPropertyModel : NSObject

@property (nonatomic, strong) NSString   *type;
@property (nonatomic, strong) NSString   *unit;
@property (nonatomic, assign) double     min;
@property (nonatomic, assign) double     max;
@property (nonatomic, assign) double     step;
@property (nonatomic, assign) NSInteger  scale;
@property (nonatomic, assign) NSInteger  maxlen;
@property (nonatomic, strong) NSArray    *label;
@property (nonatomic, strong) NSArray    *range;
@property (nonatomic, assign) NSInteger selectedValue;

@end

@interface TYDefaultPanelFunctionsModel : NSObject

@property (nonatomic, copy) NSString *dpID;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *mode;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *schemaType;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *dps;
@property (nonatomic, copy) NSString *element; // 模块 大小
@property (nonatomic, copy) NSString *background;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) TYDefaultPanelSchemaPropertyModel *property;

@end

NS_ASSUME_NONNULL_END
