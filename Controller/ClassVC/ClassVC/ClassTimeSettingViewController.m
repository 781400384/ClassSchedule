//
//  ClassTimeSettingViewController.m
//  ClassSchedule
//
//  Created by Superme on 2019/10/31.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "ClassTimeSettingViewController.h"
#import "CustomMyPickerView.h"
@interface ClassTimeSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView     *    tableView;
@property (nonatomic, strong) NSMutableArray  *    contentList;
@property (nonatomic, strong) NSArray         *    timeArray;
@property (nonatomic, strong) NSMutableArray  *    dataList;
@end

@implementation ClassTimeSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.naviView.naviTitleLabel.text=@"设置上课时间";
    self.naviView.rightTitleLabel.text=@"保存";
    self.naviView.rightTitleLabel.textColor=[UIColor colorWithHexString:@"f4e0e7"];
    self.view.backgroundColor=RGB(247, 244, 249);
    [self tableView];
  
  self.timeArray=@[@"06:00",@"06:05",@"06:10",@"06:15",@"06:20",@"06:25",@"06:30",@"06:35",@"06:40",@"06:45",@"06:50",@"06:55",@"07:00",@"07:05",@"07:10",@"07:15",@"07:20",@"07:25",@"07:30",@"07:35",@"07:40",@"07:45",@"07:50",@"07:55",@"08:00",@"08:05",@"08:10",@"08:15",@"08:20",@"08:25",@"08:30",@"08:35",@"08:40",@"08:45",@"08:50",@"08:55",@"09:00",@"09:05",@"09:10",@"09:15",@"09:20",@"09:25",@"09:30",@"09:35",@"09:40",@"09:45",@"09:50",@"09:55",@"10:00",@"10:05",@"10:10",@"10:15",@"10:20",@"10:25",@"10:30",@"10:35",@"10:40",@"10:45",@"10:50",@"10:55",@"11:00",@"11:05",@"11:10",@"11:15",@"11:20",@"11:25",@"11:30",@"11:35",@"11:40",@"11:45",@"11:50",@"11:55",@"12:00",@"12:05",@"12:10",@"12:15",@"12:20",@"12:25",@"12:30",@"12:35",@"12:40",@"12:45",@"12:50",@"12:55",@"13:00",@"13:05",@"13:10",@"13:15",@"13:20",@"13:25",@"13:30",@"13:35",@"13:40",@"13:45",@"13:50",@"13:55",@"14:00",@"14:05",@"14:10",@"14:15",@"14:20",@"14:25",@"14:30",@"14:35",@"14:40",@"14:45",@"14:50",@"14:55",@"15:00",@"15:05",@"15:10",@"15:15",@"15:20",@"15:25",@"15:30",@"15:35",@"15:40",@"15:45",@"15:50",@"15:55",@"16:00",@"16:05",@"16:10",@"16:15",@"16:20",@"16:25",@"16:30",@"16:35",@"16:40",@"16:45",@"16:50",@"16:55",@"17:00",@"17:05",@"17:10",@"17:15",@"17:20",@"17:25",@"17:30",@"17:35",@"17:40",@"17:45",@"17:50",@"17:55",@"18:00",@"18:05",@"18:10",@"18:15",@"18:20",@"18:25",@"18:30",@"18:35",@"18:40",@"18:45",@"18:50",@"18:55",@"19:00",@"19:05",@"19:10",@"19:15",@"19:20",@"19:25",@"19:30",@"19:35",@"19:40",@"19:45",@"19:50",@"19:55",@"20:00",@"20:05",@"20:10",@"20:15",@"20:20",@"20:25",@"20:30",@"20:35",@"20:40",@"20:45",@"20:50",@"20:55",@"21:00",@"21:05",@"21:10",@"21:15",@"21:20",@"21:25",@"21:30",@"21:35",@"21:40",@"21:45",@"21:50",@"21:55",@"22:00"];
}
-(void)rightTitleLabelTap{
     NSInteger i=[[UserInfoDefaults valueForKey:@"maxSections"] integerValue];
    if (self.dataList.count<i) {
        [self.view toast:@"请完善上课时间"];
    }else{
    
    if (self.ClassTimeSettingBlock) {
        self.ClassTimeSettingBlock(self.dataList);
    }
    [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"%@",self.dataList);
        
    }
}
#pragma mark - delegate & datasource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    CustomMyPickerView *customVC =[[CustomMyPickerView alloc] initWithComponentDataArray:self.timeArray titleDataArray:self.timeArray title:[NSString stringWithFormat:@"第%ld节",indexPath.row+1]];
       customVC.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
           NSString *  str=[NSString stringWithFormat:@"%@-%@",compoentString,titileString];
           [self.contentList replaceObjectAtIndex:indexPath.row withObject:str];
           [self.tableView reloadData];
           NSDictionary  *  dic=@{@"start_time":compoentString,
                                  @"end_time":titileString,
                                  @"num":[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]
           };
           [self.dataList addObject:dic];
       };
    [self.view addSubview:customVC];
    
   
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 61*KScaleH;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger i=[[UserInfoDefaults valueForKey:@"maxSections"] integerValue];
    return i;
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
    cell.textLabel.text=[NSString stringWithFormat:@"第%ld节",indexPath.row+1];
    cell.detailTextLabel.text=self.contentList[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(UITableView *)tableView{
    if (!_tableView) {
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(30*KScaleW, self.naviView.bottom+8*KScaleH, SCREEN_WIDTH-60*KScaleW, 366*KScaleH) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.separatorColor=RGB(247, 244, 249);
        [tableView setRadius:34.5*KScaleW];
        tableView.backgroundColor=[UIColor whiteColor];;
        [self.view addSubview:tableView];
        _tableView=tableView;
    }
    return _tableView;
}
-(NSMutableArray *)contentList{
    if (!_contentList) {
        _contentList=[NSMutableArray array];
        int a=[[UserInfoDefaults valueForKey:@"maxSections"] intValue];
        for (int i=0; i<a; i++) {
            [_contentList addObject:@""];
        }
    }
    return _contentList;
}
-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList=[NSMutableArray array];
      
    }
    return _dataList;
}


@end
