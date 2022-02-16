//
//  ABPreChangeWaterViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/24.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABPreChangeWaterViewController.h"
#import "ABChangeWaterViewController.h"
@interface ABPreChangeWaterViewController ()<ABChangeWaterDelegate>
@property (nonatomic ,strong) LOTAnimationView *lottieLogo;
@end

@implementation ABPreChangeWaterViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.lottieLogo play];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.lottieLogo pause];

}

- (void)viewDidLoad {
    [self superConfigure];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)superConfigure {
    self.bg_Height = 486;
    self.btn_bg_Color = @"0x006241";
    self.content_Str = @"Please prepare a bucket with a volume of 1 liter or more.";
    self.btn_Title = @"Confirm";
    self.isLeft = NO;
}

- (void)setupUI {
    self.lottieLogo.frame = CGRectMake(26, 0, kScreenWidth-26*2, 200);
    self.lottieLogo.bottom = self.sureBtn.top - 40;
}

// MARK: actions
- (void)sureBtnFuncAction:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"Confirm"]) {
        self.contentLab.text = @"Click the button below to drain";
        [sender setTitle:@"Start" forState:UIControlStateNormal];
        return;
    }
    
    [[deviceManager getDevice] publishDps:@{@"113": @(YES)} mode:TYDevicePublishModeLocal success:^{
        ABChangeWaterViewController *vc = [ABChangeWaterViewController new];
        vc.modalPresentationStyle = UIModalPresentationCustom;
        vc.transitioningDelegate = self;
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:nil];
    } failure:^(NSError *error) {
        NSLog(@"publishDps failure: %@", error);
    }];

}

// MARK: ABChangeWaterDelegate
- (void)changeWater_sureBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

// MARK: Lazy loding
- (LOTAnimationView *)lottieLogo {
    if (!_lottieLogo) {
        _lottieLogo = [LOTAnimationView animationNamed:@"drainage"];
        _lottieLogo.contentMode = UIViewContentModeScaleAspectFill;
        _lottieLogo.loopAnimation = YES;
        [self.bgView addSubview:self.lottieLogo];
    }
    return _lottieLogo;
}
@end
