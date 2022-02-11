//
//  ABMessageCenterLogic.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/9.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABMessageCenterLogic.h"
#import "ABMessageCenterAPI.h"
#import "ABMessageCenterModel.h"

@implementation ABMessageCenterLogic
-(instancetype)init{
    self = [super init];
    if (self) {
        _dataArray = @[].mutableCopy;
    }
    return self;
}

#pragma mark ————— 拉取数据 —————
-(void)loadData{
    NSArray *jsonData = [ABUtils getJsonDataJsonname:@"ABMessageCenter"];
    [jsonData enumerateObjectsUsingBlock:^(id  _Nonnull obj1, NSUInteger i, BOOL * _Nonnull stop) {
        ABMessageCenterModel *model = [ABMessageCenterModel yy_modelWithJSON:obj1];
        [_dataArray addObject:model];
    }];
    if (self.delegagte && [self.delegagte respondsToSelector:@selector(requestDataCompleted)]) {
        [self.delegagte requestDataCompleted];
    }
}
@end
