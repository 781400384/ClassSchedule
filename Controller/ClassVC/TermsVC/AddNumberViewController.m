//
//  AddNumberViewController.m
//  ClassSchedule
//
//  Created by Superme on 2019/10/30.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "AddNumberViewController.h"
#import "ClassSettingViewController.h"
#import "CustomMyPickerView.h"
#import "SinglePickerView.h"
#import "HttpTools.h"
#import "CXDatePickerView.h"



#define randomColor [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1]
@interface AddNumberViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView     *    tableView;
@property (nonatomic, strong) NSArray         *    dataList;
@property (nonatomic, strong) NSMutableArray  *    contentList;
@property (nonatomic, strong) NSMutableArray  *    list;
@property (nonatomic, strong) NSMutableArray  *    timeList;
@property (nonatomic, copy)   NSString        *    max;
@end

@implementation AddNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataList=@[@"当前学期",@"当前周数",@"设置节数与时间",@"每周起始日",@"开学时间"];
    [self tableView];
    self.view.backgroundColor=RGB(247, 244, 249);
    self.naviView.rightTitleLabel.text=@"保存";
    self.naviView.rightTitleLabel.textColor=[UIColor colorWithHexString:@"f4e0e7"];
   
}
-(void)rightTitleLabelTap{
    
  

    if ([self.list[0] isEmpty]) {
    [self.view toast:@"请设置当前学期"];
    }else  if ([self.list[3] isEmpty]) {
    [self.view toast:@"请设置当前周数"];
    }else if (self.timeList.count==0) {
    [self.view toast:@"请设置上课时间"];
    }else   if ([self.max isEmpty]) {
    [self.view toast:@"请设置课表最大节数"];
    }else if ([self.list[4] isEmpty]) {
    [self.view toast:@"请设置每周起始日"];
    }else if ([self.list[5] isEmpty]) {
    [self.view toast:@"请设置开学时间"];
    }else{
        
    if ([self.type isEqualToString:@"0"]) {
            NSDictionary * dic=@{@"token":[UserInfoDefaults userInfo].token,
                                            @"start_year":self.list[0],
                                            @"end_year":self.list[1],
                                            @"num":self.list[2] ,
                                            @"week":self.list[3],
                                            @"max_section":self.max ,
                                            @"times":self.timeList,
                                            @"week_start_day":self.list[4],
                                            @"day":self.list[5]
                       };
              
                   [HttpTools post:API_ADD_TERMS params:dic loading:NO success:^(id  _Nonnull json) {
                           NSDictionary * dic=(NSDictionary *)json;
                               if ([dic[@"code"] intValue]==1) {
                                   [self.view toast:@"添加成功"];
                                    [self.navigationController popViewControllerAnimated:YES];
                               }else{
                       [self.view toast:dic[@"msg"]];
                                   
                               }
                   } failure:^(NSError * _Nonnull error) {
                       
                   }];

        }
        if ([self.type isEqualToString:@"1"]) {
            NSDictionary * dic=@{@"id":self.ID,
                       @"token":[UserInfoDefaults userInfo].token,
                                                   @"start_year":self.list[0],
                                                   @"end_year":self.list[1],
                                                   @"num":self.list[2] ,
                                                   @"week":self.list[3],
                                                   @"max_section":self.max ,
                                                   @"times":self.timeList,
                                                   @"week_start_day":self.list[4],
                                                   @"day":self.list[5]
                              };
                     
                          [HttpTools post:API_UPDATE_TERMS params:dic loading:NO success:^(id  _Nonnull json) {
                                  NSDictionary * dic=(NSDictionary *)json;
                                      if ([dic[@"code"] intValue]==1) {
                                          [self.view toast:@"修改成功"];
                                            [self.navigationController popViewControllerAnimated:YES];
                                      }else{
                              [self.view toast:dic[@"msg"]];}
                          } failure:^(NSError * _Nonnull error) {
                              
                          }];

               }
        
        }
}
#pragma mark - delegate & datasource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ClassSettingViewController   *    settingVC=[[ClassSettingViewController alloc]init];
    settingVC.ClassSettingBlock = ^(NSString * _Nonnull maxSection, NSMutableArray * _Nonnull TimeList) {
        self.max=maxSection;
        self.timeList=TimeList;
    };
    CustomMyPickerView *customVC =[[CustomMyPickerView alloc] initWithComponentDataArray:@[@"2019-2020",@"2020-2021",@"2021-2022",@"2022-2023",@"2023-2024",@"2024-2025",@"2025-2026",@"2026-2027",@"2027-2028",@"2028-2029"] titleDataArray:@[@"第一学期",@"第二学期"] title:@"选择学年和学期"];
       customVC.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
           NSString *  str=[NSString stringWithFormat:@"%@ %@",compoentString,titileString];
           [self.contentList replaceObjectAtIndex:0 withObject:str];
           NSString  *  str1=[compoentString substringToIndex:4];
           NSString  *  str2=[compoentString substringFromIndex:5];
           [self.list replaceObjectAtIndex:0 withObject:str1];
           [self.list replaceObjectAtIndex:1 withObject:str2];
          
           if ([titileString isEqualToString:@"第一学期"]) {
              
                [self.list replaceObjectAtIndex:2 withObject:@"1"];
           }
           if ([titileString isEqualToString:@"第二学期"]){
              
                [self.list replaceObjectAtIndex:2 withObject:@"2"];
           }
