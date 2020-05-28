//
//  ClassVCTableViewCell.h
//  ClassSchedule
//
//  Created by Superme on 2019/10/29.
//  Copyright © 2019 Superme. All rights reserved.
//

#import <UIKit/UIKit.h>




NS_ASSUME_NONNULL_BEGIN

@interface ClassVCTableViewCell : UITableViewCell

//@property (nonatomic, strong) ClassView       *    bgView;
//@property (nonatomic, strong) AddClassVieiw   *    classView;
@property (nonatomic, strong) UIView          *    timeBgView;
@property (nonatomic, strong) UILabel         *    num;
@property (nonatomic, strong) UILabel         *    startTime;
@property (nonatomic, strong) UILabel         *    endTime;
@property (nonatomic, strong) UIView          *    lineView;
@property (nonatomic, strong) UIView          *    shortLine;
@property (nonatomic, strong) UIImageView     *    addImage;
@property (nonatomic, strong) UIView          *    classBgView;
@property (nonatomic, strong) UILabel         *    className;
@property (nonatomic, strong) UILabel         *    grade;
@property (nonatomic, strong) UILabel         *    teacherName;
@property (nonatomic, assign) int                  i;
@property (nonatomic, copy) NSString           *   titleName1;
@property (nonatomic, copy) NSString           *   classtitle1;
@property (nonatomic, copy) NSString           *   teacher1;

@property (nonatomic, copy) NSString           *   titleName2;
@property (nonatomic, copy) NSString           *   classtitle2;
@property (nonatomic, copy) NSString           *   teacher2;

@property (nonatomic, copy) NSString           *   titleName3;
@property (nonatomic, copy) NSString           *   classtitle3;
@property (nonatomic, copy) NSString           *   teacher3;

@property (nonatomic, copy) NSString           *   titleName4;
@property (nonatomic, copy) NSString           *   classtitle4;
@property (nonatomic, copy) NSString           *   teacher4;

@property (nonatomic, copy) NSString           *   titleName5;
@property (nonatomic, copy) NSString           *   classtitle5;
@property (nonatomic, copy) NSString           *   teacher5;
@end

NS_ASSUME_NONNULL_END
