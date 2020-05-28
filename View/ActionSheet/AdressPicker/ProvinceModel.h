//
//  ProvinceModel.h
//  地址
//
//  Created by qinglinyou on 2018/1/29.
//  Copyright © 2018年 qinglinyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityModel.h"

@interface ProvinceModel : NSObject
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) CityArrayModel *citiesListModel;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
