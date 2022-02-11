//
//  XLJSHandler.m
//  MiAiApp
//
//  Created by 谭启龙 on 2017/9/14.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "XLJSHandler.h"


@interface XLJSHandler ()


@end

@implementation XLJSHandler

-(instancetype)initWithViewController:(UIViewController *)webVC configuration:(WKWebViewConfiguration *)configuration withDelegate:(id<WKScriptMessageHandler>)scriptDelegate{
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
        _webVC = webVC;
        _configuration = configuration;
        //注册JS 事件
        [configuration.userContentController addScriptMessageHandler:self name:@"tryAgain"];
        [configuration.userContentController addScriptMessageHandler:self name:@"backPage"];
    }
    return self;
}

#pragma mark -  JS 调用 Native  代理
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([self.scriptDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}

#pragma mark -  记得要移除
-(void)cancelHandler {
    [_configuration.userContentController removeScriptMessageHandlerForName:@"tryAgain"];
    [_configuration.userContentController removeScriptMessageHandlerForName:@"backPage"];
}

-(void)dealloc {
    
}

@end
