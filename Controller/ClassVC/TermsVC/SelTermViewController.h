//
//  SelTermViewController.h
//  ClassSchedule
//
//  Created by Superme on 2019/11/7.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "CSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelTermViewController : CSBaseViewController
@property (nonatomic, copy) void (^SelTermBlock)();
@end

NS_ASSUME_NONNULL_END
