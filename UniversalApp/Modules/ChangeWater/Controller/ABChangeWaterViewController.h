//
//  ABChangeWaterViewController.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/24.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "BaseModalPopUpViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ABChangeWaterDelegate <NSObject>

- (void)changeWater_sureBtn:(UIButton *)sender;

@end
@interface ABChangeWaterViewController : BaseModalPopUpViewController

@property (nonatomic ,weak) id <ABChangeWaterDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
