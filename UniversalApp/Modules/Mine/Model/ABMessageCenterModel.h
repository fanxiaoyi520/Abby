//
//  ABMessageCenterModel.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/9.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABMessageCenterModel : NSObject

@property (nonatomic , copy) NSString *headImage;
@property (nonatomic , copy) NSString *title;
@property (nonatomic , copy) NSString *content;
@property (nonatomic , copy) NSString *time;
@end

NS_ASSUME_NONNULL_END
