//
//  ABHomeViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/11/24.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABHomeViewController.h"
#import "ABGuideFirstViewController.h"
#import "ABGuideTwoViewController.h"
#import "ABSecConfirmViewController.h"
#import "ABWeekViewController.h"
#import "ABOxygenViewController.h"
#import "ABOxygenAccountViewController.h"
#import "ABPreChangeWaterViewController.h"
#import "ABSkinViewController.h"

#import "ABGuideView.h"
#import "ABGuideAbbyView.h"
#import "ABMainHomeView.h"

@interface ABHomeViewController ()<ABGuideViewDelegate,ABMainHomeDelegate,ABMainHomeDelegate,TuyaSmartDeviceDelegate,GWGlobalNotifyServerDelegate>

@property (nonatomic ,strong) ABGuideView *guideView;
@property (nonatomic ,strong) ABGuideAbbyView *guideAbbyView;
@property (nonatomic ,strong) UIView *bgView;
@property (nonatomic ,strong) ABMainHomeView *mainHomeView;
@end

@implementation ABHomeViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isHidenNaviBar = YES;
    self.isShowLiftBack = NO;//每个根视图需要设置该属性为NO，否则会出现导航栏异常
    
    [[ABGlobalNotifyServer sharedServer] jaf_addDelegate:self];
    NSString *waterLevelStr = [NSString stringWithFormat:@"%@",[[DeviceManager sharedDeviceManager].deviceModel.dps objectForKey:@"105"]];
    NSInteger waterLevelInt = ([waterLevelStr containsString:@"L"]) ? [[waterLevelStr stringByReplacingOccurrencesOfString:@"L" withString:@""] integerValue] : [waterLevelStr integerValue];
    if (waterLevelInt != 0 &&
        [[DeviceManager sharedDeviceManager].deviceModel.dps objectForKey:@"107"] != 0) {
        //水位 水箱无水    //植物高度 植物箱体检测不到的Clone的存在
        self.view = self.guideView;
    } else {
//        self.view = self.mainHomeView;
        self.view = self.guideView;
    }
}

// MARK: ABGuideViewDelegate
- (void)guide_startFuncAction:(UIButton *)sender {
    ABGuideFirstViewController *vc = [ABGuideFirstViewController new];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)guide_setpOneNextAction:(id)sender {
    self.view = self.guideAbbyView;
}

- (void)guide_addingWaterStartAction:(UIButton *)sender {
    ABGuideTwoViewController *vc = [ABGuideTwoViewController new];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:^{

    }];
}

