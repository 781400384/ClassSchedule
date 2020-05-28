//
//  ClassTimeModel.h
//  ClassSchedule
//
//  Created by Superme on 2019/11/12.
//  Copyright © 2019 Superme. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClassTimeModel : NSObject
@property (nonatomic, copy) NSString     *   id;
@property (nonatomic, copy) NSString     *   end_time;
@property (nonatomic, copy) NSString     *   num;
@property (nonatomic, copy) NSString     *   start_time;
@property (nonatomic, copy) NSString     *   term_id;
@property (nonatomic, copy) NSString     *   uid;
@end

NS_ASSUME_NONNULL_END
