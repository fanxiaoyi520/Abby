//
//  TYBLEAdvModel+Common.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/21.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "TYBLEAdvModel+Common.h"

@implementation TYBLEAdvModel (Common)
- (BOOL)isEqualToTYBLEAdvModel:(TYBLEAdvModel *)model {

    if (!model) {
        return NO;
    }
    BOOL bIsEqualUuid = (!self.uuid && !model.uuid) || [self.uuid isEqualToString:model.uuid];
    BOOL bIsEqualProductId = (!self.productId && !model.productId) || [self.productId isEqualToString:model.productId];
    return bIsEqualUuid && bIsEqualProductId;
}

#pragma mark - 重载isEqual方法
- (BOOL)isEqual:(id)object {

    if (self == object) {
        return YES;
    }

    if (![object isKindOfClass:[TYBLEAdvModel class]]) {
        return NO;
    }
    return [self isEqualToTYBLEAdvModel:(TYBLEAdvModel *)object];
}

@end
