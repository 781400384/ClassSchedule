//
//  SelClassViewController.m
//  ClassSchedule
//
//  Created by Superme on 2019/10/29.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "SelClassViewController.h"
#import "SinglePickerView.h"
#import "ThreePickerView.h"
#import "CustomMyPickerView.h"
@interface SelClassViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField    *   classNameTF;
@property (nonatomic, strong) UITextField    *   classTF;
@property (nonatomic, strong) UITextField    *   weekTF;
@property (nonatomic, strong) UITextField    *   numberTF;
@property (nonatomic, strong) UITextField    *   teacherTF;
@property (nonatomic, strong) NSArray        *   numArray;
@property (nonatomic, strong) NSMutableDictionary    *   dic;
@property (nonatomic, strong) NSMutableArray *   dataList;
@property (nonatomic, strong) NSMutableArray *   weekList;
@property (nonatomic, strong) NSMutableArray *   sectionList;
@end

@implementation SelClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.rightTitleLabel.text=@"保存";
    self.naviView.image.image=[UIImage imageNamed:@"class_aaa_bg"]; ;
    self.naviView.rightTitleLabel.textColor=[UIColor colorWithHexString:@"f4e0e7"];
   
    self.view.backgroundColor=RGB(247, 244, 249);
    
      [self configUI];
  
    [self initData];
}
-(void)initData{
    NSUserDefaults  *  defaults=[NSUserDefaults standardUserDefaults];
    NSDictionary * dic=[defaults valueForKey:@"termsDic"];
      self.weekList=[[NSMutableArray alloc] init];
    for (int i=0; i<[dic[@"week"] intValue]; i++) {
        [self.weekList addObject:[NSString stringWithFormat:@"%d",i+1]];
    }
       self.sectionList=[[NSMutableArray alloc] init];
    for ( int i=0; i<[dic[@"max_section"] intValue]; i++) {
        [self.sectionList addObject:[NSString stringWithFormat:@"%d",i+1]];
      
    }
}
#pragma mark - 右侧按钮点击事件
-(void)rightTitleLabelTap{
  
    if (![self checkText]) {
        return;
    }
    NSUserDefaults  *  defaults=[NSUserDefaults standardUserDefaults];
    NSDictionary * dic=[defaults valueForKey:@"termsDic"];
    
     NSLog(@"%@",dic);
    if ([self.classType isEqualToString:@"0"]) {
        
        NSDictionary * dictionary=@{
               @"token":[UserInfoDefaults userInfo].token,
               @"term_id":dic[@"id"],
               @"title":self.classNameTF.text,
               @"room":self.classTF.text,
               @"week_start":self.dataList[0],
               @"section_week":self.dataList[1],
               @"section_from":self.dataList[2],
               @"teacher":self.teacherTF.text,
               @"day":dic[@"day"]
           };
        NSLog(@"dic===%@",dictionary);
        [HttpTools post:API_ADD_CLASS params:dictionary loading:NO success:^(id  _Nonnull json) {
            NSLog(@"%@ %@",dictionary,json);
            NSDictionary  *  obj=(NSDictionary *)json;
            if ([obj[@"code"] intValue]==1) {
                [self.view toast:@"添加成功"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                 [self.view toast:obj[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            
        }];
        
    }
    if ([self.classType isEqualToString:@"1"]) {
        
    
        NSDictionary * dictionary=@{
                     @"id":self.class_id,
                     @"token":[UserInfoDefaults userInfo].token,
                     @"term_id":dic[@"id"],
                     @"title":self.classNameTF.text,
                     @"room":self.classTF.text,
                     @"week_start":self.dataList[0]==nil?self.weekNum:self.dataList[0],
                     @"section_week":self.dataList[1]==nil?self.weekStart:self.dataList[1],
                     @"section_from":self.dataList[2]==nil?self.sectionRoom:self.dataList[2],
                     @"teacher":self.teacherTF.text,
                     @"day":dic[@"day"]
                     
                 };
              [HttpTools post:API_UPDATE_CLASS params:dictionary loading:NO success:^(id  _Nonnull json) {
                  NSLog(@"%@ %@",dictionary,json);
                  NSDictionary  *  object=(NSDictionary *)json;
                  if ([object[@"code"]intValue ]==1) {
                       [self.view toast:@"添加成功"];
                  }else{
                      [self.view toast:object[@"msg"]];
                      
                  }
                  [self.navigationController popToRootViewControllerAnimated:YES];
              } failure:^(NSError * _Nonnull error) {
                  
              }];
    }
}
#pragma mark - 配置UI
-(void)configUI{
    UIView   *  view=[[UIView alloc]initWithFrame:CGRectMake(30*KScaleW, self.naviView.bottom+7.33*KScaleH, SCREEN_WIDTH-60*KScaleW, 75*KScaleH)];
    view.backgroundColor=[UIColor whiteColor];
    [view setRadius:37.5*KScaleH];
    view.userInteractionEnabled=YES;
    view.clipsToBounds=YES;
    [self.view addSubview:view];
    UITextField   *  tf=[[UITextField alloc]initWithFrame:CGRectMake(30*KScaleW, 0, SCREEN_WIDTH-90*KScaleW, 75*KScaleH)];
    tf.backgroundColor=[UIColor whiteColor];
    [tf setRadius:37.5*KScaleH];
    tf.placeholder=@"未填写";
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.delegate=self;
    if ([self.classType isEqualToString:@"1"]) {
        tf.text=self.className;
    }
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(-10, 0, 74*KScaleW, 75*KScaleH)];
    label.textAlignment=NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:15*KScaleW];
    label.text=@"课名";
    tf.leftView=label;
    self.classNameTF=tf;
    [view addSubview:tf];
    
    
    
    
    
    UIView   *  bgView=[[UIView alloc]initWithFrame:CGRectMake(30*KScaleW, view.bottom+5*KScaleH, SCREEN_WIDTH-60*KScaleW, 302*KScaleH)];
    bgView.backgroundColor=[UIColor whiteColor];
    [bgView setRadius:37.5*KScaleH];
    bgView.userInteractionEnabled=YES;
    bgView.clipsToBounds=YES;
    [self.view addSubview:bgView];
    for (int i=0; i<4; i++) {
       
        UITextField   *  tf1=[[UITextField alloc]initWithFrame:CGRectMake(30*KScaleW,75.5*i*KScaleH, SCREEN_WIDTH-90*KScaleW, 75*KScaleH)];
           tf1.backgroundColor=[UIColor whiteColor];
           [tf1 setRadius:37.5*KScaleW];
           tf1.placeholder=@"未填写";
           tf1.clearButtonMode = UITextFieldViewModeWhileEditing;
           tf1.leftViewMode = UITextFieldViewModeAlways;
           tf1.delegate=self;
           UILabel * label1=[[UILabel alloc]initWithFrame:CGRectMake(-10, 0, 74*KScaleW, 75*KScaleH)];
           label1.textAlignment=NSTextAlignmentLeft;
           label1.font=[UIFont systemFontOfSize:15*KScaleW];
           label1.text=@[@"教室",@"周数",@"节数",@"老师"][i];
           tf1.leftView=label1;
           [bgView addSubview:tf1];
        if ([self.classType isEqualToString:@"1"]) {
            tf1.text=@[self.roomName,self.weekNum,[NSString stringWithFormat:@"%@ %@",self.weekStart,self.sectionRoom],self.teachername][i];
               }
        UIView * lineView=[[UIView alloc]initWithFrame:CGRectMake(25.33*KScaleW, tf1.bottom, bgView.width-25.33*KScaleW, 0.5*KScaleH)];
        lineView.backgroundColor=RGB(247, 244, 249);
        [bgView addSubview:lineView];
        
        if (i==0) {
            self.classTF=tf1;
        }
        if (i==1) {
            self.weekTF=tf1;
        }
        if (i==2) {
            self.numberTF=tf1;
        }
        if (i==3) {
            self.teacherTF=tf1;
            lineView.hidden=YES;
        }
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.weekTF) {
        if (self.weekList.count==0) {
            [self.view toast:@"您当前处在假期中"];
        }else{
        SinglePickerView  *  customVC =[[SinglePickerView alloc]initWithComponentDataArray:self.weekList  title:@"选择当前周数"];
        customVC.getPickerValue = ^(NSString *compoentString) {
            NSLog(@"%@   ",    compoentString);
            self.weekTF.text=[NSString stringWithFormat:@"%@",compoentString];
            [self.dataList addObject:compoentString];
          
        };
       
            [self.view addSubview:customVC];
            
        }

         return NO;
    }
    if (textField==self.numberTF) {
      
        CustomMyPickerView   *   threeVC=[[CustomMyPickerView alloc]initWithComponentDataArray:@[@"周一",@"周二",@"周三",@"周四",@"周五"] titleDataArray:self.sectionList  title:@"选择节数与时间"];
                                 threeVC.getPickerValue = ^(NSString * _Nonnull compoentString, NSString * _Nonnull titileString) {
                                      [self.dataList addObject:compoentString];
                                      [self.dataList addObject:titileString];
                                      NSString * str=[NSString stringWithFormat:@"%@ %@",compoentString,titileString];
                                     [self.numberTF setText:str];
                                 };
               
        [self.view addSubview:threeVC];
        return NO;
    }
    return YES;;
}
-(void)addOther{
    
}
-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList=[NSMutableArray array];
    }
    return _dataList;
}
- (BOOL)checkText {

    if ([self.classNameTF.text isEmpty]) {
        
        [self.view toast:@"课程名称不能为空"];
        return NO;
    }
    if ([self.classTF.text isEmpty]) {
        
        [self.view toast:@"班级不能为空"];
        return NO;
    }
    if ([self.weekTF.text isEmpty]) {
     
        [self.view toast:@"周数不能为空"];
        return NO;
    }
    if ([self.numberTF.text isEmpty]) {
        
        [self.view toast:@"节数不能为空"];
        return NO;
    }
    if ([self.teacherTF.text isEmpty]) {
        
        [self.view toast:@"教师名称不能为空"];
        return NO;
    }
    
    return YES;
}

@end
