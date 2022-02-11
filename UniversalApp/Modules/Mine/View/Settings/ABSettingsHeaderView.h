//
//  ABSettingsHeaderView.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/9.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ABSettingsDelegate <NSObject>

- (void)switchSetting:(UIButton *)sender;
@end

@interface ABSettingsHeaderView : UITableViewHeaderFooterView

@property (nonatomic ,weak) id<ABSettingsDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