//           [self.list replaceObjectAtIndex:2 withObject:titileString];
           [self.tableView reloadData];
       };
    
    
    SinglePickerView    *     singleVC=[[SinglePickerView alloc]initWithComponentDataArray:@[@"假期中",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25"] title:@"选择当前周数"];
    singleVC.getPickerValue = ^(NSString *compoentString) {
        [self.contentList replaceObjectAtIndex:1 withObject:compoentString];
        if ([compoentString isEqualToString:@"假期中"]) {
        [self.list replaceObjectAtIndex:3 withObject:@"0"];
        }else{
          
            [self.list replaceObjectAtIndex:3 withObject:compoentString];
        }
        
        
        [self.tableView reloadData];
    };
    SinglePickerView    *     singleVC2=[[SinglePickerView alloc]initWithComponentDataArray:@[@"周一",@"周二",@"周三",@"周四",@"周五"] title:@"选择每周起始日"];
       singleVC2.getPickerValue = ^(NSString *compoentString) {
           [self.contentList replaceObjectAtIndex:3 withObject:compoentString];
           [self.list replaceObjectAtIndex:4 withObject:compoentString];
           [self.tableView reloadData];
       };
    CXDatePickerView *datepicker = [[CXDatePickerView alloc] initWithDateStyle:CXDateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
        
        NSString *dateString = [selectDate stringWithFormat:@"yyyy-MM-dd"];
        [self.contentList replaceObjectAtIndex:4 withObject:dateString];
        [self.list replaceObjectAtIndex:5 withObject:dateString];
        [self.tableView reloadData];
    }];
    datepicker.dateLabelColor = [UIColor colorWithHexString:@"#3f3166"];//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor colorWithHexString:@"#444444"];//滚轮日期颜色
    datepicker.doneButtonColor = [UIColor colorWithHexString:@"#29675f "];//确定按钮的颜色
    datepicker.cancelButtonColor = [UIColor colorWithHexString:@"#f1c0c0"];
    datepicker.yearLabelColor=[UIColor colorWithHexString:@"#ebebeb"];
    switch (indexPath.row) {
        case 0:
            [self.view addSubview:customVC];
            break;
        case 1:
             [self.view addSubview:singleVC];
            break;
        case 2:
            
            [self.navigationController pushViewController:settingVC animated:NO];
            break;
        case 3:
           [self.view addSubview:singleVC2];
            break;
        case 4:
            [datepicker show];
            break;
        default:
            break;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 61*KScaleH;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[ UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.text=self.dataList[indexPath.row];
    cell.detailTextLabel.text=self.contentList[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(UITableView *)tableView{
    if (!_tableView) {
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(30*KScaleW, self.naviView.bottom+8*KScaleH, SCREEN_WIDTH-60*KScaleW, 305*KScaleH) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
//        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.separatorColor=RGB(247, 244, 249);
        [tableView setRadius:34.5*KScaleH];
        tableView.backgroundColor=[UIColor whiteColor];;
        [self.view addSubview:tableView];
        _tableView=tableView;
    }
    return _tableView;
}
-(NSMutableArray *)contentList{
    if (!_contentList) {
        _contentList=[NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@""]];
    }
    return _contentList;
}
-(NSMutableArray *)list{
    if (!_list) {
        _list=[NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@"",@""]];
    }
    return _list;
}
@end
