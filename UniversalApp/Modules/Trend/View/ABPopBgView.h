//
//  ABPopBgView.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/30.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,ABPopType) {
    ABReport,
    ABDelete,
    ABDeleteAndSync
};

@protocol ABPopBgDelege <NSObject>
@optional
- (void)popBg_reportAction:(UIButton *)sender;
- (void)popBg_delegeAction:(UIButton *)sender;
- (void)popBg_syncAndTrendAction:(UISwitch *)sender;
@end
@interface ABPopBgView : UIView

@property (nonatomic ,weak) id <ABPopBgDelege> delegate;
+ (ABPopBgView *)loadPopBgViewWith:(ABPopType)popType;
@end

NS_ASSUME_NONNULL_END
