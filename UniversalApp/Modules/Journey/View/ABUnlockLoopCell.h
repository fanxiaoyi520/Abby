//
//  ABUnlockLoopCell.h
//  UniversalApp
//
//  Created by Baypac on 2022/1/14.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABUnlockLoopModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol ABUnlockLoopCellDelegate <NSObject>

- (void)unlockLoopCell_selFuncAction:(UIButton *)sender;
@end
@interface ABUnlockLoopCell : UITableViewCell

@property (nonatomic ,strong) ABUnlockLoopModel *model;
@property (nonatomic ,weak) id <ABUnlockLoopCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
