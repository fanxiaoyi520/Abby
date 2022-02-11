//
//  ABHelpAndFBLogic.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/13.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABHelpAndFBLogic.h"
#import "ABMineHelpAndFBAPI.h"
#import "ABHelpAndFBModel.h"

@implementation ABHelpAndFBLogic
-(instancetype)init{
    self = [super init];
    if (self) {
        _dataArray = @[].mutableCopy;
    }
    return self;
}

#pragma mark ————— 拉取数据 —————
-(void)loadData{
    NSArray *jsonData = [ABUtils getJsonDataJsonname:@"ABMineHelpAndFB"];
    [jsonData enumerateObjectsUsingBlock:^(id  _Nonnull obj1, NSUInteger i, BOOL * _Nonnull stop) {
        ABHelpAndFBModel *model = [ABHelpAndFBModel yy_modelWithJSON:obj1];
        [_dataArray addObject:model];
    }];
    if (self.delegagte && [self.delegagte respondsToSelector:@selector(requestDataCompleted)]) {
        [self.delegagte requestDataCompleted];
    }
}
@end
