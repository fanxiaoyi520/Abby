//
//  NSString+Common.m
//  teamwork
//
//  Created by 张俊彬 on 2019/8/8.
//  Copyright © 2019 Zhengzhou Yutong Bus Co.,Ltd. All rights reserved.
//

#import "NSString+Common.h"
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <Photos/Photos.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <sys/utsname.h>

@implementation NSString (Common)
-(CGFloat)getHeightWithWidth:(CGFloat)width Font:(UIFont*)font{
    // 段落设置与实际显示的 Label 属性一致 采用 NSMutableParagraphStyle 设置Nib 中 Label 的相关属性传入到 NSAttributeString 中计算；
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    style.alignment = NSTextAlignmentLeft;
    if(self == nil && self.length == 0){
        return 0;
    }
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:self attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:style}];
    CGSize size =  [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    // 并不是高度计算不对，我估计是计算出来的数据是 小数，在应用到布局的时候稍微差一点点就不能保证按照计算时那样排列，所以为了确保布局按照我们计算的数据来，就在原来计算的基础上 取ceil值，再加1；
    return ceil(size.height) + 1;
}
-(CGFloat)getWidthWithHeight:(CGFloat)height Font:(UIFont*)font{
    // 段落设置与实际显示的 Label 属性一致 采用 NSMutableParagraphStyle 设置Nib 中 Label 的相关属性传入到 NSAttributeString 中计算；
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    style.alignment = NSTextAlignmentLeft;
    if(self == nil && self.length == 0){
        return 0;
    }
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:self attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:style}];
    
    CGSize size =  [string boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    // 并不是高度计算不对，我估计是计算出来的数据是 小数，在应用到布局的时候稍微差一点点就不能保证按照计算时那样排列，所以为了确保布局按照我们计算的数据来，就在原来计算的基础上 取ceil值，再加1；
    return ceil(size.width)+1;
}

-(NSString*)groupIMWithMaxwidth:(CGFloat)maxwidth Font:(UIFont*)font UserCount:(int)userCount{
    NSString* countStr = [NSString stringWithFormat:@"(%d)",userCount];
    NSString* finalStr = [self stringByAppendingString:countStr];
    CGFloat finalStrWidth = [finalStr getWidthWithHeight:40 Font:font];
    if(finalStrWidth <= maxwidth-20){//20为安全距离
        return finalStr;
    }else{
        return [self groupNameShortWithCountStr:countStr Maxwidth:maxwidth Font:font];
    }
}
-(NSString*)groupNameShortWithCountStr:(NSString*)countStr
                              Maxwidth:(CGFloat)maxwidth
                                  Font:(UIFont*)font{
    if(self.length <= 4){
        return [self stringByAppendingString:countStr];
    }
    NSString* shortName = [self substringWithRange:NSMakeRange(0, self.length-1)];
    shortName = [shortName stringByAppendingString:@"..."];
    NSString* finalName = [shortName stringByAppendingString:countStr];
    if([finalName getWidthWithHeight:40 Font:font] > maxwidth-20){
        shortName = [shortName substringWithRange:NSMakeRange(0, shortName.length-3)];
        return [shortName groupNameShortWithCountStr:countStr Maxwidth:maxwidth Font:font];
    }else{
        return finalName;
    }
}

+(BOOL)jaf_isValidateEmailString:(NSString*)string{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:string];
}

