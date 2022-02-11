//
//  ABAddDeviceViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/11/24.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABAddDeviceViewController.h"
#import "ABBluetoothSearchViewController.h"

@interface ABAddDeviceViewController ()

@end

@implementation ABAddDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"0xFBFFFD"];
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
    [self.view addGestureRecognizer:pan];
    
    self.isHidenNaviBar = NO;
    self.isShowLiftBack = NO;
    [self addNavigationItemWithTitles
     :@[@"Log out"] isLeft:YES target:self action:@selector(naviBtnClick:) tags:@[@1000]];
    self.navTitle = @"Add device";
    
    [self setupUI];
}

- (void)setupUI {
    
    UIImageView *deviceImg = [UIImageView new];
    [self.view addSubview:deviceImg];
    deviceImg.image = ImageName(@"pic_111");
    deviceImg.frame = CGRectMake((KScreenWidth-ratioW(200))/2, (KScreenHeight-ratioH(450))/2-CONTACTS_HEIGHT_NAV, ratioW(200), ratioH(450));
    
    YYLabel *addDeviceBtn = [[YYLabel alloc] initWithFrame:CGRectMake(26, kScreenHeight-CONTACTS_HEIGHT_NAV-144-CONTACTS_SAFE_BOTTOM, KScreenWidth-26*2, 60)];
    addDeviceBtn.text = @"Add Device";
    addDeviceBtn.font = FONT(@"Gilroy", 18);
    addDeviceBtn.textColor = KWhiteColor;
    addDeviceBtn.backgroundColor = [UIColor colorWithHexString:@"0x006241"];
    addDeviceBtn.textAlignment = NSTextAlignmentCenter;
    addDeviceBtn.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    addDeviceBtn.centerX = KScreenWidth/2;
    addDeviceBtn.layer.cornerRadius = 30;
    addDeviceBtn.layer.masksToBounds = YES;
    
    kWeakSelf(self);
    addDeviceBtn.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        ABBluetoothSearchViewController *vc = [ABBluetoothSearchViewController new];
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    
    [self.view addSubview:addDeviceBtn];
}

// MARK: actions
- (void)naviBtnClick:(UIButton *)btn {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"Are you sure to log out" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UserManager sharedUserManager] logout:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:otherAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
