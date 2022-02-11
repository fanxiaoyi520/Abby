//
//  NSObject+JAFMultiProxyAddition.h
//  JAFMultiDelegate
//
//  Created by 张俊彬 on 2019/8/8.
//  Copyright © 2019 Jamfer.iOSCoder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JAFMultiProxy.h"

#define JAFProxy(Protocol) ((id<Protocol>)self.jaf_multiProxy)

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (JAFMultiProxyAddition)
/**
 Multicast-delegate proxy
 */
@property (nonatomic, readonly) JAFMultiProxy *jaf_multiProxy;

/**
 Add a delegate to the proxy
 
 @param delegate : custom delegate
 */
- (void)jaf_addDelegate:(id /* id<Protocol> */ )delegate;

/**
 Remove a delegate from the proxy
 
 @param delegate : custom delegate
 */
- (void)jaf_removeDelegate:(id /* id<Protocol> */ )delegate;

/**
 Remove all delegates from the proxy
 */
- (void)jaf_removeAllDelegates;
@end

NS_ASSUME_NONNULL_END
