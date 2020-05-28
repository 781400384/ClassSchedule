//
//  ClassVCViewController.m
//  ClassSchedule
//
//  Created by Superme on 2019/10/26.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "ClassVCViewController.h"
#import "ClassVCTableViewCell.h"
#import "CSBaseTableView.h"
#import "SelClassViewController.h"
#import "AddNumberViewController.h"
#import "ClassDetailViewController.h"
#import "SelClassViewController.h"
#import "UniverdsityListViewController.h"
#import "SelTermViewController.h"
#import "ClassTimeModel.h"
#import "ClassListModel.h"
#import "CSWebViewController.h"
#import "ADVAlertView.h"
#import "CSWebViewController.h"
@interface ClassVCViewController ()<CSBaseTableViewDelegate,UITableViewDataSource,UITableViewDelegate,ADVAlertViewDelegate>
@property (nonatomic, strong) NSMutableArray    *    weekOneList;
@property (nonatomic, strong) NSMutableArray    *    weekTwoList;
@property (nonatomic, strong) NSMutableArray    *    weekThreeList;
@property (nonatomic, strong) NSMutableArray    *    weekFourList;
@property (nonatomic, strong) NSMutableArray    *    weekFiveList;
@property (nonatomic, strong) NSMutableArray    *    dataList;
@property (nonatomic, strong) CSBaseTableView   *    tableView;
@property (nonatomic, strong) UILabel           *    schoolLabel;
@property (nonatomic, strong) UILabel           *    timeLabel;
@property (nonatomic, assign) int                    index;
@end

@implementation ClassVCViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self loadData];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.hidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    [self alertView];
}



-(void)alertView{
        [ClassHandle getImageWithId:@"2" success:^(id  _Nonnull obj) {
    
            NSDictionary  *  dic=(NSDictionary *)obj;
            if ([dic[@"code"] intValue]==1) {
                
                if ([dic[@"data"][@"url"] isEmpty]||[dic[@"data"][@"image"] isEmpty]) {
                    
                }else{
                
                ADVAlertView   *  alert=[[ADVAlertView alloc]initWithImage:[NSString stringWithFormat:@"%@",dic[@"data"][@"image"]]];
                alert.userInteractionEnabled=YES;
                alert.clipsToBounds=YES;
                UITapGestureRecognizer   *  tap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
                    CSWebViewController  *  webVC=[[CSWebViewController alloc]init];
                    [self.navigationController pushViewController:webVC animated:YES];
                    webVC.linkUrl=[NSString stringWithFormat:@"%@",dic[@"data"][@"url"]];
                    [alert dismissAlertView];
                }];
                [alert addGestureRecognizer:tap];
                    [alert showView];
                    
                }
            }
    
        } failed:^(id  _Nonnull obj) {
    
        }];
}
#pragma mark - 查看课程列表
-(void)loadData{
    
    NSUserDefaults  *  defaults=[NSUserDefaults standardUserDefaults];
    NSDictionary * dic=[defaults valueForKey:@"termsDic"];
  //如果本地学期存储数据为空，则d调用获取学期列表接口
    if (dic[@"id"] ==nil) {
        [ClassHandle getTermsListWithToken:[UserInfoDefaults userInfo].token success:^(id  _Nonnull obj) {
               NSDictionary * data=(NSDictionary *)obj;
            NSLog(@"返回的数据%@",data);
               if ([data[@"code"] intValue]==1) {
                   NSMutableArray   *  dataList=data[@"data"];
         
                   if (dataList.count==0) {
                        //如果学期列表数量为0，进进入学期列表界面，创建学期
                       [self tap];
                       [self.view toast:@"请选择学期"];
                   }else{
                   NSDictionary *  object=dataList[0];
                   [defaults setObject:object forKey:@"termsDic"];
                   [self getTerms];
                   }
                   
               }
           } failed:^(id  _Nonnull obj) {
               
           }];
    }else{
      //根据当前本地存储学期获取学期详情
        [self getTerms];
       
    }
    
   
}
#pragma mark - 查看学期

