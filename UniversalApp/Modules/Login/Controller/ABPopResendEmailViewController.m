//
//  ABPopResendEmailViewController.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/4.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABPopResendEmailViewController.h"

@interface ABPopResendEmailViewController ()

@end

@implementation ABPopResendEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI {
    
    kWeakSelf(self);
    NSArray *array = @[@"Resend email",@"Cancel"];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = UIButton.new;
        [self.view addSubview:btn];
        btn.frame = CGRectMake(24, kScreenHeight-60*2-24*2-CONTACTS_SAFE_BOTTOM+idx*(60+24), kScreenWidth-24*2, 60);
        btn.backgroundColor = KWhiteColor;
        [btn addRoundedCorners:UIRectCornerAllCorners withRadii:CGSizeMake(10, 10)];
        [btn setTitle:array[idx] forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_MEDIUM(18);
        UIColor *color = nil;
        color = idx == 0 ? [UIColor colorWithHexString:@"0x006241"] : [UIColor colorWithHexString:@"0x000000"];
        [btn setTitleColor:color forState:UIControlStateNormal];
        btn.tag = 100 + idx;
        [btn addTapBlock:^(UIButton *btn) {
            if (btn.tag == 100) {
                if ([self.delegate respondsToSelector:@selector(resendEmail)]) {
                    [weakself dismissViewControllerAnimated:YES completion:^{
                        [self.delegate resendEmail];
                    }];
                }
            } else {
                [weakself dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    }];
}

@end
