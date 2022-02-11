//
//  ABReplantViewController.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/9.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^Block) (void);
@interface ABReplantViewController : RootViewController

@property (nonatomic , copy) Block block;
@end

NS_ASSUME_NONNULL_END
