//
//  ProvinceModel.m
//  地址
//
//  Created by qinglinyou on 2018/1/29.
//  Copyright © 2018年 qinglinyou. All rights reserved.
//

#import "ProvinceModel.h"

@implementation ProvinceModel
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _province = [dic objectForKey:@"p"];
        _citiesListModel = [[CityArrayModel alloc]initWithCity:[dic objectForKey:@"c"] province:_province];
    }
    return self;
}
@end