-(void)getTerms{
   
    NSUserDefaults  *  defaults=[NSUserDefaults standardUserDefaults];
    NSDictionary * dic=[defaults valueForKey:@"termsDic"];
    [ClassHandle getTermsDetailWithID:dic[@"id"] token:[UserInfoDefaults userInfo].token success:^(id  _Nonnull obj) {
        NSDictionary * dictionary=(NSDictionary *)obj;
//        [self.view toast:dictionary[@"msg"]];
        if ([dictionary[@"code"] intValue]==1) {
            self.dataList=[ClassTimeModel mj_objectArrayWithKeyValuesArray:dictionary[@"data"][@"times"]];
            //获取课程列表数据
            NSMutableArray   *  arr=[NSMutableArray array];
            [arr addObjectsFromArray:[self.dataList valueForKey:@"start_time"]];
            [UserInfoDefaults saveValue:arr forKey:@"timeArr"];
            #pragma mark - 计算两个时间差
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
              [dateFormatter setDateFormat:@"yyyy-MM-dd"];// 得到当前时间（世界标准时间 UTC/GMT）
            NSDate *nowDate = [NSDate date];
            NSString *dateStr=dic[@"day"];
            NSDate * sta=[dateFormatter dateFromString:dateStr];
            NSCalendar *calendar = [NSCalendar currentCalendar];
             NSCalendarUnit type =NSCalendarUnitDay ;
             // 3.利用日历对象比较两个时间的差值
             NSDateComponents *cmps = [calendar components:type fromDate:sta toDate:nowDate options:0];
              

            
            
            
            NSDictionary * params=@{
                @"token":[UserInfoDefaults userInfo].token,
                @"week":[NSString stringWithFormat:@"%ld",cmps.day/7+1],
                @"term_id":dic[@"id"]
                
                
            };
            [HttpTools post:API__GET_CLASS_LIST params:params loading:NO success:^(id  _Nonnull json) {
               
                NSDictionary  *    abc=(NSDictionary *)json;
                    if ([abc[@"code"] intValue]==1) {

                    self.weekOneList=[ClassListModel mj_objectArrayWithKeyValuesArray:abc[@"data"][@"周一"]];
                     
                    self.weekTwoList=[ClassListModel mj_objectArrayWithKeyValuesArray:abc[@"data"][@"周二"]];
                    self.weekThreeList=[ClassListModel mj_objectArrayWithKeyValuesArray:abc[@"data"][@"周三"]];
                        
                    self.weekFourList=[ClassListModel mj_objectArrayWithKeyValuesArray:abc[@"data"][@"周四"]];
                        
                    self.weekFiveList=[ClassListModel mj_objectArrayWithKeyValuesArray:abc[@"data"][@"周五"]];
                        
                         [self configUI];
                                        }
            } failure:^(NSError * _Nonnull error) {
                
            }];
           
        }
        if ([dictionary[@"code"] intValue]==0) {
        [self tap];
            
        }
      
    } failed:^(id  _Nonnull obj) {
        
    }];
        
  
}
#pragma mark - 配置UI
-(void)configUI{
    [self.tableView reloadData];
    UIImageView   *   naviView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"class_bg"]];
    naviView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 165*KScaleH);;
    naviView.clipsToBounds=YES;
    naviView.userInteractionEnabled=YES;
    naviView.contentMode=UIViewContentModeScaleToFill;
    [self.view addSubview:naviView];
    
    
    UILabel   *   titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal, SCREEN_WIDTH, 20*KScaleH)];
    titleLabel.textColor=[UIColor colorWithHexString:@"f4e0e7"];
    titleLabel.font=[UIFont systemFontOfSize:19*KScaleW];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.userInteractionEnabled=YES;
    if ([UserInfoDefaults valueForKey:@"school"]==nil) {
          titleLabel.text=@"沈阳师范大学";
    }else{
          titleLabel.text=[UserInfoDefaults valueForKey:@"school"];
    }
  
    self.schoolLabel=titleLabel;
    UITapGestureRecognizer   *  selUn=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        UniverdsityListViewController   *  vc=[[UniverdsityListViewController alloc]init];
           vc.SchoolBlock = ^(NSString * _Nonnull school_id, NSString * _Nonnull school_name, NSString * _Nonnull major_id, NSString * _Nonnull major_name) {
              titleLabel.text=school_name;
               [self changeUserInfoWithNickName:[UserInfoDefaults userInfo].nickname==nil?@"":[UserInfoDefaults userInfo].nickname sex:[UserInfoDefaults valueForKey:@"sex"]==nil?@"":[UserInfoDefaults valueForKey:@"sex"] school_id:school_id Major_ID:major_id Major_Item:[UserInfoDefaults valueForKey:@"major_item"]==nil?@"":[UserInfoDefaults valueForKey:@"major_item"]];
               [UserInfoDefaults saveValue:school_name forKey:@"school"];
               [UserInfoDefaults saveValue:major_name forKey:@"major_name"];
           };
           [self.navigationController presentViewController:vc animated:YES completion:nil];
    }];
    [titleLabel addGestureRecognizer:selUn];
    [naviView addSubview:titleLabel];
    
    
  
    NSUserDefaults  *  defaults=[NSUserDefaults standardUserDefaults];
     NSDictionary  *  dic=[defaults objectForKey:@"termsDic"];
    
    UILabel  *  classTime=[[UILabel alloc]initWithFrame:CGRectMake(0, titleLabel.bottom+7*KScaleH, SCREEN_WIDTH, 10)];
    classTime.font=[UIFont boldSystemFontOfSize:10*KScaleW];
    classTime.textColor=[UIColor colorWithHexString:@"f4e0e7"];
    classTime.textAlignment=NSTextAlignmentCenter;
    if (dic==nil) {
         classTime.text=@"请添加学期";
    }else{
         classTime.text=[NSString stringWithFormat:@"%@-%@学年 第%@学期",dic[@"start_year"],dic[@"end_year"],dic[@"num"]];
    }
    classTime.userInteractionEnabled=YES;
    UITapGestureRecognizer   *  tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [classTime addGestureRecognizer:tap];
    [naviView addSubview:classTime];
   
    
