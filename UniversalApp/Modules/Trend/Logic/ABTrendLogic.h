//
//  ABTrendLogic.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/1.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABTrentModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ABTrendDelegate <NSObject>
@optional
/**
 数据加载完成
 */
-(void)requestDataCompleted;

@end

@interface ABTrendLogic : NSObject
@property (nonatomic,strong) NSMutableArray * dataArray;//数据源
@property (nonatomic,assign) NSInteger  page;//页码

@property(nonatomic,weak)id<ABTrendDelegate> delegagte;

/**
 拉取数据
 */
-(void)loadData;
// 动态计算cell高度
+ (CGFloat)dynamicallyCalculateCellHeight:(ABTrentModel *)model;
+ (CGFloat)dynamicallyCalculateCellHeight:(ABTrentModel *)model isShowMore:(BOOL)isShowMore;
@end

NS_ASSUME_NONNULL_END
