//
//  ABTrentModel.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/1.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ABTrentImageModel;
@interface ABTrentModel : NSObject

@property (nonatomic ,copy)NSString *user_id;
@property (nonatomic ,copy)NSString *content;//动态内容
@property (nonatomic ,copy)NSString *week;//周
@property (nonatomic ,copy)NSString *day;//日
@property (nonatomic ,copy)NSString *height;//高度
@property (nonatomic ,copy)NSString *temperature;//气温
@property (nonatomic ,copy)NSString *wahter;//水
@property (nonatomic ,copy)NSString *humidity;//湿度
@property (nonatomic ,copy)NSString *syncTrend;//是否同步到广场
@property (nonatomic ,copy)NSString *openDate;//种植数据是否可见
@property (nonatomic ,copy)NSString *reward;//打赏
@property (nonatomic ,copy)NSString *praise;//点赞
@property (nonatomic ,copy)NSString *createTime;
@property (nonatomic ,copy)NSString *updateTime;
@property (nonatomic ,copy)NSString *isDeleted;//是否删除
@property (nonatomic ,strong)NSArray<ABTrentImageModel *> *images;

@end

@interface ABTrentImageModel : NSObject

@property (nonatomic ,copy)NSString *imageUrl;
@end
NS_ASSUME_NONNULL_END
