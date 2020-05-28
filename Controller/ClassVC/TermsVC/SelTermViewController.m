//
//  SelTermViewController.m
//  ClassSchedule
//
//  Created by Superme on 2019/11/7.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "SelTermViewController.h"
#import "SelTermTableViewCell.h"
#import "AddNumberViewController.h"
#import "TermDetailViewController.h"
@interface SelTermViewController ()<UITableViewDelegate,UITableViewDataSource,CSBaseTableViewDelegate>

@property (nonatomic, strong) CSBaseTableView       *     tableView;
@property (nonatomic, strong) NSMutableArray        *     dataList;
@property (nonatomic, strong) UIImageView           *     emptyImage;
@property (nonatomic, strong) UILabel               *     emptyLabel;
@end

@implementation SelTermViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
     [self loadData];
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.naviView.rightItemButton setImage:[UIImage imageNamed:@"class_term_add"] forState:UIControlStateNormal];
    self.naviView.naviTitleLabel.text=@"选择学期";
    self.view.backgroundColor=RGB(245, 244, 247);
    [self.naviView.rightItemButton addTarget:self action:@selector(addTerms) forControlEvents:UIControlEventTouchUpInside];
    self.emptyImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"empty"]];
    self.emptyImage.frame=CGRectMake(0, self.naviView.bottom+11.5*KScaleH, SCREEN_WIDTH, SCREEN_WIDTH);
    [self.view addSubview:self.emptyImage];
    self.emptyLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH-64*KScaleW, SCREEN_WIDTH, 15*KScaleW)];
    self.emptyLabel.text=@"点击右上角按钮添加学期吧！~";
    self.emptyLabel.font=[UIFont boldSystemFontOfSize:15*KScaleW];
    self.emptyLabel.textAlignment=NSTextAlignmentCenter;
    self.emptyLabel.textColor=[UIColor colorWithHexString:@"#29675F"];
    [self.emptyImage addSubview:self.emptyLabel];
    self.emptyImage.hidden=YES;
}
-(void)addTerms{
    AddNumberViewController   *  vc=[[AddNumberViewController alloc]init];
    vc.type=@"0";
    vc.naviView.naviTitleLabel.text=@"创建学期";
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)loadData{
    NSLog(@"%@",[UserInfoDefaults userInfo].token);
    [ClassHandle getTermsListWithToken:[UserInfoDefaults userInfo].token success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        NSLog(@"%@",[UserInfoDefaults userInfo].token);
        if ([dic[@"code"] intValue]==1) {
            self.dataList=[TermsListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            
            [self.tableView reloadData];
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
}
#pragma mark - delegate & datasource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
      TermsListModel  *  model=self.dataList[indexPath.row];
     NSUserDefaults  *  defaults=[NSUserDefaults standardUserDefaults];
     NSDictionary  *  dic=@{
        @"end_year":model.end_year,
        @"id":model.id,
        @"max_section":model.max_section,
        @"num" :model.num,
        @"start_year" :model.start_year,
        @"uid" :model.uid,
        @"week":model.week,
        @"week_start_day" :model.week_start_day,
        @"day":model.day
    };
    if (self.SelTermBlock) {
        self.SelTermBlock();
    }
    [defaults setObject:dic forKey:@"termsDic"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
   
    return 0*KScaleH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SelTermTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[ SelTermTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    cell.model=self.dataList[indexPath.row];
    return cell;
}


//- ( UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)){
//    //删除
//     TermsListModel  *  model=self.dataList[indexPath.row];
//    if (@available(iOS 11.0, *)) {
//        UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
//            NSDictionary * dic=@{@"token":[UserInfoDefaults userInfo].token ,@"id":model.id};
//            [HttpTools post:API_DELETE_TERMS params:dic loading:NO success:^(id  _Nonnull json) {
//                NSDictionary * dic=(NSDictionary *)json;
//                if ([dic[@"code"] intValue]==1) {
//                    [self.dataList removeObjectAtIndex:indexPath.row];
//                    // 2. 更新UI
//                    [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
//                    [self.tableView reloadData];
//                    [self.view toast:@"删除成功"];
//                }else{ [self.view toast:dic[@"msg"]];
//                    
//                }
//            } failure:^(NSError * _Nonnull error) {
//                
//            }];
//            
//            completionHandler (YES);
//            [self.tableView reloadData];
//        }];
//        
//        deleteRowAction.backgroundColor = [UIColor redColor];
//        
//        UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
//   
//       return config;
//        // Fallback on earlier versions
//    }
//    return nil;
//}


-(NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath

{
       TermsListModel  *  model=self.dataList[indexPath.row];
//自定义左滑显示编辑按钮

UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
     AddNumberViewController   *  vc=[[AddNumberViewController alloc]init];
      vc.type=@"1";
      vc.naviView.naviTitleLabel.text=@"编辑学期";
      [self.navigationController pushViewController:vc animated:YES];
      vc.ID=model.id;
 NSLog(@"编辑");}];
UITableViewRowAction *rowActionSec = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault

title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {

      NSDictionary * dic=@{@"token":[UserInfoDefaults userInfo].token ,@"id":model.id};
        [HttpTools post:API_DELETE_TERMS params:dic loading:NO success:^(id  _Nonnull json) {
            NSDictionary * dic=(NSDictionary *)json;
                   if ([dic[@"code"] intValue]==1) {
     [self.dataList removeObjectAtIndex:indexPath.row];
      // 2. 更新UI
      [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
                       [self.tableView reloadData];
                       [self.view toast:@"删除成功"];
                   }else{ [self.view toast:dic[@"msg"]];
    
                   }
        } failure:^(NSError * _Nonnull error) {
    
        }];

}];
rowActionSec.backgroundColor = [UIColor colorWithHexString:@"#f1c0c0"];
rowAction.backgroundColor=[UIColor colorWithHexString:@""];
NSArray *arr = @[rowActionSec,rowAction];
return arr;
}


-(CSBaseTableView *)tableView{
    if (!_tableView) {
        _tableView=[[CSBaseTableView alloc]initWithFrame:CGRectMake(0, self.naviView.bottom+6*KScaleH, SCREEN_WIDTH, SCREEN_HEIGHT-self.naviView.bottom-6*KScaleH) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorColor=[UIColor clearColor];
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.rowHeight=96*KScaleH;
        _tableView.tableHeaderView=[UIView new];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
@end
