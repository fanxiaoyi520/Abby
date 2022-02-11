//
//  WebResetDeviceViewController.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/19.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "WebResetDeviceViewController.h"

@interface WebResetDeviceViewController ()

@end

@implementation WebResetDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - WKScriptMessageHandler JS 调用 Native  代理
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    //    if ([message.name isEqualToString:@"backPage"]) {
    //        //返回
    //        if (self.webVC.presentingViewController) {
    //            [self.webVC dismissViewControllerAnimated:YES completion:nil];
    //        }else{
    //            [self.webVC.navigationController popViewControllerAnimated:YES];
    //        }
    //    } else if ([message.name isEqualToString:@"tryAgain"]) {
    //        DLog(@"tryAgain");
    //    }
}
@end
