//
//  NSObject+JAFMultiProxyAddition.m
//  JAFMultiDelegate
//
//  Created by 张俊彬 on 2019/8/8.
//  Copyright © 2019 Jamfer.iOSCoder. All rights reserved.
//

#import "NSObject+JAFMultiProxyAddition.h"
#import <objc/runtime.h>

@implementation NSObject (JAFMultiProxyAddition)

#pragma mark - Public Methods

- (void)jaf_addDelegate:(id)delegate {
    [self.jaf_multiProxy addDelegate:delegate];
}

- (void)jaf_removeDelegate:(id)delegate {
    [self.jaf_multiProxy removeDelete:delegate];
}

- (void)jaf_removeAllDelegates {
    [self.jaf_multiProxy removeAllDelegates];
}

#pragma mark - Getters and Setters

- (JAFMultiProxy *)jaf_multiProxy {
    @synchronized (self) {
        JAFMultiProxy *proxy = objc_getAssociatedObject(self, @selector(jaf_multiProxy));
        if (!proxy) {
            proxy = JAFMultiProxy.proxy;
            objc_setAssociatedObject(self, @selector(jaf_multiProxy), proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        return proxy;
    }
}

@end