#pragma mark - 设置时间
    
    
       NSMutableArray   *   weekArr = [[NSMutableArray alloc] init];
       NSMutableArray   *   monthArr=[[NSMutableArray alloc]init];
       NSDate *nowDate = [NSDate date];
       NSCalendar *calendar = [NSCalendar currentCalendar];
       NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday  fromDate:nowDate];
       // 获取今天是周几
       NSInteger weekDay = [comp weekday];
       // 获取几天是几号
       NSInteger day = [comp day];
        // 计算当前日期和本周的星期一和星期天相差天数
       long first,last;
       if (weekDay == 1){
           first = -6;
           last = 0;
       }
       else{
           first = [calendar firstWeekday] - weekDay + 1;
           last = 8 - weekDay;
       }
          NSDateComponents *baseDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:nowDate];
       //获取周一日期
       [baseDayComp setDay:day + first];
       NSDate *firstDayOfWeek = [calendar dateFromComponents:baseDayComp];
       //计算从周一开始的七天日期
       for (int i = 0; i < 5; i ++) {
           //从现在开始的24小时
           NSTimeInterval secondsPerDay = i * 24*60*60;
           NSDate *curDate = [NSDate dateWithTimeInterval:secondsPerDay sinceDate:firstDayOfWeek];
           NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
           [dateFormatter setDateFormat:@"MM/dd"];
           NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
           NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
           [weekFormatter setDateFormat:@"EEE"];//星期几 @"HH:mm 'on' EEEE MMMM d"];
           NSString *weekStr = [weekFormatter stringFromDate:curDate];
           NSString *chinaStr = [self theWeek:weekStr];
           [monthArr addObject:dateStr];
           [weekArr addObject:chinaStr];
           
           
#pragma mark-  配置时间
           UILabel  *  timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(52*KScaleW+67.33*KScaleW*i, classTime.bottom+60*KScaleH, 28*KScaleW, 13*KScaleH)];
           timeLabel.font=[UIFont systemFontOfSize:13.0f];
           timeLabel.textAlignment=NSTextAlignmentCenter;
           timeLabel.textColor=[UIColor colorWithHexString:@"#f4e0e7"];;
           timeLabel.numberOfLines=0;
           timeLabel.text=weekArr[i];
           [naviView addSubview:timeLabel];
           
           UILabel  *  monthLabel=[[UILabel alloc]initWithFrame:CGRectMake(52*KScaleW+67.33*KScaleW*i, timeLabel.bottom+2*KScaleH, 28*KScaleW, 8*KScaleH)];
            monthLabel.font=[UIFont boldSystemFontOfSize:10.0f];
            monthLabel.textAlignment=NSTextAlignmentCenter;
            monthLabel.textColor=[UIColor colorWithHexString:@"#f4e0e7"];;
            monthLabel.numberOfLines=0;
            monthLabel.text=monthArr[i];
            [naviView addSubview:monthLabel];
            
           
           
       }
}
//转换英文为中文
-(NSString *)theWeek:(NSString *)theWeek{
    NSString *Str;
    if(theWeek){
        if([theWeek isEqualToString:@"Mon"]){
            Str = @"周一";
        }else if([theWeek isEqualToString:@"Tue"]){
            Str = @"周二";
        }else if([theWeek isEqualToString:@"Wed"]){
            Str = @"周三";
        }else if([theWeek isEqualToString:@"Thu"]){
            Str = @"周四";
        }else if([theWeek isEqualToString:@"Fri"]){
            Str = @"周五";
        }else if([theWeek isEqualToString:@"Sat"]){
            Str = @"周六";
        }else if([theWeek isEqualToString:@"Sun"]){
            Str = @"周日";
        }
    }
    return Str;
}

