//
//  ABNationModel.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/5.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABNationModel.h"

@implementation ABNationModel
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self != nil) {
        self.param = [aDecoder decodeObjectForKey:@"param"];
        self.value = [aDecoder decodeObjectForKey:@"value"];
    }
    return self;
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:self.param forKey:@"param"];
    [aCoder encodeObject:self.value forKey:@"value"];
}
@end


