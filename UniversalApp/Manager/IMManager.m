//
//  IMManager.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/6/5.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#define IM_ServiceNumber @"kefuchannelimid_623644"//客服｜默认
#define IM_ServiceNumber_Export @"kefuchannelimid_623644"//专家
#define IM_Appkey @"2100220117031055#kefuchannelapp1000069"
#define IM_TenantId @"1000069"
#define IM_ApnsCertName @"Abby"

#import "IMManager.h"
#import "ABChatViewController.h"

//@interface IMManager()<NIMLoginManagerDelegate,NIMChatManagerDelegate>
@interface IMManager()<HDClientDelegate,HDChatManagerDelegate>

@end

@implementation IMManager

SINGLETON_FOR_CLASS(IMManager);

#pragma mark ————— 初始化IM —————
-(void)initIM{

    HDOptions *option = [[HDOptions alloc] init];
    option.appkey = IM_Appkey; // 必填项，appkey获取地址：kefu.easemob.com，“管理员模式 > 渠道管理 > 手机APP”页面的关联的“AppKey”
    option.tenantId = IM_TenantId;// 必填项，tenantId获取地址：kefu.easemob.com，“管理员模式 > 账户 > 账户信息 > 租户ID一栏的数据”
    //推送证书名字
    option.apnsCertName = IM_ApnsCertName;//(集成离线推送必填)
    //Kefu SDK 初始化,初始化失败后将不能使用Kefu SDK
    HDError *initError = [[HDClient sharedClient] initializeSDKWithOptions:option];
    if (initError) { // 初始化错误
    }
}

#pragma mark ————— IM登录 —————
-(void)IMLogin:(NSString *)IMID IMPwd:(NSString *)IMPwd completion:(loginBlock)completion{
    [self IMLogout];
    HDClient *client = [HDClient sharedClient];
    if (client.isLoggedInBefore != YES) {
        HDError *error = [client loginWithUsername:IMID password:IMPwd];
        if (!error) { //登录成功
            if (completion) {
                //添加网络监控，一般在app初始化的时候添加监控，第二个参数是执行代理方法的队列，默认是主队列
                [[HDClient sharedClient] addDelegate:self delegateQueue:nil];
                //添加消息监控，第二个参数是执行代理方法的队列，默认是主队列
                [[HDClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
                
                completion(YES,nil);
            }
        } else { //登录失败
            if (completion) {
                completion(NO,error.description);
            }
        }
    }
}

#pragma mark ————— IM退出 —————
-(void)IMLogout{
    //移除网络监控
    [[HDClient sharedClient] removeDelegate:self];
    //移除消息监控
    [[HDClient sharedClient].chatManager removeDelegate:self];
    
    //参数为是否解绑推送的devicetoken
    HDError *error = [[HDClient sharedClient] logout:YES];
    if (error) { //登出出错
        DLog("IM 退出失败 %@",error.description);
    } else {//登出成功
        DLog("IM 退出成功");
    }
}

#pragma mark ————— IM进入聊天页 —————
- (void)IMGoChatVC:(RootViewController *)vc withServiceNumberType:(ServiceNumberType)type {
    NSString *serviceNumberStr = nil;
    switch (type) {
        case ServiceNumber_Default:
            serviceNumberStr = IM_ServiceNumber;
            break;
        case ServiceNumber_CustomerService:
            serviceNumberStr = IM_ServiceNumber;
            break;
        case ServiceNumber_Expert:
            serviceNumberStr = IM_ServiceNumber_Export;
            break;
    }
    
    HDClient *client = [HDClient sharedClient];
    if (client.isLoggedInBefore != YES) {
        HDError *error = [client loginWithUsername:@"fanxiaoyi520" password:@"123456"];
        if (!error) { //登录成功
            ABChatViewController *chatVC = [[ABChatViewController alloc] initWithConversationChatter:serviceNumberStr];
            [vc.navigationController pushViewController:chatVC animated:YES];
        } else { //登录失败
            [UIViewController jaf_showHudTip:error.description];
        }
    } else {
        
        HDConversation *conversation = [[HDClient sharedClient].chatManager getConversation:serviceNumberStr];
        ABChatViewController *chatVC = [[ABChatViewController alloc] initWithConversationChatter:conversation.conversationId];
        [vc.navigationController pushViewController:chatVC animated:YES];
    }
}

#pragma mark ————— 添加网络监听—————
- (void)connectionStateDidChange:(HConnectionState)aConnectionState {
    switch (aConnectionState) {
        case HConnectionConnected: {//已连接
            break;
        }
        case HConnectionDisconnected: {//未连接
            break;
        }
        default:
            break;
    }
}

- (void)userAccountDidRemoveFromServer {
    DLog(@"当前登录账号已经被从服务器端删除时会收到该回调");
    KPostNotification(KNotificationOnKick, nil);
}

- (void)userAccountDidLoginFromOtherDevice {
    DLog(@"当前登录账号在其它设备登录时会接收到此回调");
    KPostNotification(KNotificationOnKick, nil);
}

//-(void)onKick:(NIMKickReason)code clientType:(NIMLoginClientType)clientType
//{
//    NSString *reason = @"你被踢下线";
//    switch (code) {
//            case NIMKickReasonByClient:
//            case NIMKickReasonByClientManually:{
//                reason = @"你的帐号被踢出下线，请注意帐号信息安全";
//                break;
//            }
//            case NIMKickReasonByServer:
//            reason = @"你被服务器踢下线";
//            break;
//        default:
//            break;
//    }
//    KPostNotification(KNotificationOnKick, nil);
//}
//
#pragma mark ————— 代理 收到新消息 —————
- (void)messagesDidReceive:(NSArray *)aMessages{
     //收到普通消息,格式:<HDMessage *>
}

- (void)cmdMessagesDidReceive:(NSArray *)aCmdMessages{
     //收到命令消息,格式:<HDMessage *>，命令消息不存数据库，一般用来作为系统通知，例如留言评论更新，
     //会话被客服接入，被转接，被关闭提醒
}

- (void)messageStatusDidChange:(HDMessage *)aMessage error:(HDError *)aError{
     //消息的状态修改，一般可以用来刷新列表，显示最新的状态
}

- (void)messageAttachmentStatusDidChange:(HDMessage *)aMessage error:(HDError *)aError{
    //发送消息后，会调用，可以在此刷新列表，显示最新的消息
}


@end
