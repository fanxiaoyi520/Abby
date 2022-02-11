//
//  GameInfo.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/31.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DomainInfo : NSObject

@property (nonatomic,copy) NSString * aispeechHttpsUrl;
@property (nonatomic,copy) NSString * aispeechQuicUrl;
@property (nonatomic,copy) NSString * deviceHttpUrl;
@property (nonatomic,copy) NSString * deviceHttpsPskUrl;
@property (nonatomic,copy) NSString * deviceHttpsUrl;
@property (nonatomic,copy) NSString * deviceMediaMqttUrl;
@property (nonatomic,copy) NSString * deviceMediaMqttsUrl;
@property (nonatomic,copy) NSString * deviceMqttsPskUrl;
@property (nonatomic,copy) NSString * deviceMqttsUrl;
@property (nonatomic,copy) NSString * gwApiUrl;
@property (nonatomic,copy) NSString * gwMqttUrl;
@property (nonatomic,copy) NSString * httpPort;
@property (nonatomic,copy) NSString * httpsPort;
@property (nonatomic,copy) NSString * httpsPskPort;
@property (nonatomic,copy) NSString * mobileApiUrl;
@property (nonatomic,copy) NSString * mobileMediaMqttUrl;
@property (nonatomic,copy) NSString * mobileMqttUrl;
@property (nonatomic,copy) NSString * mobileMqttsUrl;
@property (nonatomic,copy) NSString * mobileQuicUrl;
@property (nonatomic,copy) NSString * mqttPort;
@property (nonatomic,copy) NSString * mqttQuicUrl;
@property (nonatomic,copy) NSString * mqttsPort;
@property (nonatomic,copy) NSString * mqttsPskPort;
@property (nonatomic,copy) NSString * pxApiUrl;
@property (nonatomic,copy) NSString * regionCode;
@property (nonatomic,copy) NSString * tuyaAppUrl;
@property (nonatomic,copy) NSString * tuyaImagesUrl;

@end
