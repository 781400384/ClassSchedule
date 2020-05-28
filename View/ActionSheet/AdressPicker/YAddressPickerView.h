//
//  YAddressPickerView.h
//  地址
//
//  Created by qinglinyou on 2018/1/29.
//  Copyright © 2018年 qinglinyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddressViewDelegate <NSObject>

- (void)cancelOnclick;//取消选择

- (void)viewDisappearance;//视图隐藏（包括点击取消按钮和点击空白处收起PickerView）

- (void)completingTheSelection:(NSString *)province city:(NSString *)city ;//完成选择

@end

@interface YAddressPickerView : UIView
@property (nonatomic ,strong) id<AddressViewDelegate>delegate;

@property (nonatomic ,assign) BOOL isComplete;//是否完成选择
//viewControler2  演示此信息 （viewController选择完地址  然后跳到VC2，点击选择地址）
@property (nonatomic ,assign) BOOL isCurrentLocation;//AddressPickView是否显示输入框内地址
@property (nonatomic ,strong) NSString *currentProvince;//当前输入框内“省”
@property (nonatomic ,strong) NSString *currentCity;//当前输入框内“市”
@property (nonatomic ,strong) NSString *currentArea;//当前输入框内“区”

@property (nonatomic ,strong) UIColor *backGroundViewColor;//背景灰色阴影的色值（默认黑色）
@property (nonatomic ,assign) CGFloat backGroundViewAplha;//背景灰色阴影透明度（默认透明度0.3）

@property (nonatomic ,strong) UIColor *cancelBtnColor;//取消按钮色值 (默认#444444)
@property (nonatomic ,strong) UIColor *completeBtnColor;//完成按钮色值 (默认#444444)

@property (nonatomic ,strong) UIColor *pickerViewBackGroundColor;//弹出的addressPickerView的PickerView背景色 （默认）


- (void)show;//默认有动画
- (void)show:(BOOL)animation;

- (void)hide;//默认有动画
- (void)hide:(BOOL)animation;


@end
