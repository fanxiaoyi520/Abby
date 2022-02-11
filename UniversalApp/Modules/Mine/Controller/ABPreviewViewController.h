//
//  ABPreviewViewController.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/14.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "RootViewController.h"
#import "ABMineModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^Block) (void);
@interface ABPreviewViewController : RootViewController

@property (nonatomic ,strong) ABMineServerModel *mineServerModel;
@property (nonatomic ,copy) Block block;
@end

NS_ASSUME_NONNULL_END
