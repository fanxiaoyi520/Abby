//
//  ABMineHeaderView.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/2.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABMineModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ABHeaderViewDelegate <NSObject>

-(void)headerViewClick;
@end

@interface ABMineHeaderView : UIView
@property(nonatomic, strong) UIImageView *headImgView; //头像
@property(nonatomic, assign) id<ABHeaderViewDelegate> delegate;
@property(nonatomic, strong) ABMineServerModel *model;
@end

NS_ASSUME_NONNULL_END
