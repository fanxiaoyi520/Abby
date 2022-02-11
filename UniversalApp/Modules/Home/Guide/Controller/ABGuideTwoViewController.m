//
//  ABGuideTwoViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/16.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABGuideTwoViewController.h"
#import "ABSecConfirmViewController.h"
@interface ABGuideTwoViewController ()<UIPopoverPresentationControllerDelegate,GWGlobalNotifyServerDelegate>

@property (nonatomic ,strong) LOTAnimationView *lottieLogo;
@property (nonatomic ,strong) UIImageView *lottieImgView;
@property (nonatomic ,assign)ABTipsStep tipsStep;
@end

@implementation ABGuideTwoViewController

- (instancetype)initWithTipStep:(ABTipsStep)tipsStep {
    self = [super init];
    if (self) {
        self.tipsStep = tipsStep;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.tipsStep == Second || self.tipsStep == Four) [self.lottieLogo play];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.tipsStep == Second || self.tipsStep == Four) [self.lottieLogo pause];
}

- (void)viewDidLoad {
    [self superConfigure];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.tipsStep == Four) [[ABGlobalNotifyServer sharedServer] jaf_addDelegate:self];
    [self setupUI];
}

- (void)superConfigure {
    switch (self.tipsStep) {
        case First:
            self.bg_Height = 486;
            self.content_Str = @"​Congratulations! you have completed the pumping task, please add 3 gallons of water.";
            self.btn_Title = @"Next";
            self.btn_bg_Color = @"0x006241";
            break;
        case Second:
            self.bg_Height = 472;
            self.content_Str = @"​Injecting water";
            self.btn_Title = @"Water added";
            self.btn_bg_Color = @"0x006241";
            break;
        case Third:
            self.bg_Height = 513;
            self.content_Str = @"​Congratulations! You have completed the water injection task, please place the nutrient ball at the designated position.";
            self.btn_Title = @"I have the tube into a bucket";
            self.btn_bg_Color = @"0x006241";
            break;
        case Four:
            self.bg_Height = 472;
            self.content_Str = @"​Please put Clone on the basket";
            self.btn_Title = @"I've completed";
            self.btn_bg_Color = @"0xC9C9C9";
            break;
    }
    self.isLeft = YES;
}

- (void)setupUI {
    switch (self.tipsStep) {
        case First:
            self.lottieImgView.image = ImageName(@"pic_od_1");
            self.lottieImgView.frame = CGRectMake(26, 0, kScreenWidth-26*2, 200);
            self.lottieImgView.bottom = self.sureBtn.top-40;
            break;
        case Second:
            self.lottieLogo.frame = CGRectMake(26, 0, kScreenWidth-26*2, 200);
            self.lottieLogo.bottom = self.sureBtn.top-40;
            break;
        case Third:
            self.lottieImgView.image = ImageName(@"pic_AB_1");
            self.lottieImgView.frame = CGRectMake(26, 0, kScreenWidth-26*2, 200);
            self.lottieImgView.bottom = self.sureBtn.top-40;
            break;
        case Four:
            self.lottieLogo.frame = CGRectMake(26, 0, kScreenWidth-26*2, 200);
            self.lottieLogo.bottom = self.sureBtn.top-40;
            //self.sureBtn.enabled = NO;
            break;
    }
}

// MARK: actions
- (void)sureBtnFuncAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(guide_addingWaterAction:)]) {
            [self.delegate guide_addingWaterAction:sender];
        }
    }];
}

// MARK: GWGlobalNotifyServerDelegate
- (void)resetDeviceDps:(NSDictionary *)dpsModel {
    if ([[dpsModel objectForKey:@"107"] floatValue] > 0) {
        self.sureBtn.backgroundColor = [UIColor colorWithHexString:@"0x006241"];
        self.sureBtn.enabled = YES;
    }
}

// MARK: Lazy loding
- (LOTAnimationView *)lottieLogo {
    if (!_lottieLogo) {
        NSString *jsonStr;
        if (self.tipsStep == Second) {
            jsonStr = @"ABAddWaterData";
        } else if (self.tipsStep == Four){
            jsonStr = @"zhongzhiData";
        }
        _lottieLogo = [LOTAnimationView new];
        [_lottieLogo setAnimation:jsonStr];
        _lottieLogo.contentMode = UIViewContentModeScaleAspectFill;
        _lottieLogo.loopAnimation = YES;
        [self.bgView addSubview:self.lottieLogo];
    }
    return _lottieLogo;
}

- (UIImageView *)lottieImgView {
    if (!_lottieImgView) {
        _lottieImgView = [UIImageView new];
        [self.bgView addSubview:_lottieImgView];
    }
    return _lottieImgView;
}
@end
