//
//  ABMainHomeView.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/17.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABFuncView.h"
#import "ABBotanyView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABMainHomeView : UIView
@property (nonatomic ,strong) ABBotanyView *botanyView;
@property (nonatomic ,strong) ABFuncView *funcView;
@property (nonatomic ,weak) id<ABMainHomeDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
