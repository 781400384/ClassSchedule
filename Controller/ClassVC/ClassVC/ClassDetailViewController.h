//
//  ClassDetailViewController.h
//  ClassSchedule
//
//  Created by Superme on 2019/10/30.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "CSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassDetailViewController : CSBaseViewController
@property (nonatomic, copy) NSString   *   id;
@property (nonatomic, copy) NSString   *   className;;
@property (nonatomic, copy) NSString   *   room;
@property (nonatomic, copy) NSString    *  week;
@property (nonatomic, copy) NSString   *   weeknum;
@property (nonatomic, copy) NSString   *   teacher;
@property (nonatomic, copy) NSString   *   weekSatrt;
@end

NS_ASSUME_NONNULL_END
