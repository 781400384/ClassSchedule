//
//  CityModel.h
//  地址
//
//  Created by qinglinyou on 2018/1/29.
//  Copyright © 2018年 qinglinyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSArray *cityArray;
@property (nonatomic, strong) NSMutableArray *areaListArray;
- (instancetype)initWithDictionary:(NSDictionary *)dic province:(NSString *)province;
@end

@interface CityArrayModel : NSObject
@property (nonatomic, strong) NSMutableArray<CityModel *> *citiesArray;

- (instancetype)initWithCity:(NSArray *)cityArray province:(NSString *)pro;

@end
