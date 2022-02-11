//
//  ABMineInterface.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/20.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABMineInterface.h"
#import "AFNetworking.h"

@implementation ABMineInterface
/// 个人中心
+ (void)mine_personalCenterWithParams:(NSDictionary * _Nullable)params success:(void(^)(id responseObject))success {
    [MBProgressHUD showActivityMessageInWindow:@""];
    [PPNetworkHelper POST:NSStringFormat(@"%@%@",URL_main,URL_user_userDetail) parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        if ([[responseObject[@"code"] stringValue] isEqualToString:@"200"]) {
            [MBProgressHUD hideHUD];
            if (success)success(responseObject);
        } else {
            KPostNotification(KNotificationLoginStateChange, @YES);
            [UIViewController jaf_showHudTip:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        KPostNotification(KNotificationLoginStateChange, @YES);
    }];
}

/// 修改头像
+ (void)mine_userAvatarWithParams:(NSDictionary *)params success:(void(^)(id responseObject))success {
    [MBProgressHUD showActivityMessageInWindow:@""];
    [PPNetworkHelper POST:NSStringFormat(@"%@%@",URL_main,URL_user_avatar) parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        if ([[responseObject[@"code"] stringValue] isEqualToString:@"200"]) {
            [MBProgressHUD hideHUD];
            if (success)success(responseObject);
        } else {
            [UIViewController jaf_showHudTip:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [UIViewController jaf_showHudTip:error.localizedDescription];
    }];
}

/// 修改昵称
+ (void)mine_userNickNameWithParams:(NSDictionary *)params success:(void(^)(id responseObject))success {
    [MBProgressHUD showActivityMessageInWindow:@""];
    [PPNetworkHelper POST:NSStringFormat(@"%@%@",URL_main,URL_user_nickName) parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        if ([[responseObject[@"code"] stringValue] isEqualToString:@"200"]) {
            [MBProgressHUD hideHUD];
            if (success)success(responseObject);
        } else {
            [UIViewController jaf_showHudTip:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [UIViewController jaf_showHudTip:error.localizedDescription];
    }];
}


//上传图片至服务器后台
+ (void)mine_transportImgToServerWithImg:(UIImage *)img success:(void(^)(id responseObject))success {
    UIImage *image = [UIImage imageWithImageSimple:img scaledToSize:CGSizeMake(200, 200)];
    NSData *imageData;
    NSString *mimetype;
    //判断下图片是什么格式
    if (UIImagePNGRepresentation(image) != nil) {
        mimetype = @"image/png";
        imageData = UIImagePNGRepresentation(image);
    }else{
        mimetype = @"image/jpeg";
        imageData = UIImageJPEGRepresentation(image, 1.0);
    }
    NSString *urlString = [NSString stringWithFormat:@"%@%@",URL_main,URL_ftp_file];
    NSDictionary *params = @{@"file":imageData};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [MBProgressHUD showActivityMessageInWindow:@""];
    [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *str = @"file";
        NSString *fileName = [[NSString alloc] init];
        if (UIImagePNGRepresentation(img) != nil) {
            fileName = [NSString stringWithFormat:@"%@.png", str];
        }else{
            fileName = [NSString stringWithFormat:@"%@.jpg", str];
        }
        // 上传图片，以文件流的格式
        /**
         *filedata : 图片的data
         *name     : 后台的提供的字段
         *mimeType : 类型
         */
        [formData appendPartWithFileData:imageData name:str fileName:fileName mimeType:mimetype];
    } progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        //打印看下返回的是什么东西
        if ([[responseObject[@"code"] stringValue] isEqualToString:@"200"]) {
            [MBProgressHUD hideHUD];
            if (success)success(responseObject);
        } else {
            [UIViewController jaf_showHudTip:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"上传图片失败，失败原因是:%@", error);
        [MBProgressHUD hideHUD];
        [UIViewController jaf_showHudTip:error.description];
    }];
}

/// 消息中心
+ (void)mine_MessageCenterWithParams:(NSDictionary *)params success:(void(^)(id responseObject))success {
//    [MBProgressHUD showActivityMessageInWindow:@""];
//    [PPNetworkHelper POST:NSStringFormat(@"%@%@",URL_main,URL_user_nickName) parameters:params success:^(id responseObject) {
//        [MBProgressHUD hideHUD];
//        if ([[responseObject[@"code"] stringValue] isEqualToString:@"200"]) {
//            [MBProgressHUD hideHUD];
//            if (success)success(responseObject);
//        } else {
//            [UIViewController jaf_showHudTip:responseObject[@"msg"]];
//        }
//    } failure:^(NSError *error) {
//        [MBProgressHUD hideHUD];
//        [UIViewController jaf_showHudTip:error.localizedDescription];
//    }];
}
@end
