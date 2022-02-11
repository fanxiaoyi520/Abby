//
//  ABOxygenBillModel.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/8.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ABOxygenBillListModel;
@interface ABOxygenBillModel : NSObject

@property (nonatomic , copy) NSString *total;
@property (nonatomic , copy) NSString *income;
@property (nonatomic , copy) NSString *expense;
@property (nonatomic , copy) NSString *date;
@property (nonatomic , strong) NSArray *list;

@end

@interface ABOxygenBillListModel : NSObject

@property (nonatomic , copy) NSString *reward;
@property (nonatomic , copy) NSString *time;
@property (nonatomic , copy) NSString *rewardNum;
@end

NS_ASSUME_NONNULL_END
