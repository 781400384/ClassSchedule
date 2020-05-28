//
//  CityModel.m
//  地址
//
//  Created by qinglinyou on 2018/1/29.
//  Copyright © 2018年 qinglinyou. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

- (instancetype)initWithDictionary:(NSDictionary *)dic province:(NSString *)pro{
    self = [super init];
    if (self) {
        _areaListArray = [NSMutableArray array];
        if (pro.length > 0) {
            _city = pro;
        }else{
            _city = [dic objectForKey:@"n"];
            NSArray *array = [dic objectForKey:@"a"];
            for (NSDictionary *dict in array) {
                [_areaListArray addObject:[dict objectForKey:@"s"]];
            }
        }
    }
    return self;
}

- (void)setCityArray:(NSArray *)cityArray{
    for (NSDictionary *dict in cityArray) {
        [_areaListArray addObject:[dict objectForKey:@"n"]];
    }
}

@end

@implementation CityArrayModel


- (instancetype)initWithCity:(NSArray *)cityArray province:(NSString *)pro{
    self = [super init];
    if (self) {
        _citiesArray = [NSMutableArray array];
       CityModel *cityModel;
        for (NSDictionary *cityDic in cityArray) {
            if (![cityDic objectForKey:@"a"]) {
                cityModel = [[CityModel alloc]initWithDictionary:cityDic province:pro];
                cityModel.cityArray = cityArray;
                [_citiesArray addObject:cityModel];
                break;
            }else{
                cityModel = [[CityModel alloc]initWithDictionary:cityDic province:@""];
                [_citiesArray addObject:cityModel];
            }
            
        }
    }
    return self;
}

@end
