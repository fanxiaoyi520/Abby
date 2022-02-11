//
//  ABUnlockLoopLogic.h
//  UniversalApp
//
//  Created by Baypac on 2022/1/14.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABUnlockLoopLogic : NSObject
@property (nonatomic,strong) NSMutableArray * dataArray;//数据源
@property (nonatomic,assign) NSInteger  page;//页码

@property(nonatomic,weak)id<ABGlobalDelegate> delegagte;

/**
 拉取数据
 */
-(void)loadData;
@end

NS_ASSUME_NONNULL_END
