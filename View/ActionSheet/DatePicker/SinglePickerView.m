//
//  SinglePickerView.m
//  ClassSchedule
//
//  Created by Superme on 2019/10/31.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "SinglePickerView.h"
#import "ViewController.h"
#define BG_COLOR_RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define SCREEN_WIGHT  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface SinglePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
// pickerview  创建
@property (nonatomic ,strong)UIView *toolsView;
@property (nonatomic ,strong)UIPickerView *picerView;

@property (nonatomic ,strong)NSArray *componentArray;

@end
@implementation SinglePickerView


/*!
 *  初始化选择器
 *
 *
 *  @param ComponentDataArray 第一区 显示的数据
 *
 *
 *  @return 返回自己
 */
- (instancetype)initWithComponentDataArray:(NSArray *)ComponentDataArray  title:(NSString *)title
{
    self = [super init];
    if (self)
    {
        self.componentArray = ComponentDataArray;
       
        self.frame = CGRectMake(0, 0, SCREEN_WIGHT, SCREEN_HEIGHT);
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        }];
        
        _toolsView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 244, SCREEN_WIGHT, 44)];
        _toolsView.backgroundColor = BG_COLOR_RGB(248, 248, 248);
        [self addSubview:_toolsView];
        
        // 右边确定按钮
        UIButton *rightSureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        rightSureBtn.frame = CGRectMake(SCREEN_WIGHT - 54, 0, 44, 44);
        [rightSureBtn setTitle:@"确定" forState:UIControlStateNormal];
        rightSureBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15*KScaleW];
               [rightSureBtn setTitleColor:[UIColor colorWithHexString:@"#29675f "] forState:UIControlStateNormal];
        [rightSureBtn addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_toolsView addSubview:rightSureBtn];
        
        // 中间显示  label
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(54, 0, SCREEN_WIGHT - 108, 44)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = title;
        titleLabel.font = [UIFont systemFontOfSize:13];
        [_toolsView addSubview:titleLabel];
        
        
        // 左边取消按钮
        UIButton *leftCancleButton = [UIButton buttonWithType:UIButtonTypeSystem];
        leftCancleButton.frame = CGRectMake(10, 0, 44, 44);
        [leftCancleButton setTitle:@"取消" forState:UIControlStateNormal];
        leftCancleButton.titleLabel.font = [UIFont boldSystemFontOfSize:15*KScaleW];
        [leftCancleButton setTitleColor:[UIColor colorWithHexString:@"#f1c0c0 "] forState:UIControlStateNormal];
        [leftCancleButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_toolsView addSubview:leftCancleButton];
        
        
        
        _picerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 200, SCREEN_WIGHT, 200)];
        _picerView.dataSource = self;
        _picerView.delegate = self;
        [_picerView selectRow:0 inComponent:0 animated:YES];
        _picerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_picerView];
    }
    return self;
}


#pragma mark -
#pragma mark -  左边按钮 方法  取消
- (void)leftButtonClick:(UIButton *)button
{
    [self thisWayIsDissmisssSelf];
}


#pragma mark -
#pragma mark -  右边按钮  方法
- (void)rightButtonClick:(UIButton *)button
{
    
    [self setDataValue];
    
    if (self.getPickerValue)
    {
        self.getPickerValue(self.componentString);
    }
    
    [self thisWayIsDissmisssSelf];
}
#pragma mark -
#pragma mark - 赋值
- (void)setDataValue
{
    if ([self.componentString isEqualToString:@""] || self.componentString == NULL)
    {
        self.componentString = self.componentArray[0];
    }
   
}

#pragma mark -
#pragma mark -  数据源方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
   
        return self.componentArray.count;
  
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

     
        return self.componentArray[row];
    
    
}




#pragma mark -
#pragma mark -  代理方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        self.componentString = self.componentArray[row];
        self.valueString = self.componentArray[row];
    }
  
    
}
#pragma mark -
#pragma mark - 屏幕点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self thisWayIsDissmisssSelf];
}


#pragma mark -
#pragma mark - 消失的方法
- (void)thisWayIsDissmisssSelf
{
    __weak typeof (self)weakSelf = self;
    __weak typeof(UIView *)blockView = _toolsView;
    __weak typeof(UIPickerView *)blockPickerViwe = _picerView;
    [UIView animateWithDuration:0.3 animations:^{
        blockView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIGHT, 44);
        blockPickerViwe.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIGHT, 200);
    }completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}


@end
