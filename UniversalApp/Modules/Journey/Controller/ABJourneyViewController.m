//
//  ABJourneyViewController.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/7.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABJourneyViewController.h"
#import "ABUnlockLoopViewController.h"
#import "ABRewardTipsViewController.h"
#import "ABTaskViewController.h"

#import "ABJourneyView.h"

@interface ABJourneyViewController ()<ABJourneyViewDelegate,ABUnlockLoopViewVCDelegate,ABTaskViewDelegate>
@property (nonatomic ,strong)ABJourneyView *journeyView;
@end

@implementation ABJourneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isHidenNaviBar = YES;
    self.isShowLiftBack = NO;//每个根视图需要设置该属性为NO，否则会出现导航栏异常
    
    [self setupUI];
}

- (void)setupUI {
    self.view = self.journeyView;
}

// MARK: ABJourneyViewDelegate
- (void)journey_unlockFuncAction:(UIButton *)sender {
    ABUnlockLoopViewController *vc = ABUnlockLoopViewController.new;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)journey_taskFuncAction:(UIButton *)sender {
    ABTaskViewController *vc = [ABTaskViewController new];
    vc.delegate = self;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

// MARK: ABUnlockLoopViewVCDelegate
- (void)rewardTips {
    [self.journeyView.lockBtn setImage:ImageName(@"icon_50_bloom_u") forState:UIControlStateNormal];
    ABRewardTipsViewController *vc = [ABRewardTipsViewController new];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

// MARK: ABTaskViewDelegate
- (void)task_startFuncAction:(UIButton *)sender {
    self.tabBarController.selectedIndex = 0;
}

// MARK: Lazy loading
- (ABJourneyView *)journeyView {
    if (!_journeyView) {
        _journeyView = [[ABJourneyView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _journeyView.delegate = self;
    }
    return _journeyView;
}

@end
