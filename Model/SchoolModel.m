//
//  SchoolModel.m
//  ClassSchedule
//
//  Created by Superme on 2019/11/5.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "SchoolModel.h"

@implementation SchoolModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
        @"school" :[SchoolName class]
             };
}

@end
@implementation SchoolName

@end
