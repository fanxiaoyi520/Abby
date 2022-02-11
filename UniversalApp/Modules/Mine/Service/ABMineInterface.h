//
//  ABMineInterface.h
//  UniversalApp
//
//  Created by Baypac on 2022/1/20.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABMineInterface : NSObject

/// 个人中心
+ (void)mine_personalCenterWithParams:(NSDictionary * _Nullable)params success:(void(^)(id responseObject))success;

/// 修改头像
+ (void)mine_userAvatarWithParams:(NSDictionary *)params success:(void(^)(id responseObject))success;

/// 修改昵称
+ (void)mine_userNickNameWithParams:(NSDictionary *)params success:(void(^)(id responseObject))success;

/// 上传图片至服务器后台
+ (void)mine_transportImgToServerWithImg:(UIImage *)img success:(void(^)(id responseObject))success;

/// 消息中心
+ (void)mine_MessageCenterWithParams:(NSDictionary *)params success:(void(^)(id responseObject))success;
@end

NS_ASSUME_NONNULL_END
