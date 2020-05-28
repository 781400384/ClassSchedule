//
//  ClassVCViewController.h
//  ClassSchedule
//
//  Created by Superme on 2019/10/26.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "CSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassVCViewController : CSBaseViewController
@property (nonatomic, copy) NSString    *  type;
@property (nonatomic, strong) UIButton          *    classBgView;
@property (nonatomic, strong) UILabel         *    className;
@property (nonatomic, strong) UILabel         *    grade;
@property (nonatomic, strong) UILabel         *    teacherName;
@property (nonatomic, strong) UIImageView     *    addImage;
@end

NS_ASSUME_NONNULL_END
