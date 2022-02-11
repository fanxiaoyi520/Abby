//
//  JAFMultiProxy.h
//  JAFMultiDelegate
//
//  Created by 张俊彬 on 2019/8/8.
//  Copyright © 2019 Jamfer.iOSCoder. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JAFMultiProxy : NSProxy
/**
 By default (YES), the proxy will invoke methods in main thread
 */
@property (nonatomic, assign) BOOL runInMainThread;

/**
 Create a JAFMultiProxy instance when you add the multicast delegate funciton to your class
 
 @return new instance
 */
+ (JAFMultiProxy *)proxy;

/**
 Add a delegate to the list
 */
- (void)addDelegate:(id)delegate;

/**
 Remove a delegate from the list
 */
- (void)removeDelete:(id)delegate;


/**
 Remove all delegates from the list
 */
- (void)removeAllDelegates;
@end
