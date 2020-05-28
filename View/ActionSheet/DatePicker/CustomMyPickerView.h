//
//  CustomMyPickerView.h
//  pickerText
//
//  Created by ios3 on 16/7/8.
//  Copyright © 2016年 ios3. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^customBlock)(NSString *compoentString,NSString *titileString);

@interface CustomMyPickerView : UIView
@property (nonatomic ,copy)NSString *componentString;
@property (nonatomic ,copy)NSString *titleString;
@property (nonatomic ,copy)customBlock getPickerValue;

@property (nonatomic ,copy)NSString *valueString;

- (instancetype)initWithComponentDataArray:(NSArray *)ComponentDataArray titleDataArray:(NSArray *)titleDataArray  title:(NSString *)title;;

@end
