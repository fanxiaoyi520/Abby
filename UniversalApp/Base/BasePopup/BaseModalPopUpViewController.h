//
//  BaseModalPopUpViewController.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/15.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseModalPopUpViewController : RootViewController

@property (nonatomic , weak) id <ABGuideViewDelegate> delegate;
@property (nonatomic ,strong)UIView *bgView;
@property (nonatomic ,strong)UILabel *contentLab;
@property (nonatomic ,strong)UIButton *sureBtn;
// 弹窗高度
@property (nonatomic ,assign)CGFloat bg_Height;
// 关闭按钮位置
@property (nonatomic ,assign)BOOL isLeft;
// 文本内容
@property (nonatomic ,copy)NSString *content_Str;
// 文本颜色
@property (nonatomic ,copy)NSString *content_color_Str;
// 确认按钮文字
@property (nonatomic ,copy)NSString *btn_Title;
// 确认按钮背景色----16进制
@property (nonatomic ,copy)NSString *btn_bg_Color;

- (void)sureBtnFuncAction:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
