//
//  TYSmartDefaultPanelViewController.h
//  TuyaDefaultPanelUI
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)

#import <UIKit/UIKit.h>
@class TYDefaultPanelModel;
@class TYDefaultPanelFunctionsModel;

NS_ASSUME_NONNULL_BEGIN

@interface TuyaDefaultPanelUIKitViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TYDefaultPanelModel *panelModel;
@property (nonatomic, assign) NSInteger cellNumber;
@property (nonatomic, strong) NSArray *moduleDataArray;

- (NSInteger)numberOfRows;
/// 底部开关功能点
- (void)configBottomButtonWithModel:(TYDefaultPanelFunctionsModel *)model;

- (void)publishDpsWithParams:(NSArray *)params; /// 由子类实现，home sdk 取 fastobject，iot sdk 取 lastobject
- (NSString *)localizedStringForKey:(NSString *)key; /// 子类实现
- (NSString *)localizedDpValue:(TYDefaultPanelFunctionsModel *)schemaModel value:(NSString *)value; /// 子类实现

@end

NS_ASSUME_NONNULL_END
