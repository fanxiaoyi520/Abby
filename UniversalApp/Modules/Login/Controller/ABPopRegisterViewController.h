//
//  ABPopRegisterViewController.h
//  UniversalApp
//
//  Created by Baypac on 2022/1/5.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ABPopRegisterDelegte <NSObject>

- (void)popRegister:(id)model;

@end
@interface ABPopRegisterViewController : RootViewController

@property (nonatomic ,weak) id<ABPopRegisterDelegte> delegate;
@property (nonatomic ,strong) ABNationModel *model;
@end

NS_ASSUME_NONNULL_END