- (void)guide_addingWaterAction:(UIButton *)sender {

    if ([sender.titleLabel.text isEqualToString:@"Start"]) {
        if (sender.tag != 101) {
            ABGuideTwoViewController *vc = [[ABGuideTwoViewController alloc] initWithTipStep:First];
            vc.modalPresentationStyle = UIModalPresentationCustom;
            vc.transitioningDelegate = self;
            vc.delegate = self;
            [self presentViewController:vc animated:YES completion:nil];
        } else {
            ABGuideTwoViewController *vc = [[ABGuideTwoViewController alloc] initWithTipStep:Four];
            vc.modalPresentationStyle = UIModalPresentationCustom;
            vc.transitioningDelegate = self;
            vc.delegate = self;
            [self presentViewController:vc animated:YES completion:nil];
        }
    } else if ([sender.titleLabel.text isEqualToString:@"Next"]) {
        ABGuideTwoViewController *vc = [[ABGuideTwoViewController alloc] initWithTipStep:Second];
        vc.modalPresentationStyle = UIModalPresentationCustom;
        vc.transitioningDelegate = self;
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:nil];
    } else if ([sender.titleLabel.text isEqualToString:@"Water added"]) {
        ABGuideTwoViewController *vc = [[ABGuideTwoViewController alloc] initWithTipStep:Third];
        vc.modalPresentationStyle = UIModalPresentationCustom;
        vc.transitioningDelegate = self;
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:nil];
    } else if ([sender.titleLabel.text isEqualToString:@"I have the tube into a bucket"]) {
        [self.guideAbbyView updatePopView];
//        [[deviceManager getDevice] publishDps:@{@"108": @(YES)} mode:TYDevicePublishModeLocal success:^{
//            [self.guideAbbyView updatePopView];
//        } failure:^(NSError *error) {
//            DLog(@"publishDps failure: %@", error);
//        }];
    }  else if ([sender.titleLabel.text isEqualToString:@"I've completed"])  {
        ABSecConfirmViewController *vc = [ABSecConfirmViewController new];
        vc.modalPresentationStyle = UIModalPresentationCustom;
        vc.transitioningDelegate = self;
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (void)guide_guideSecondAction:(UIButton *)sender {
    self.view = self.mainHomeView;
}

// MARK: ABMainHomeDelegate
- (void)mainHome_weekAction:(UIButton *)sender {
    if (sender.tag == 100) {
        ABWeekViewController *vc = [ABWeekViewController new];
        vc.modalPresentationStyle = UIModalPresentationCustom;
        vc.transitioningDelegate = self;
        vc.delegate = self;
        vc.kDelegate = self;
        [self presentViewController:vc animated:YES completion:nil];
    } else if (sender.tag == 101) {
        ABOxygenAccountViewController *vc = [ABOxygenAccountViewController new];
        vc.modalPresentationStyle = UIModalPresentationCustom;
        vc.transitioningDelegate = self;
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:nil];
    } else {
        ABOxygenViewController *vc = [ABOxygenViewController new];
        vc.modalPresentationStyle = UIModalPresentationCustom;
        vc.transitioningDelegate = self;
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:nil];
    }
//    [[deviceManager getDevice] publishDps:@{@"108": @(YES)} mode:TYDevicePublishModeLocal success:^{
//        NSLog(@"publishDps success");
//    } failure:^(NSError *error) {
//        NSLog(@"publishDps failure: %@", error);
//    }];
}

- (void)mainHome_StartFuncAction:(UIButton *)sender {
    sender.superview.hidden = YES;
//    ABPreChangeWaterViewController *vc = [ABPreChangeWaterViewController new];
//    vc.modalPresentationStyle = UIModalPresentationCustom;
//    vc.transitioningDelegate = self;
//    vc.delegate = self;
//    [self presentViewController:vc animated:YES completion:nil];
}

- (void)mainHone_customerServiceAction:(UIButton *)sender {
    [[IMManager sharedIMManager] IMGoChatVC:self withServiceNumberType:ServiceNumber_Default];
}

- (void)mainHone_skinAction:(UIButton *)sender {
    ABSkinViewController *vc = ABSkinViewController.new;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)mainHone_OxygenCollectionAction:(UITapGestureRecognizer *)sender {
    [self.mainHomeView.funcView oxygenCollection:sender];
}

- (void)mainHone_learnMore:(UIButton *)sender {
    self.tabBarController.selectedIndex = 1;
}

// MARK: GWGlobalNotifyServerDelegate
- (void)resetDeviceDps:(ABDeviceDpsModel *)dpsModel {
    DLog(@"%@",dpsModel.height);
}

// MARK: Lazy loading
- (ABGuideView *)guideView {
    if (!_guideView) {
        _guideView = [[ABGuideView alloc] initWithFrame:self.view.frame];
        _guideView.delegate = self;
    }
    return _guideView;
}

- (ABGuideAbbyView *)guideAbbyView {
    if (!_guideAbbyView) {
        _guideAbbyView = [[ABGuideAbbyView alloc] initWithFrame:self.view.frame];
        _guideAbbyView.delegate = self;
    }
    return _guideAbbyView;
}

- (ABMainHomeView *)mainHomeView {
    if (!_mainHomeView) {
        _mainHomeView = [[ABMainHomeView alloc] initWithFrame:self.view.frame];
        _mainHomeView.delegate = self;
    }
    return _mainHomeView;
}
@end
