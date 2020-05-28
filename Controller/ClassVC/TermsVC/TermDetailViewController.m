//
//  TermDetailViewController.m
//  ClassSchedule
//
//  Created by Superme on 2019/11/13.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "TermDetailViewController.h"
#import "ClassTimeModel.h"
#import "AddNumberViewController.h"
@interface TermDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView     *    tableView;
@property (nonatomic, strong) NSArray         *    dataList;
@property (nonatomic, strong) NSMutableArray  *    contentList;
@property (nonatomic, strong) NSMutableArray  *    classList;
@property (nonatomic, strong) NSMutableArray  *    titleList;
@property (nonatomic, strong) NSMutableDictionary *  dictionary;

@end

@implementation TermDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataList=@[@"当前学期",@"当前周数",@"上课最大节数",@"每周起始日",@"开学日期"];
    [self loadData];
    self.naviView.rightTitleLabel.text=@"编辑";
    self.naviView.rightTitleLabel.textColor=[UIColor colorWithHexString:@"f4e0e7"];
}
-(void)rightTitleLabelTap{
    AddNumberViewController    *   vc=[[AddNumberViewController alloc]init];
    vc.type=@"1";
    vc.naviView.naviTitleLabel.text=@"编辑学期";
    vc.ID=self.ID;
    [self.navigationController pushViewController:vc animated:NO];
}
-(void)loadData{
    [ClassHandle getTermsDetailWithID:self.ID token:[UserInfoDefaults userInfo].token success:^(id  _Nonnull obj) {
           NSDictionary * dictionary=(NSDictionary *)obj;
           if ([dictionary[@"code"] intValue]==1) {
              
               self.classList=[ClassTimeModel mj_objectArrayWithKeyValuesArray:dictionary[@"data"][@"times"]];
                [self.tableView reloadData];
           }
         
       } failed:^(id  _Nonnull obj) {
           
       }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 61*KScaleH;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.classList.count;
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
    if (indexPath.row==0&&indexPath.row==1&&indexPath.row==2&&indexPath.row==3&&indexPath.row==4) {
    }else{
   

    }
   
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(UITableView *)tableView{
    if (!_tableView) {
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(30*KScaleW, self.naviView.bottom+8*KScaleH, SCREEN_WIDTH-60*KScaleW, 305*KScaleH) style:UITableViewStylePlain];
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
    }
    return _contentList;
}
-(NSMutableArray *)classList{
    if (!_classList) {
        _classList=[NSMutableArray array];
    }
    return _classList;
}
-(NSMutableArray *)titleList{
    if (!_titleList) {
        _titleList=[NSMutableArray array];
    }
    return _titleList;
}
@end