//学期列表
-(void)tap{
    SelTermViewController   *  vc=[[SelTermViewController alloc]init];
    
    //切换学期回调
    vc.SelTermBlock = ^{
        [self loadData];
    };
    [self.navigationController pushViewController:vc animated:NO];
}
#pragma mark - tableView

#pragma mark - delegate & datasource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    NSDictionary * dic=[defaults valueForKey:@"termsDic"];
    NSInteger i=[dic[@"max_section"] integerValue];
    //本地存储z数据最大节数为空，则默认12节
    if(i<=0){
        return 12;
    }else{
        return i;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1*KScaleH;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ClassVCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[ ClassVCTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    //循环赋值当前学期你设置时间
    for (int a =0; a<self.dataList.count; a++) {
      ClassTimeModel * model=self.dataList[
                                           a];
        if([model.num integerValue]==indexPath.row+1){
            cell.startTime.text=model.start_time;
            cell.endTime.text=model.end_time;
           ;
        }
    }
    cell.num.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
    
    
    for (int i=0; i<5; i++) {
        _classBgView=[[UIButton alloc]init];
        _classBgView.backgroundColor=[UIColor whiteColor];
        _classBgView.hidden=YES;
            [cell addSubview: self.classBgView];
            [self.classBgView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (IS_X) {
                     make.left.mas_equalTo(((SCREEN_WIDTH -67.3*KScaleW)/5)*KScaleW*i+29.3*KScaleW);
                }else{
                    make.left.mas_equalTo(((SCREEN_WIDTH -37.3*KScaleW)/5)*KScaleW*i+34.3*KScaleW);
                    
                }
                make.top.mas_equalTo(10*KScaleH);
                make.width.height.mas_equalTo((SCREEN_WIDTH -67.3*KScaleW)/5);
            }];
        
             [_classBgView setRadius:14*KScaleW];
            _classBgView.layer.borderWidth=0.5*KScaleW;
            _classBgView.layer.borderColor=[UIColor colorWithHexString:@"#EBE9F0"].CGColor;
            _className=[[UILabel alloc]init];
            _className.font=[UIFont systemFontOfSize:12*KScaleW];
            _className.textColor=[UIColor colorWithHexString:@"#5E5E5B"];
            _className.numberOfLines=0;
            _className.textAlignment=NSTextAlignmentLeft;
           
        _addImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"class_add"]];
        if (IS_X) {
             _addImage.frame=CGRectMake(((SCREEN_WIDTH -67.3*KScaleW)/5)*KScaleW*i+29.3*KScaleW, 10*KScaleH, (SCREEN_WIDTH -67.3*KScaleW)/5, (SCREEN_WIDTH -67.3*KScaleW)/5);
        }else{
            _addImage.frame=CGRectMake(((SCREEN_WIDTH -37.3*KScaleW)/5)*KScaleW*i+34.3*KScaleW, 10*KScaleH, (SCREEN_WIDTH -67.3*KScaleW)/5, (SCREEN_WIDTH -67.3*KScaleW)/5);}
        _addImage.contentMode=UIViewContentModeScaleToFill;
        UITapGestureRecognizer  *  tap=[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            SelClassViewController   *  vc=[[SelClassViewController alloc]init];
                                                                                      vc.classType=@"0";
                                                                                      vc.naviView.naviTitleLabel.text=@"创建课程";
                                                                                      [self.navigationController pushViewController:vc animated:NO];
        }];
        [_addImage addGestureRecognizer:tap];
        _addImage.clipsToBounds=YES;
        _addImage.userInteractionEnabled=YES;

        [cell addSubview:_addImage];
            _grade=[[UILabel alloc]init];
            _grade.font=[UIFont systemFontOfSize:12*KScaleW];
            _grade.textColor=[UIColor colorWithHexString:@"#5E5E5B"];
            _grade.numberOfLines=0;
            _grade.textAlignment=NSTextAlignmentLeft;
           
                  
           
            _teacherName=[[UILabel alloc]init];
            _teacherName.font=[UIFont systemFontOfSize:12*KScaleW];
            _teacherName.textColor=[UIColor colorWithHexString:@"#5E5E5B"];
            _teacherName.numberOfLines=0;
            _teacherName.textAlignment=NSTextAlignmentLeft;
                 
              
            [self.classBgView addSubview:self.className];
            [self.className mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(5.33*KScaleW);
                make.width.mas_equalTo((SCREEN_WIDTH -67.3*KScaleW)/5-5.33*KScaleW);
                make.top.mas_equalTo(1*KScaleH);
//                make.height.mas_equalTo(26*KScaleH);
            }];
            [self.classBgView addSubview:self.grade];
            [self.grade mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(5.33*KScaleW);
                  make.width.mas_equalTo((SCREEN_WIDTH -67.3*KScaleW)/5-5.33*KScaleW);
                make.top.mas_equalTo(self.className.mas_bottom).offset(1*KScaleH);
            }];
            [self.classBgView addSubview:self.teacherName];
            [self.teacherName mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(5.33*KScaleW);
                  make.width.mas_equalTo((SCREEN_WIDTH -67.3*KScaleW)/5-5.33*KScaleW);
                make.top.mas_equalTo(self.grade.mas_bottom).offset(1*KScaleH);
            }];
            
    if (i==0) {
        for ( int a=0; a<self.weekOneList.count; a++) {
        ClassListModel   *  model=self.weekOneList[a];
       if ([model.section_from integerValue]==indexPath.row+1) {
           
           [UserInfoDefaults saveValue:[self.weekOneList[0] valueForKey:@"section_from"]forKey:@"zhouyi"];
      _addImage.hidden=YES;
      _classBgView.hidden=NO;
     _teacherName.text=model.title;
     _className.text=model.room;
     _grade.text=model.teacher;
    [_classBgView setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                                                                                                        
    ClassDetailViewController  *  vc=[[ClassDetailViewController alloc]init];
    vc.id=model.id;
                                                                                                            
                                                                                                                                        vc.className=model.title;
                                                                                                                                                                                  vc.teacher=model.teacher;
                                                                                                                                                                                  vc.weeknum=model.section_from;
        vc.weekSatrt=model.section_week;                                      vc.room=model.room;
                                                                         vc.week=model.week_start;
        
    [self.navigationController pushViewController:vc animated:NO];}];
       }
    }
                
}
            if (i==1) {
            for ( int a=0; a<self.weekTwoList.count; a++) {
                   ClassListModel   *  model=self.weekTwoList[a];
                  if ([model.section_from integerValue]==indexPath.row+1) {
                      
                      [UserInfoDefaults saveValue:[self.weekTwoList[0] valueForKey:@"section_from"]forKey:@"zhouer"];
                 _addImage.hidden=YES;
                 _classBgView.hidden=NO;
                _teacherName.text=model.title;
                _className.text=model.room;
                _grade.text=model.teacher;
               [_classBgView setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                                                                                                                   
               ClassDetailViewController  *  vc=[[ClassDetailViewController alloc]init];
               vc.id=model.id;
                                                                                                                       
                                                                                                                                                                                                                                                       vc.className=model.title;
                                                                                                                                                                                                                                                                                                 vc.teacher=model.teacher;
                                                                                                                                                                                                                                                                                                 vc.weeknum=model.section_from;
                                                                                                                       vc.weekSatrt=model.section_week;                                      vc.room=model.room;
                                                                                                                                                                                        vc.week=model.week_start;
               [self.navigationController pushViewController:vc animated:NO];}];
                  }
               }
                    
}
            if (i==2) {
            for ( int a=0; a<self.weekThreeList.count; a++) {
            ClassListModel   *  model=self.weekThreeList[a];
            if ([model.section_from integerValue]==indexPath.row+1) {
                  [UserInfoDefaults saveValue:[self.weekThreeList[0] valueForKey:@"section_from"]forKey:@"zhousan"];
            _addImage.hidden=YES;
            _classBgView.hidden=NO;
           _teacherName.text=model.title;
           _className.text=model.room;
           _grade.text=model.teacher;
                [_classBgView setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                                                                                                                       
                   ClassDetailViewController  *  vc=[[ClassDetailViewController alloc]init];
                   vc.id=model.id;
                                                                                                                           
                                                                                                                                                                                                                                                           vc.className=model.title;
                                                                                                                                                                                                                                                                                                     vc.teacher=model.teacher;
                                                                                                                                                                                                                                                                                                     vc.weeknum=model.section_from;
                                                                                                                           vc.weekSatrt=model.section_week;                                      vc.room=model.room;
                                                                                                                                                                                            vc.week=model.week_start;
                   [self.navigationController pushViewController:vc animated:NO];}];
                                                              
        }
    }

       
}
            if (i==3) {
             for ( int a=0; a<self.weekFourList.count; a++) {
                ClassListModel   *  model=self.weekFourList[a];
                if ([model.section_from integerValue]==indexPath.row+1) {
                      [UserInfoDefaults saveValue:[self.weekOneList[0] valueForKey:@"section_from"]forKey:@"zhousi"];
                _addImage.hidden=YES;
                _classBgView.hidden=NO;
                _teacherName.text=model.title;
                _className.text=model.room;
                _grade.text=model.teacher;
[_classBgView setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                                                                                                       
   ClassDetailViewController  *  vc=[[ClassDetailViewController alloc]init];
   vc.id=model.id;
                                                                                                           
                                                                                                                                                                                                                                           vc.className=model.title;
                                                                                                                                                                                                                                                                                     vc.teacher=model.teacher;
                                                                                                                                                                                                                                                                                     vc.weeknum=model.section_from;
                                                                                                           vc.weekSatrt=model.section_week;                                      vc.room=model.room;
                                                                                                                                                                            vc.week=model.week_start;
   [self.navigationController pushViewController:vc animated:NO];}];
                                                            
                }
             }
                 
                   }
            if (i==4) {
             
                      for ( int a=0; a<self.weekFiveList.count; a++) {
                         ClassListModel   *  model=self.weekFiveList[a];
                         if ([model.section_from integerValue]==indexPath.row+1) {
                               [UserInfoDefaults saveValue:[self.weekFiveList[0] valueForKey:@"section_from"]forKey:@"zhouwu"];
                                    _addImage.hidden=YES;
                                    _classBgView.hidden=NO;
                                    _teacherName.text=model.title;
                                    _className.text=model.room;
                                    _grade.text=model.teacher;
[_classBgView setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                                                                                                       
   ClassDetailViewController  *  vc=[[ClassDetailViewController alloc]init];
   vc.id=model.id;
                                                                                                           
                                                                                                                                                                                                                                           vc.className=model.title;
                                                                                                                                                                                                                                                                                     vc.teacher=model.teacher;
                                                                                                                                                                                                                                                                                     vc.weeknum=model.section_from;
                                                                                                           vc.weekSatrt=model.section_week;                                      vc.room=model.room;
                                                                                                                                                                            vc.week=model.week_start;
   [self.navigationController pushViewController:vc animated:NO];}];
                                                                      }
                        
                      }
                   }
            
        }
    
    
    return cell;
}

