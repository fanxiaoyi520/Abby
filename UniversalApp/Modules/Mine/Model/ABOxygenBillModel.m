//
//  ABOxygenBillModel.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/8.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABOxygenBillModel.h"

@implementation ABOxygenBillModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [ABOxygenBillListModel class]};
}
@end

@implementation ABOxygenBillListModel

@end
