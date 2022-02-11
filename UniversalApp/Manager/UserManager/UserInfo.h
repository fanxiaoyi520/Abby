//
//  UserInfo.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/23.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DomainInfo;

typedef NS_ENUM(NSInteger,UserGender){
    UserGenderUnKnow = 0,
    UserGenderMale, //男
    UserGenderFemale //女
};

@interface UserInfo : NSObject

@property(nonatomic, copy) NSString * easemobId;//环信Id
@property (nonatomic,copy) NSString * easemobPassword;//环信登陆密码
@property (nonatomic,copy) NSString * easemobUserName;//环信账户
@property (nonatomic,copy) NSString * token;
@property (nonatomic,copy) NSString * tuyaCountryCode;//涂鸦国家码
@property (nonatomic,copy) NSString * tuyaPassword;//涂鸦密码
@property (nonatomic,copy) NSString * tuyaUserId;
@property (nonatomic,copy) NSString * tuyaUserType;
@property (nonatomic,copy) NSString * email;
@end