+ (NSString *)jaf_uuidString{
    
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    
    //去除UUID ”-“
    NSString *UUID = [[uuid lowercaseString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    NSLog(@"%@", UUID);
    
    return UUID;
    
}

-(NSString*)jaf_base64{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

-(NSMutableDictionary*)jaf_getUrlParam{
    
    // 查找参数
    NSRange range = [self rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    // 以字典形式将参数返回
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [self substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}


-(NSString*)jaf_getMimeType{
    NSString* sufix = [self componentsSeparatedByString:@"."].lastObject;
    
    if([sufix.lowercaseString isEqualToString:@"3gp"]) return @"video/3gpp";
    if([sufix.lowercaseString isEqualToString:@"apk"]) return @"application/vnd.android.package-archive";
    if([sufix.lowercaseString isEqualToString:@"asf"]) return @"video/x-ms-asf";
    if([sufix.lowercaseString isEqualToString:@"avi"]) return @"video/x-msvideo";
    if([sufix.lowercaseString isEqualToString:@"bin"]) return @"application/octet-stream";
    if([sufix.lowercaseString isEqualToString:@"bmp"]) return @"image/bmp";
    if([sufix.lowercaseString isEqualToString:@"c"]) return @"text/plain";
    if([sufix.lowercaseString isEqualToString:@"class"]) return @"application/octet-stream";
    if([sufix.lowercaseString isEqualToString:@"conf"]) return @"text/plain";
    if([sufix.lowercaseString isEqualToString:@"cpp"]) return @"text/plain";
    if([sufix.lowercaseString isEqualToString:@"doc"]) return @"application/msword";
    if([sufix.lowercaseString isEqualToString:@"docx"]) return @"application/vnd.openxmlformats-officedocument.wordprocessingml.document";
    if([sufix.lowercaseString isEqualToString:@"xls"]) return @"application/vnd.ms-excel";
    if([sufix.lowercaseString isEqualToString:@"xlsx"]) return @"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
    if([sufix.lowercaseString isEqualToString:@"exe"]) return @"application/octet-stream";
    if([sufix.lowercaseString isEqualToString:@"gif"]) return @"image/gif";
    if([sufix.lowercaseString isEqualToString:@"gtar"]) return @"application/x-gtar";
    if([sufix.lowercaseString isEqualToString:@"gz"]) return @"application/x-gzip";
    if([sufix.lowercaseString isEqualToString:@"h"]) return @"text/plain";
    if([sufix.lowercaseString isEqualToString:@"htm"]) return @"text/html";
    if([sufix.lowercaseString isEqualToString:@"html"]) return @"text/html";
    if([sufix.lowercaseString isEqualToString:@"jar"]) return @"application/java-archive";
    if([sufix.lowercaseString isEqualToString:@"java"]) return @"text/plain";
    if([sufix.lowercaseString isEqualToString:@"jpeg"]) return @"image/jpeg";
    if([sufix.lowercaseString isEqualToString:@"jpg"]) return @"image/jpeg";
    if([sufix.lowercaseString isEqualToString:@"js"]) return @"application/x-javascript";
    if([sufix.lowercaseString isEqualToString:@"log"]) return @"text/plain";
    if([sufix.lowercaseString isEqualToString:@"m3u"]) return @"audio/x-mpegurl";
    if([sufix.lowercaseString isEqualToString:@"m4a"]) return @"audio/mp4a-latm";
    if([sufix.lowercaseString isEqualToString:@"m4b"]) return @"audio/mp4a-latm";
    if([sufix.lowercaseString isEqualToString:@"m4p"]) return @"audio/mp4a-latm";
    if([sufix.lowercaseString isEqualToString:@"m4u"]) return @"video/vnd.mpegurl";
    if([sufix.lowercaseString isEqualToString:@"m4v"]) return @"video/x-m4v";
    if([sufix.lowercaseString isEqualToString:@"mov"]) return @"video/quicktime";
    if([sufix.lowercaseString isEqualToString:@"mp2"]) return @"audio/x-mpeg";
    if([sufix.lowercaseString isEqualToString:@"mp3"]) return @"audio/x-mpeg";
    if([sufix.lowercaseString isEqualToString:@"mp4"]) return @"video/mp4";
    if([sufix.lowercaseString isEqualToString:@"mpc"]) return @"application/vnd.mpohun.certificate";
    if([sufix.lowercaseString isEqualToString:@"mpe"]) return @"video/mpeg";
    if([sufix.lowercaseString isEqualToString:@"mpeg"]) return @"video/mpeg";
    if([sufix.lowercaseString isEqualToString:@"mpg"]) return @"video/mpeg";
    if([sufix.lowercaseString isEqualToString:@"mpg4"]) return @"video/mp4";
    if([sufix.lowercaseString isEqualToString:@"mpga"]) return @"audio/mpeg";
    if([sufix.lowercaseString isEqualToString:@"msg"]) return @"application/vnd.ms-outlook";
    if([sufix.lowercaseString isEqualToString:@"ogg"]) return @"audio/ogg";
    if([sufix.lowercaseString isEqualToString:@"pdf"]) return @"application/pdf";
    if([sufix.lowercaseString isEqualToString:@"png"]) return @"image/png";
    if([sufix.lowercaseString isEqualToString:@"pps"]) return @"application/vnd.ms-powerpoint";
    if([sufix.lowercaseString isEqualToString:@"ppt"]) return @"application/vnd.ms-powerpoint";
    if([sufix.lowercaseString isEqualToString:@"pptx"]) return @"application/vnd.openxmlformats-officedocument.presentationml.presentation";
    if([sufix.lowercaseString isEqualToString:@"prop"]) return @"text/plain";
    if([sufix.lowercaseString isEqualToString:@"rc"]) return @"text/plain";
    if([sufix.lowercaseString isEqualToString:@"rmvb"]) return @"audio/x-pn-realaudio";
    if([sufix.lowercaseString isEqualToString:@"rtf"]) return @"application/rtf";
    if([sufix.lowercaseString isEqualToString:@"sh"]) return @"text/plain";
    if([sufix.lowercaseString isEqualToString:@"tar"]) return @"application/x-tar";
    if([sufix.lowercaseString isEqualToString:@"tgz"]) return @"application/x-compressed";
    if([sufix.lowercaseString isEqualToString:@"txt"]) return @"text/plain";
    if([sufix.lowercaseString isEqualToString:@"wav"]) return @"audio/x-wav";
    if([sufix.lowercaseString isEqualToString:@"wma"]) return @"audio/x-ms-wma";
    if([sufix.lowercaseString isEqualToString:@"wmv"]) return @"audio/x-ms-wmv";
    if([sufix.lowercaseString isEqualToString:@"wps"]) return @"application/vnd.ms-works";
    if([sufix.lowercaseString isEqualToString:@"xml"]) return @"text/plain";
    if([sufix.lowercaseString isEqualToString:@"z"]) return @"application/x-compress";
    if([sufix.lowercaseString isEqualToString:@"zip"]) return @"application/x-zip-compressed";
    

    return @"application/octet-stream";
}

+ (UIImage *)xy_getVideoThumbnail:(NSString *)filePath
{
    NSURL *sourceURL = [NSURL fileURLWithPath:filePath];
    AVAsset *asset = [AVAsset assetWithURL:sourceURL];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    imageGenerator.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMake(0, 1);
    NSError *error;
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:&error];
    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);  // CGImageRef won't be released by ARC
    return thumbnail;
}

// MARK: 设备当前连接的wifi信息
+(NSString *)getDeviceConnectWifiName{
    NSArray *ifs = (__bridge id)CNCopySupportedInterfaces();
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge id)CNCopyCurrentNetworkInfo((CFStringRef)CFBridgingRetain(ifnam));
        if (info && [info count]) {
            break;
        }
    }
    if ([info isKindOfClass:[NSDictionary class]]) {
        //获取SSID
        return [info objectForKey:@"SSID"];
    }
    return nil;
}

+(NSString *)getDeviceConnectWifiAddress{
    NSArray *ifs = (__bridge id)CNCopySupportedInterfaces();
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge id)CNCopyCurrentNetworkInfo((CFStringRef)CFBridgingRetain(ifnam));
        if (info && [info count]) {
            break;
        }
    }
    if ([info isKindOfClass:[NSDictionary class]]) {
        //获取BSSID
        return [info objectForKey:@"BSSID"];
    }
    return nil;
}
+(NSString *)getDeviceConnectWifiData{
    NSArray *ifs = (__bridge id)CNCopySupportedInterfaces();
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge id)CNCopyCurrentNetworkInfo((CFStringRef)CFBridgingRetain(ifnam));
        if (info && [info count]) {
            break;
        }
    }
    if ([info isKindOfClass:[NSDictionary class]]) {
        //获取SSIDDATA
        return [info objectForKey:@"SSIDDATA"];
    }
    return nil;
}

//MARK: 获取当前时间----
// 毫秒
+(NSString *)getNowTimeTimestamp3 {

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式

    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970]*1000)];

    return timeSp;
}

@end
