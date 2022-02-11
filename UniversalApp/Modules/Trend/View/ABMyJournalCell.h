//
//  ABMyJournalCell.h
//  UniversalApp
//
//  Created by Baypac on 2022/1/4.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABTrentModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ABMyJournalCellFuncDelegate <NSObject>

- (void)myJournal_LikeAction:(UIButton *)sender;
- (void)myJournal_giftAction:(UIButton *)sender;
- (void)myJournal_downloadAction:(UIButton *)sender;
- (void)myJournal_moreAction:(UIButton *)sender;
- (void)myJournal_deviceDataPopAction:(UITapGestureRecognizer *)tap;
- (void)myJournal_updeteCellHeight:(UIButton *)sender;
@end

@interface ABMyJournalCell : UITableViewCell

@property (nonatomic ,strong) ABTrentModel *model;
@property (nonatomic ,weak) id <ABMyJournalCellFuncDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
