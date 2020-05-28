//
//  UniverdsityListViewController.h
//  ClassSchedule
//
//  Created by Superme on 2019/11/4.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "CSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UniverdsityListViewController : CSBaseViewController
@property (nonatomic, copy) void (^SchoolBlock)(NSString *  school_id,NSString * school_name,NSString * major_id,NSString * major_name);
@property (nonatomic, copy) NSString   *   type;
@end

NS_ASSUME_NONNULL_END
