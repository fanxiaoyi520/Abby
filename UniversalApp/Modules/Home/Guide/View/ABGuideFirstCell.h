//
//  ABGuideFirstCell.h
//  UniversalApp
//
//  Created by Baypac on 2022/1/27.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABGuideModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol ABGuideFirstDelegate <NSObject>

- (void)guideFirstAction:(UIButton *)sender;

@end
@interface ABGuideFirstCell : UITableViewCell

@property (nonatomic ,strong) ABGuideFirstModel *model;
@property (nonatomic ,weak) id<ABGuideFirstDelegate> delegate;
- (void)updateSelStatus:(BOOL)isSel;
@end

NS_ASSUME_NONNULL_END
