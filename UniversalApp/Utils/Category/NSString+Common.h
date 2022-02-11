//
//  NSString+Common.h
//  teamwork
//
//  Created by 张俊彬 on 2019/8/8.
//  Copyright © 2019 Zhengzhou Yutong Bus Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Common)
//获得字符串高度
-(CGFloat)getHeightWithWidth:(CGFloat)width Font:(UIFont*)font;
//获取字符串宽度
-(CGFloat)getWidthWithHeight:(CGFloat)height Font:(UIFont*)font;
//群聊添加人数字符串修饰
-(NSString*)groupIMWithMaxwidth:(CGFloat)maxwidth Font:(UIFont*)font UserCount:(int)userCount;
//判断邮箱格式是否正确
+(BOOL)jaf_isValidateEmailString:(NSString*)string;
//获得32位随机uuid
+(NSString *)jaf_uuidString;
//转化为base64
-(NSString*)jaf_base64;
//获取URL中的参数
-(NSMutableDictionary*)jaf_getUrlParam;
//通过路径获取mimetype
-(NSString*)jaf_getMimeType;
//获得第一帧图片
+ (UIImage *)xy_getVideoThumbnail:(NSString *)filePath;
// MARK: 设备当前连接的wifi信息
+(NSString *)getDeviceConnectWifiName;
+(NSString *)getDeviceConnectWifiAddress;
+(NSString *)getDeviceConnectWifiData;
//MARK: 获取当前时间----
// 毫秒
+(NSString *)getNowTimeTimestamp3;

@end

NS_ASSUME_NONNULL_END
