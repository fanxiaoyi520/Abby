//
//  ABGuideSecondCell.h
//  UniversalApp
//
//  Created by Baypac on 2022/2/10.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABGuideSecondModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ABGuideSecondCellDelegate <NSObject>

- (void)guideSecondCell_selFuncAction:(UIButton *)sender;
@end

@interface ABGuideSecondCell : UITableViewCell

@property (nonatomic ,strong) ABGuideSecondModel *model;
@property (nonatomic ,weak) id <ABGuideSecondCellDelegate> delegate;
- (void)updateSelStatus:(BOOL)isSel;
@end

NS_ASSUME_NONNULL_END
