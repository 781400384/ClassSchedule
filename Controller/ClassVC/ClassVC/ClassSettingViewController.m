//
//  ClassSettingViewController.m
//  ClassSchedule
//
//  Created by Superme on 2019/10/31.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "ClassSettingViewController.h"
#import "SinglePickerView.h"
#import "ClassTimeSettingViewController.h"
@interface ClassSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView      *    tableView;
@property (nonatomic, strong) NSArray          *    titleList;
@property (nonatomic, strong) NSMutableArray   *    contentList;

@end

@implementation ClassSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.naviTitleLabel.text=@"设置节数与时间";
    self.titleList=@[@"设置课表最大节数",@"设置上课时间"];
    self.view.backgroundColor=RGB(247, 244, 249);
    self.naviView.rightTitleLabel.text=@"保存";
    self.naviView.rightTitleLabel.textColor=[UIColor colorWithHexString:@"f4e0e7"];
    [self tableView];
   
}
-(void)rightTitleLabelTap{
    if (self.dataList.count==0) {
        [self.view toast:@"请设置上课时间"];
    }else if([[UserInfoDefaults valueForKey:@"maxSections"] isEmpty]){
         [self.view toast:@"请设置课表最大节数"];
    }else{
        if (self.ClassSettingBlock) {
            self.ClassSettingBlock(self.contentList[0], self.dataList);
        }
        [self.navigationController popViewControllerAnimated:YES ];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ClassTimeSettingViewController   *  vc=[[ClassTimeSettingViewController alloc]init];
    
    SinglePickerView    *     singleVC=[[SinglePickerView alloc]initWithComponentDataArray:@[@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25"] title:@"设置课表的最大节数"];
    singleVC.getPickerValue = ^(NSString *compoentString) {
        [self.contentList replaceObjectAtIndex:0 withObject:compoentString];
        [UserInfoDefaults saveValue:compoentString forKey:@"maxSections"];
        [self.tableView reloadData];
    };
    switch (indexPath.row) {
        case 0:
             [self.view addSubview:singleVC];
            break;
        case 1:
// 需添加一个网络请求，很具网络请求返回值进行判断赋值VC row的数量
            if([[UserInfoDefaults valueForKey:@"maxSections"] intValue]<=0){
         [self.view toast:@"请先设置最大上课节数"];
 }else{
     vc.ClassTimeSettingBlock = ^(NSMutableArray * _Nonnull array) {
         self.dataList=array;
     };
     [self.navigationController pushViewController:vc animated:NO];

 }
            break;
            
        default:
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 61*KScaleH;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
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
    cell.textLabel.text=self.titleList[indexPath.row];
    cell.detailTextLabel.text=self.contentList[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(UITableView *)tableView{
    if (!_tableView) {
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(30*KScaleW, self.naviView.bottom+8*KScaleH, SCREEN_WIDTH-60*KScaleW, 122*KScaleH) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.separatorColor=RGB(244, 244, 244);
        [tableView setRadius:34.5*KScaleW];
        tableView.backgroundColor=[UIColor whiteColor];;
        [self.view addSubview:tableView];
        _tableView=tableView;
    }
    return _tableView;
}
-(NSMutableArray *)contentList{
    if (!_contentList) {
        _contentList=[NSMutableArray arrayWithArray:@[@"",@""]];
        
    }
    return _contentList;
}

@end
