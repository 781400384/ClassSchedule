//
//  ClassListModel.h
//  ClassSchedule
//
//  Created by Superme on 2019/11/12.
//  Copyright © 2019 Superme. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClassListModel : NSObject
@property (nonatomic, copy) NSString    *    id;
@property (nonatomic, copy) NSString    *    title;
@property (nonatomic, copy) NSString    *    room;
@property (nonatomic, copy) NSString    *    week_start;
@property (nonatomic, copy) NSString    *    section_week;
@property (nonatomic, copy) NSString    *    section_from;
@property (nonatomic, copy) NSString    *    teacher;
@property (nonatomic, copy) NSString    *    uid;
@property (nonatomic, copy) NSString    *    term_id;
@end

NS_ASSUME_NONNULL_END
