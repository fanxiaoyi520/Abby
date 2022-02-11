//
//  ABPopView.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/15.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ABPopViewDelegate <NSObject>

- (void)startFuncAction:(UIButton *)sender;

@end
@interface ABPopView : UIImageView

@property (nonatomic ,weak) id<ABPopViewDelegate> delegate;
@property (nonatomic ,copy) NSString *titleStr;
@property (nonatomic ,copy) NSString *sureBtnStr;
@property (nonatomic ,assign) BOOL isHiddenClose;
@property (nonatomic ,assign) NSInteger sureTag;

@end

NS_ASSUME_NONNULL_END
