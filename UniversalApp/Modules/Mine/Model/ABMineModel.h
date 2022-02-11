//
//  ABMineModel.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/7.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABMineModel : NSObject

@property (nonatomic , copy) NSString *name;
@property (nonatomic , copy) NSString *imageName;
@property (nonatomic , copy) NSString *arrow_icon;

@end

@interface ABMineServerModel : NSObject

@property (nonatomic , copy) NSString *abbyId;
@property (nonatomic , copy) NSString *avatarPicture;
@property (nonatomic , copy) NSString *email;
@property (nonatomic , copy) NSString *nickName;
@property (nonatomic , copy) NSString *userName;

@end

NS_ASSUME_NONNULL_END
