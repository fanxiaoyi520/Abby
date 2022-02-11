//
//  ABBlueToothSearchCell.h
//  UniversalApp
//
//  Created by Baypac on 2021/11/26.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ABAddBlueToothDelegate <NSObject>

- (void)addBlueTooth:(id)info;
@end

@interface ABBlueToothSearchCell : UITableViewCell

@property (nonatomic ,strong) TYBLEAdvModel *peripheral;
@property (nonatomic ,weak) id <ABAddBlueToothDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
