//
//  SinglePickerView.h
//  ClassSchedule
//
//  Created by Superme on 2019/10/31.
//  Copyright © 2019 Superme. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^singleBlock)(NSString * _Nullable  compoentString);
NS_ASSUME_NONNULL_BEGIN

@interface SinglePickerView : UIView
@property (nonatomic ,copy)NSString *componentString;
@property (nonatomic ,copy)NSString *titleString;
@property (nonatomic ,copy)singleBlock getPickerValue;

@property (nonatomic ,copy)NSString *valueString;
@property (nonatomic, assign) NSIndexPath  *  row;
- (instancetype)initWithComponentDataArray:(NSArray *)ComponentDataArray   title:(NSString *)title;;
@end

NS_ASSUME_NONNULL_END
