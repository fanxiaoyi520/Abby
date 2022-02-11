//
//  ABDeviceDpsModel.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/23.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABDeviceDpsModel.h"

@implementation ABDeviceDpsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"d_switch" : @"1",
             @"bright_value" : @"5",
             @"temp_current" : @"6",
             @"humidity_current" : @"7",
             @"Flowering_time" : @"102",
             @"Ventilation" : @"103",
             @"water_temperature" : @"104",
             @"water_level" : @"105",
             @"door" : @"106",
             @"height" : @"107",
             @"Add_fertilizer" : @"108",
             @"human_detection" : @"109",
             @"flush" : @"110",
             @"dry" : @"111",
             @"weekcycle" : @"112",
             @"pump_water" : @"113",
             @"input_air_flow" : @"115",
             @"turn_on_the_light" : @"116",
             @"turn_off_light" : @"117",
             @"air_pump" : @"118"};
}

- (void)updateModelWithDic:(NSDictionary *)dic {
    NSArray *keys = [dic allKeys];
    [keys enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:@"1"]) self.d_switch =dic[obj];
        if ([obj isEqualToString:@"5"]) self.bright_value =dic[obj];
        if ([obj isEqualToString:@"6"]) self.temp_current =dic[obj];
        if ([obj isEqualToString:@"7"]) self.humidity_current =dic[obj];
        if ([obj isEqualToString:@"102"]) self.Flowering_time =dic[obj];
        if ([obj isEqualToString:@"103"]) self.Ventilation =dic[obj];
        if ([obj isEqualToString:@"104"]) self.water_temperature =dic[obj];
        if ([obj isEqualToString:@"105"]) self.water_level =dic[obj];
        if ([obj isEqualToString:@"106"]) self.door =dic[obj];
        if ([obj isEqualToString:@"107"]) self.height =dic[obj];
        if ([obj isEqualToString:@"108"]) self.Add_fertilizer =dic[obj];
        if ([obj isEqualToString:@"109"]) self.human_detection =dic[obj];
        if ([obj isEqualToString:@"110"]) self.flush =dic[obj];
        if ([obj isEqualToString:@"111"]) self.dry =dic[obj];
        if ([obj isEqualToString:@"112"]) self.weekcycle =dic[obj];
        if ([obj isEqualToString:@"113"]) self.pump_water =dic[obj];
        if ([obj isEqualToString:@"115"]) self.input_air_flow =dic[obj];
        if ([obj isEqualToString:@"116"]) self.turn_on_the_light =dic[obj];
        if ([obj isEqualToString:@"117"]) self.turn_off_light =dic[obj];
        if ([obj isEqualToString:@"118"]) self.air_pump =dic[obj];
    }];
}
@end

