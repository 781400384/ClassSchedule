//
//  ClassSettingViewController.h
//  ClassSchedule
//
//  Created by Superme on 2019/10/31.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "CSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassSettingViewController : CSBaseViewController
@property (nonatomic, copy) void (^ClassSettingBlock)(NSString *  maxSection,NSMutableArray * TimeList);
@property (nonatomic, strong) NSMutableArray     *    dataList;
@property (nonatomic, strong) NSMutableArray     *    timeList;
@property (nonatomic, copy)   NSString           *    maxSecton;
@property (nonatomic, copy)   NSString           *    type;
@end

NS_ASSUME_NONNULL_END
