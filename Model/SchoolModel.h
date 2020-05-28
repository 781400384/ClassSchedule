//
//  SchoolModel.h
//  ClassSchedule
//
//  Created by Superme on 2019/11/5.
//  Copyright © 2019 Superme. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class SchoolName;
@interface SchoolModel : NSObject
@property (nonatomic, copy) NSArray    *    school;
@property (nonatomic, copy) NSString    *    id;
@property (nonatomic, copy) NSString    *    name;
@end
@interface SchoolName :NSObject
@property (nonatomic, copy) NSString    *   id;
@property (nonatomic, copy) NSString    *   name;
@end



NS_ASSUME_NONNULL_END
