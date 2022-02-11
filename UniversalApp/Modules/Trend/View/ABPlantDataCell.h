//
//  ABPlantDataCell.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/30.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABPlantDataCell : UITableViewCell

@property (nonatomic ,strong) NSDictionary *dic;
@property (nonatomic ,strong) UIView *lineView;
@end

NS_ASSUME_NONNULL_END
