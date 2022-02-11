//
//  ABGlobalDelegate.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/8.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ABGlobalDelegate <NSObject>
@optional
/**
 数据加载完成
 */
-(void)requestDataCompleted;

@end

