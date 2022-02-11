//
//  URLMacros.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/18.
//  Copyright © 2017年 徐阳. All rights reserved.
//



#ifndef URLMacros_h
#define URLMacros_h


//内部版本号 每次发版递增
#define KVersionCode 1
/*
 
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */

#define DevelopSever    0
#define TestSever       1
#define ProductSever    0

#if DevelopSever

/**开发服务器*/
#define URL_main @"http://10.125.60.207:9330/abby"

#elif TestSever

/**测试服务器*/
#define URL_main @"http://10.125.26.4:9330/abby"

#elif ProductSever

/**生产服务器*/
#define URL_main @"http://192.168.20.31:20000/shark-miai-service"
#endif



#pragma mark - ——————— 详细接口地址 ————————

//测试接口
//NSString *const URL_Test = @"api/recharge/price/list";
#define URL_Test @"/api/cast/home/start"



#pragma mark - ——————— ftp上传服务管理 ————————
#define URL_ftp_file @"/ftp/file"




#pragma mark - ——————— 注册登录 ————————
//自动登录
#define URL_user_auto_login @"/api/autoLogin"
//登录
#define URL_user_login @"/user/app/login"
//用户详情
#define URL_user_info_detail @"/api/user/info/detail"
//注释
#define URL_user_info_change @"/api/user/info/change"
//************
//注册账户邮箱发送验证码
#define URL_user_verify_email @"/user/verify/email"
//验证码验证
#define URL_user_verify_code @"/user/verify/code"
// 用户忘记密码后在app设置新密码
#define URL_user_app_updatePwd @"/user/app/updatePwd"
// 获取国家列表
#define URL_sysParams_nation @"/sysParams/nation"
/// app注册用户
#define URL_user_app_register @"/user/app/register"
// 用户退出
#define URL_user_logout @"/user/logout"



#pragma mark - ——————— 个人中心 ————————
// 获取用户头像，昵称，abbyID
#define URL_user_userDetail @"/user/userDetail"
// 修改头像
#define URL_user_avatar @"/user/avatar"
// 用户修改昵称
#define URL_user_nickName @"/user/nickName"


#endif /* URLMacros_h */
