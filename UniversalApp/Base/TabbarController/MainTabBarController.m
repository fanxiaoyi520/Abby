//
//  MainTabBarController.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/18.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "MainTabBarController.h"

#import "RootNavigationController.h"
#import "ABHomeViewController.h"
#import "ABTrendViewController.h"
#import "ABMineViewController.h"
#import "ABJourneyViewController.h"

#import "UITabBar+CustomBadge.h"
#import "XYTabBar.h"

@interface MainTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic,strong) NSMutableArray * VCS;//tabbar root VC

@end

@implementation MainTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tabbarStateChange:)
                                                 name:KNotificationTabbarStateChange
                                               object:nil];
    
    //初始化tabbar
    [self setUpTabBar];
    //添加子控制器
    [self setUpAllChildViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark ————— KNotificationTabbarStateChange —————
- (void)tabbarStateChange:(NSNotification *)noti {
    int tabbarChange = [noti.object intValue];
    
    if (tabbarChange == 0) {
        _VCS = @[].mutableCopy;
        
        ABHomeViewController *homeVC = [ABHomeViewController new];
        [self setupChildViewController:homeVC title:nil imageName:@"bars_icon_home_u" seleceImageName:@"bars_icon_home_o"];
        ABJourneyViewController *journeyVC = [[ABJourneyViewController alloc]init];
        [self setupChildViewController:journeyVC title:nil imageName:@"bars_icon_jun_u" seleceImageName:@"bars_icon_jun_o"];
        ABTrendViewController *trendVC = [ABTrendViewController new];
        [self setupChildViewController:trendVC title:nil imageName:@"bars_icon_trend_u" seleceImageName:@"bars_icon_trend_o"];
        ABMineViewController *mineVC = [[ABMineViewController alloc] init];
        [self setupChildViewController:mineVC title:nil imageName:@"bars_icon_me_u" seleceImageName:@"bars_icon_me_o"];
        self.viewControllers = _VCS;
    } else if (tabbarChange == 1){
        _VCS = @[].mutableCopy;
        
        ABHomeViewController *homeVC = [ABHomeViewController new];
        [self setupChildViewController:homeVC title:nil imageName:@"bars_icon_home_u" seleceImageName:@"bars_icon_home_o"];
        ABTrendViewController *trendVC = [ABTrendViewController new];
        [self setupChildViewController:trendVC title:nil imageName:@"bars_icon_trend_u" seleceImageName:@"bars_icon_trend_o"];
        ABMineViewController *mineVC = [[ABMineViewController alloc] init];
        [self setupChildViewController:mineVC title:nil imageName:@"bars_icon_me_u" seleceImageName:@"bars_icon_me_o"];
        self.viewControllers = _VCS;
    }
}

#pragma mark ————— 初始化TabBar —————
-(void)setUpTabBar{
    //设置背景色 去掉分割线
    [self setValue:[XYTabBar new] forKey:@"tabBar"];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setBackgroundImage:[UIImage new]];
    //通过这两个参数来调整badge位置
    //    [self.tabBar setTabIconWidth:29];
    //    [self.tabBar setBadgeTop:9];
}

#pragma mark - ——————— 初始化VC ————————
-(void)setUpAllChildViewController{
    KPostNotification(KNotificationTabbarStateChange, @(kTabbarStatusDefault));
//    if (([[DeviceManager sharedDeviceManager].deviceModel.dps objectForKey:@"105"] != 0 &&
//        [[DeviceManager sharedDeviceManager].deviceModel.dps objectForKey:@"107"] != 0)) {
//        //水位 水箱无水    //植物高度 植物箱体检测不到的Clone的存在
//        KPostNotification(KNotificationTabbarStateChange, @(kTabbarStatusNoWaterNoPlant));
//    } else {
//        KPostNotification(KNotificationTabbarStateChange, @(kTabbarStatusDefault));
//    }
}

-(void)setupChildViewController:(UIViewController*)controller title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName{
    //controller.title = title;
    //controller.tabBarItem.title = title;//跟上面一样效果
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //未选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:KBlackColor,NSFontAttributeName:SYSTEMFONT(10.0f)} forState:UIControlStateNormal];
    
    //选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:CNavBgColor,NSFontAttributeName:SYSTEMFONT(10.0f)} forState:UIControlStateSelected];
    //包装导航控制器
    RootNavigationController *nav = [[RootNavigationController alloc]initWithRootViewController:controller];
    [_VCS addObject:nav];
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{}

-(void)setRedDotWithIndex:(NSInteger)index isShow:(BOOL)isShow{
    if (isShow) {
        [self.tabBar setBadgeStyle:kCustomBadgeStyleRedDot value:0 atIndex:index];
    }else{
        [self.tabBar setBadgeStyle:kCustomBadgeStyleNone value:0 atIndex:index];
    }
}

- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
