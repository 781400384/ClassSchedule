//
//  TermsListModel.h
//  ClassSchedule
//
//  Created by Superme on 2019/11/6.
//  Copyright © 2019 Superme. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TermsListModel : NSObject
@property (nonatomic, copy) NSString      *      id;
@property (nonatomic, copy) NSString      *      start_year;
@property (nonatomic, copy) NSString      *      end_year;
@property (nonatomic, copy) NSString      *      num;
@property (nonatomic, copy) NSString      *      week;
@property (nonatomic, copy) NSString      *      max_section;
@property (nonatomic, copy) NSString      *      week_start_day;
@property (nonatomic, copy) NSString      *      uid;
@property (nonatomic, copy) NSString      *      day;
@end

NS_ASSUME_NONNULL_END