#pragma mark - lazy
- (CSBaseTableView *)tableView {
    
    if (!_tableView) {
        CGFloat a=IS_X?TABBAR_HEIGHT_X:TABBAR_HEIGHT;
        CSBaseTableView * tableView = [[CSBaseTableView alloc]initWithFrame:CGRectMake(0, 165*KScaleH, SCREEN_WIDTH, SCREEN_HEIGHT-165*KScaleH-a) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = (SCREEN_WIDTH -67.3*KScaleW)/5+6*KScaleH;
        tableView.backgroundColor=[UIColor whiteColor];
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.separatorColor=[UIColor clearColor];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}




-(void)selUn{
    UniverdsityListViewController   *  vc=[[UniverdsityListViewController alloc]init];
    vc.SchoolBlock = ^(NSString * _Nonnull school_id, NSString * _Nonnull school_name, NSString * _Nonnull major_id, NSString * _Nonnull major_name) {
        self.schoolLabel.text=school_name;
        [UserInfoDefaults saveValue:school_name forKey:@"school"];
    };
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}
-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList=[NSMutableArray array];
    }
    return _dataList;
}


-(void)changeUserInfoWithNickName:(NSString *)nickName sex:(NSString *)sex school_id:(NSString *)School_ID Major_ID:(NSString *)Major_ID Major_Item:(NSString *)major_Item{
    NSDictionary * dic=@{
        @"token":[UserInfoDefaults userInfo].token,
        @"nickname":nickName,
        @"sex":sex,
        @"school_id":School_ID,
        @"major_id":Major_ID,
        @"major_item":major_Item,
        @"real_name":@""
        
    };
    [HttpTools post:API_SAVE_USERINFO params:dic loading:NO success:^(id  _Nonnull json) {
        NSDictionary * dic=(NSDictionary *)json;
        NSLog(@"个人信息==%@",dic);
        if ([dic[@"code"] intValue]==1) {
            [self.view toast:@"修改成功"];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

@end
