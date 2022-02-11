//
//  IMManager.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/6/5.
//  Copyright © 2017年 徐阳. All rights reserved.
//

typedef NS_ENUM(NSInteger,ServiceNumberType) {
    ServiceNumber_Default,//默认
    ServiceNumber_CustomerService,//客服
    ServiceNumber_Expert, //专家
};

#import <Foundation/Foundation.h>
#import "RootViewController.h"

typedef void (^loginBlock)(BOOL success, NSString * des);

/**
 IM服务与管理
 */
@interface IMManager : NSObject

SINGLETON_FOR_HEADER(IMManager);

/**
 初始化IM
 */
-(void)initIM;


/**
 登录IM

 @param IMID IM账号
 @param IMPwd IM密码
 @param completion block回调
 */
-(void)IMLogin:(NSString *)IMID IMPwd:(NSString *)IMPwd completion:(loginBlock)completion;

/**
 退出IM
 */
-(void)IMLogout;


/**
 进入聊天界面
 */
- (void)IMGoChatVC:(RootViewController *)vc withServiceNumberType:(ServiceNumberType)type;
@end
