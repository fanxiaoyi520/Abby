//
//  ABTrentModel.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/1.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABTrentModel.h"

@implementation ABTrentModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"images" : [ABTrentImageModel class]};
}
@end

@implementation ABTrentImageModel

@end
