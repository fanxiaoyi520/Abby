//
//  ABMessageCenterViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/8.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABMessageCenterViewController.h"
#import "ABMessgeConViewController.h"

#import "ABMessageCenterCell.h"
#import "ABMessageCenterLogic.h"
#import "ABMessageCenterModel.h"

//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;
@interface ABMessageCenterViewController ()<UITableViewDelegate,UITableViewDataSource,ABGlobalDelegate,HDChatManagerDelegate>
@property (nonatomic,strong) ABMessageCenterLogic * logic;
@property (strong, nonatomic) NSDate *lastPlaySoundDate;
@end

@implementation ABMessageCenterViewController
- (void)dealloc
{
    [self unregisterNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isHidenNaviBar = NO;
    self.isShowLiftBack = YES;
    self.navTitle = @"Message center";
    _logic = [ABMessageCenterLogic new];
    _logic.delegagte = self;
    
#warning 把self注册为SDK的delegate
    [self registerNotifications];
    
    [self setupUI];
    [_logic loadData];
}

- (void)setupUI {
    self.tableView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - kTopHeight);
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[ABMessageCenterCell class] forCellReuseIdentifier:NSStringFromClass([ABMessageCenterCell class])];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
}

// MARK: - private
-(void)registerNotifications
{
    [self unregisterNotifications];
    [[HDClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications
{
    [[HDClient sharedClient].chatManager removeDelegate:self];
}

// MARK: ————— 数据拉取完成 渲染页面 —————
-(void)requestDataCompleted{
    [UIView performWithoutAnimation:^{
        [self.tableView reloadData];
    }];
}

// MARK: tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _logic.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 94.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ABMessageCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ABMessageCenterCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellModel = _logic.dataArray[indexPath.row];
    if (indexPath.row == _logic.dataArray.count-1) {
        cell.lineView.hidden = YES;
    } else {
        cell.lineView.hidden = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ABMessageCenterModel *model = _logic.dataArray[indexPath.row];

    if ([model.title isEqualToString:@"Instrutors"]) {
        
        [[IMManager sharedIMManager] IMGoChatVC:self withServiceNumberType:ServiceNumber_Expert];
    } else if ([model.title isEqualToString:@"Feedback"]) {
        [[IMManager sharedIMManager] IMGoChatVC:self withServiceNumberType:ServiceNumber_CustomerService];
    } else {
        ABMessgeConViewController *vc = ABMessgeConViewController.new;
        vc.n_title = model.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

// 收到消息回调
- (void)messagesDidReceive:(NSArray *)aMessages {
    if ([self isNotificationMessage:aMessages.firstObject]) {
        return;
    }
#if !TARGET_IPHONE_SIMULATOR
    BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
    if (!isAppActivity) {
        [self _showNotificationWithMessage:aMessages];
    }else {
        [self _playSoundAndVibration];
    }
#endif

}


// MARK: - private chat
- (void)_playSoundAndVibration
{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息时，播放音频
    [[HDCDDeviceManager sharedInstance] playNewMessageSound];
    // 收到消息时，震动
    [[HDCDDeviceManager sharedInstance] playVibration];
}

- (BOOL)isNotificationMessage:(HDMessage *)message {
    if (message.ext == nil) { //没有扩展
        return NO;
    }
    NSDictionary *weichat = [message.ext objectForKey:kMessageExtWeChat];
    if (weichat == nil || weichat.count == 0 ) {
        return NO;
    }
    if ([weichat objectForKey:@"notification"] != nil && ![[weichat objectForKey:@"notification"] isKindOfClass:[NSNull class]]) {
        BOOL isNotification = [[weichat objectForKey:@"notification"] boolValue];
        if (isNotification) {
            return YES;
        }
    }
    return NO;
}

- (void)_showNotificationWithMessage:(NSArray *)messages
{
    HDPushOptions *options = [[HDClient sharedClient] hdPushOptions];
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    
    if (options.displayStyle == HDPushDisplayStyleMessageSummary) {
        id<HDIMessageModel> messageModel  = messages.firstObject;
        NSString *messageStr = nil;
        switch (messageModel.body.type) {
            case EMMessageBodyTypeText:
            {
                messageStr = ((EMTextMessageBody *)messageModel.body).text;
             }
                break;
            case EMMessageBodyTypeImage:
            {
                messageStr = NSLocalizedString(@"message.image", @"Image");
            }
                break;
            case EMMessageBodyTypeLocation:
            {
                messageStr = NSLocalizedString(@"message.location", @"Location");
            }
                break;
            case EMMessageBodyTypeVoice:
            {
                messageStr = NSLocalizedString(@"message.voice", @"Voice");
            }
                break;
            case EMMessageBodyTypeVideo:{
                messageStr = NSLocalizedString(@"message.vidio", @"Vidio");
            }
                break;
            default:
                break;
        }
        
        NSString *title = messageModel.from;
        notification.alertBody = [NSString stringWithFormat:@"%@:%@", title, messageStr];
    }
    else{
        notification.alertBody = NSLocalizedString(@"receiveMessage", @"you have a new message");
    }
    
    //notification.alertBody = [[NSString alloc] initWithFormat:@"[本地]%@", notification.alertBody];
    
    notification.alertAction = NSLocalizedString(@"open", @"Open");
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.soundName = UILocalNotificationDefaultSoundName;
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = ++badge;
}
@end
