//
//  SelClassViewController.h
//  ClassSchedule
//
//  Created by Superme on 2019/10/29.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "CSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelClassViewController : CSBaseViewController
@property (nonatomic, copy) NSString    *   classType;
@property (nonatomic, copy) NSString    *   term_id;
@property (nonatomic, copy) NSString    *   class_id;

@property (nonatomic, copy) NSString    *    className;
@property (nonatomic, copy) NSString    *    roomName;
@property (nonatomic, copy) NSString    *    weekNum;
@property (nonatomic, copy) NSString    *    sectionRoom;
@property (nonatomic, copy) NSString    *    teachername;
@property (nonatomic, copy) NSString    *    weekStart;


@end

NS_ASSUME_NONNULL_END
