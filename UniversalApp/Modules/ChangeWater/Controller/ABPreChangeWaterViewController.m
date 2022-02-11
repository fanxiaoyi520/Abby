//
//  ABPreChangeWaterViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/24.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABPreChangeWaterViewController.h"
#import "ABChangeWaterViewController.h"
@interface ABPreChangeWaterViewController ()
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
    self.bg_Height = 484;
    self.btn_bg_Color = @"0x006241";
    self.content_Str = @"Find a bucket that can hold 1 1/2 gallons of water and place the tube into the bucket.";
    self.btn_Title = @"Tube placed in bucket";
    self.isLeft = NO;
}

- (void)setupUI {
    self.lottieLogo.frame = CGRectMake(26, self.contentLab.bottom+48, kScreenWidth-26*2, 200);
}

// MARK: actions
- (void)sureBtnFuncAction:(UIButton *)sender {
    ABChangeWaterViewController *vc = [ABChangeWaterViewController new];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
//        vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

// MARK: Lazy loding
- (LOTAnimationView *)lottieLogo {
    if (!_lottieLogo) {
        _lottieLogo = [LOTAnimationView animationNamed:@"85819-kadokado-heart"];
        _lottieLogo.contentMode = UIViewContentModeScaleAspectFill;
        _lottieLogo.loopAnimation = YES;
        [self.bgView addSubview:self.lottieLogo];
    }
    return _lottieLogo;
}
@end
