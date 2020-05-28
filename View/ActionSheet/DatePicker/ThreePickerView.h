//
//  ThreePickerView.h
//  ClassSchedule
//
//  Created by Superme on 2019/10/31.
//  Copyright © 2019 Superme. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^threeBlock) (NSString  *   compoentString,NSString   *  titileString,NSString    *   endString);
@interface ThreePickerView : UIView
@property (nonatomic ,copy)NSString *componentString;
@property (nonatomic ,copy)NSString *titleString;
@property (nonatomic ,copy)threeBlock getPickerValue;
@property (nonatomic, copy) NSString  *   endString;
@property (nonatomic ,copy)NSString *valueString;

- (instancetype)initWithComponentDataArray:(NSArray *)ComponentDataArray titleDataArray:(NSArray *)titleDataArray   endDataArray:(NSArray *)endDataArray title:(NSString *)title;;
@end

NS_ASSUME_NONNULL_END
