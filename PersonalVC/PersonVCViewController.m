//
//  PersonVCViewController.m
//  ClassSchedule
//
//  Created by Superme on 2019/10/26.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "PersonVCViewController.h"
#import "LoginViewController.h"
#import "FeedBackViewController.h"
#import "AboutViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "UserInfoViewController.h"
#import "UserInfoModelTwo.h"
#import "CSWebViewController.h"
@interface PersonVCViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView     *    tableView;
@property (nonatomic, strong) NSArray         *    dataList;
@property (nonatomic, strong) UILabel         *    label;
@end

@implementation PersonVCViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: YES];
    [self getUserInfo];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.leftItemButton.hidden=YES;
    self.dataList=@[@"帮助与反馈",@"关于课程表",@"上课通知"];
    self.naviView.image.image=[UIImage imageNamed:@"personal_center_bg"]; ;
    self.view.backgroundColor=RGB(247, 244, 249);
    
   
}

-(void)getUserInfo{
    
    [ClassHandle getUserInfoDetailWithToken:[UserInfoDefaults userInfo].token success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
       
        NSLog(@"dicc==%@",dic);
        if ([dic[@"code"] intValue]==1) {
             UserInfoModelTwo  *  model=[UserInfoModelTwo mj_objectWithKeyValues:dic[@"data"]];
            if (model.user_no==nil) {
                NSLog(@"213");
                 [self changeUserInfoWithNickName:[UserInfoDefaults userInfo].nickname sex:@"1" school_id:@"1" Major_ID:@"1" Major_Item:@""];
            }else{
                [self configUI];
                self.label.text=dic[@"data"][@"user_no"];
                [UserInfoDefaults saveValue:[NSString stringWithFormat:@"%@",dic[@"data"][@"sex"]] forKey:@"sex"];
                [UserInfoDefaults saveValue:dic[@"data"][@"school_id"] forKey:@"school_id"];
                [UserInfoDefaults saveValue:dic[@"data"][@"major_id"] forKey:@"major_id"];
                [UserInfoDefaults saveValue:dic[@"data"][@"school"] forKey:@"school"];
                 [UserInfoDefaults saveValue:dic[@"data"][@"major"] forKey:@"major_name"];
                [UserInfoDefaults saveValue:dic[@"data"][@"major_item"] forKey:@"major_item"];
                [UserInfoDefaults saveValue:dic[@"data"][@"create_time"] forKey:@"create_time"];
                [UserInfoDefaults saveValue:[NSString stringWithFormat:@"%@",dic[@"data"][@"user_no"]] forKey:@"user_no"];




            }



        }
    } failed:^(id  _Nonnull obj) {
        NSLog(@"%@",obj);
    }];
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
    NSLog(@"个人信息==%@",dic);
    [HttpTools post:API_SAVE_USERINFO params:dic loading:NO success:^(id  _Nonnull json) {
        NSDictionary * dic=(NSDictionary *)json;
        NSLog(@"个人信息==%@",dic);
        if ([dic[@"code"] intValue]==1) {
            [self getUserInfo];
            [self.view toast:@"加载成功"];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
-(void)configUI{
    UIImageView    *  avatar=[[UIImageView  alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-57*KScaleW)/2, self.naviView.height-57*KScaleW-4*KScaleH, 57*KScaleW, 57*KScaleW)];
    [avatar sd_setImageWithURL:[NSURL URLWithString:[UserInfoDefaults userInfo].avatar] placeholderImage:[UIImage imageNamed:@"avatar_defau"]];

    avatar.clipsToBounds=YES;
    avatar.userInteractionEnabled=YES;
    
    UITapGestureRecognizer    *    tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userTarget)];
    [avatar addGestureRecognizer:tap];
    [avatar setRadius:26.5*KScaleW];
    [self.naviView addSubview:avatar];
    
    UIButton   *   num=[[UIButton alloc]initWithFrame:CGRectMake(22.5*KScaleW, self.tableView.bottom+8*KScaleH, SCREEN_WIDTH-45*KScaleW, 65*KScaleH)];
    num.backgroundColor=[UIColor whiteColor];
    [num setRadius:32.5*KScaleH];
    [num addTarget:self action:@selector(copyNum:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:num];
    
    UILabel *   label1=[[UILabel alloc]initWithFrame:CGRectMake(25*KScaleW, 0, (num.width-50*KScaleW)/2, num.height)];
    label1.text=@"复制码";
    label1.textAlignment=NSTextAlignmentLeft;
    label1.font=[UIFont boldSystemFontOfSize:13*KScaleW];
     label1.textColor=[UIColor colorWithHexString:@"#444444"];
    [num addSubview:label1];
    
    UILabel   *  label2=[[UILabel alloc]initWithFrame:CGRectMake(num.width/2, 0, (num.width-50*KScaleW)/2, num.height)];
       label2.text=[UserInfoDefaults valueForKey:@"user_no"];
       label2.textAlignment=NSTextAlignmentRight;
    self.label=label2;
label2.font=[UIFont boldSystemFontOfSize:13*KScaleW];
    label2.textColor=[UIColor colorWithHexString:@"#5E5E5B"];
       [num addSubview:label2];
    
    UIButton  *   btn =[[UIButton alloc]initWithFrame:CGRectMake(22.5*KScaleW, num.bottom+8*KScaleH, SCREEN_WIDTH-45*KScaleW, 65*KScaleH)];
    [btn setBackgroundImage:[UIImage imageNamed:@"logouty_bg"] forState:UIControlStateNormal];
    [btn setRadius:32.5*KScaleH];
    [btn setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"#29675F"] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont boldSystemFontOfSize:18*KScaleW];
    [btn addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
   
    [ClassHandle getImageWithId:@"3" success:^(id  _Nonnull obj) {
           
           NSDictionary  *  dic=(NSDictionary *)obj;
           if ([dic[@"code"] intValue]==1) {
               if ([dic[@"data"][@"url"] isEmpty]||[dic[@"data"][@"image"] isEmpty]) {
                   
               }else{
               CGFloat tabbar=IS_X?TABBAR_HEIGHT_X:TABBAR_HEIGHT;
              UIImageView  *   adv =[[UIImageView alloc]initWithFrame:CGRectMake(22.5*KScaleW,SCREEN_HEIGHT-tabbar-93*KScaleH , SCREEN_WIDTH-45*KScaleW, 87*KScaleH)];
                  [adv setRadius:32.5*KScaleH];
               [adv sd_setImageWithURL:dic[@"data"][@"image"]];
               adv.userInteractionEnabled=YES;
               adv.clipsToBounds=YES;
               adv.contentMode=UIViewContentModeScaleAspectFit;
               [self.view addSubview:adv];
               
               UITapGestureRecognizer   *  tap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
                              CSWebViewController  *  webVC=[[CSWebViewController alloc]init];
                              [self.navigationController pushViewController:webVC animated:YES];
                              webVC.linkUrl=[NSString stringWithFormat:@"%@",dic[@"data"][@"url"]];
                             
                          }];
                   [adv addGestureRecognizer:tap];
                   
               }
               
           }
           
       } failed:^(id  _Nonnull obj) {
           
       }];
    
    
    
 
    
    
    [self tableView];
}

-(void)userTarget{
    UserInfoViewController   *  vx=[[UserInfoViewController alloc]init];
    [self.navigationController pushViewController:vx animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    FeedBackViewController   *   vc1=[[FeedBackViewController alloc]init];
    AboutViewController      *   vc2=[[AboutViewController alloc]init];
    
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:vc1 animated:NO];
            break;
        case 1:
            [self.navigationController pushViewController:vc2 animated:NO];
            break;

        default:
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 61*KScaleH;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
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
        cell = [[ UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
   
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.text=self.dataList[indexPath.row];
    cell.textLabel.font=[UIFont boldSystemFontOfSize:13*KScaleW];
    cell.textLabel.textColor=[UIColor colorWithHexString:@"#444444"];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row==2) {
        
        UISwitch *mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 40*KScaleW, 20*KScaleH)];
       mySwitch.on = YES;
        if ([mySwitch isOn]) {
             [self startSendNoti];
        }else{
            [self removeAllNotification];
        }
       mySwitch.tintColor = [UIColor colorWithHexString:@"#f1c0c0"];
        mySwitch.onTintColor = [UIColor colorWithHexString:@"#29675f"];
        mySwitch.thumbTintColor = [UIColor whiteColor];
        [mySwitch addTarget:self action:@selector(valueChanged:) forControlEvents:(UIControlEventValueChanged)];
        [cell addSubview:mySwitch];
        cell.accessoryView=mySwitch;
//        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(void)valueChanged:(UISwitch *)valueChanged{
    if ([valueChanged isOn]) {
        [self startSendNoti];
    }else{
        [self removeAllNotification];
    }
}
-(void)startSendNoti{
    NSDate *nowDate = [NSDate date];
                             NSCalendar *calendar = [NSCalendar currentCalendar];
                             NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday  fromDate:nowDate];
                             // 获取今天是周几
                          NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

                             // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

                             [formatter setDateFormat:@"HH:mm"];

                             //现在时间,你可以输出来看下是什么格式

                             NSDate *datenow = [NSDate date];

                             //----------将nsdate按formatter格式转成nsstring

                             NSString *currentTimeString = [formatter stringFromDate:datenow];

                             NSLog(@"currentTimeString =  %@",currentTimeString);
                          
                          
                          NSInteger weekDay = [comp weekday];
    
                          NSString   *  str1=[UserInfoDefaults valueForKey:@"zhouyi"];
                          NSString   *  str2=[UserInfoDefaults valueForKey:@"zhouer"];
                          NSString   *  str3=[UserInfoDefaults valueForKey:@"zhousan"];
                          NSString   *  str4=[UserInfoDefaults valueForKey:@"zhousi"];
                          NSString   *  str5=[UserInfoDefaults valueForKey:@"zhouwu"];
                          NSMutableArray   *    arr=[UserInfoDefaults valueForKey:@"timeArr"];
    if (arr.count==0) {
        [self.view toast:@"通知已开启,请添加课程"];
    }else{
                          if (weekDay==2) {
                              if ([str1 isEmpty]) {
                                  return ;
                              }
                              
                               NSInteger    a=[str1 integerValue];
                              

                              NSTimeInterval    abc=[self pleaseInsertStarTime:currentTimeString andInsertEndTime:[NSString stringWithFormat:@"%@",arr[a]]];
                             
                              if (abc==10) {
                                  [self sendNotificationMessage];
                              }
                                  
                              }
                         
                          if (weekDay==3) {
                              if ([str2 isEmpty]) {
                                  return ;
                              }
                              NSInteger    a=[str2 integerValue];
                              NSTimeInterval    abc=[self pleaseInsertStarTime:currentTimeString andInsertEndTime:[NSString stringWithFormat:@"%@",arr[a]]];

                              if (abc==10) {
                                  [self sendNotificationMessage];
                              }
                                  
                            
                          }
                             if (weekDay==4) {
                                 if (str3==nil) {
                                     return ;
                                 }
                                 NSInteger    a=[str3 integerValue];
                                 NSTimeInterval    abc=[self pleaseInsertStarTime:currentTimeString andInsertEndTime:[NSString stringWithFormat:@"%@",arr[a]]];

                                 if (abc==10) {
                                     [self sendNotificationMessage];
                                 }

                                
                             }
                          if (weekDay==5) {
                              if ([str4 isEmpty]) {
                                  return ;
                              }
                              NSInteger    a=[str4 integerValue];
                              NSTimeInterval    abc=[self pleaseInsertStarTime:currentTimeString andInsertEndTime:[NSString stringWithFormat:@"%@",arr[a]]];

                              if (abc==10) {
                                  [self sendNotificationMessage];
                              }
                                  
                             
                          }
                          if (weekDay==6) {
                              if ([str5 isEmpty]) {
                                  return ;
                              }
                              NSInteger    a=[str5 integerValue];
                              NSTimeInterval    abc=[self pleaseInsertStarTime:currentTimeString andInsertEndTime:[NSString stringWithFormat:@"%@",arr[a]]];

                              if (abc==10) {
                                  [self sendNotificationMessage];
                              }
                             
                              
                          }
        
    }
}
-(UITableView *)tableView{
    if (!_tableView) {
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(30*KScaleW, self.naviView.bottom+8*KScaleH, SCREEN_WIDTH-60*KScaleW, 183*KScaleH) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
//        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.separatorColor=RGB(244, 244, 244);
        [tableView setRadius:34.5*KScaleW];
        tableView.backgroundColor=[UIColor whiteColor];;
        [self.view addSubview:tableView];
        _tableView=tableView;
    }
    return _tableView;
}
-(void)logout:(UIButton *)sender{
  
    [UserInfoDefaults logoutUserInfo];
    LoginViewController  *  vc=[[LoginViewController alloc]init];
    NSUserDefaults   *     defaults=[NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"termsDic"];
    [UserInfoDefaults removeUserDefaultForKey:@"maxSections"];
    [UserInfoDefaults removeUserDefaultForKey:@"sex"];
    [UserInfoDefaults removeUserDefaultForKey:@"school_id"];
    [UserInfoDefaults removeUserDefaultForKey:@"major_id"];
    [UserInfoDefaults removeUserDefaultForKey:@"major_item"];
    [UserInfoDefaults removeUserDefaultForKey:@"create_time"];
    [UserInfoDefaults removeUserDefaultForKey:@"school"];
    [UserInfoDefaults removeUserDefaultForKey:@"major_name"];
    [UserInfoDefaults removeUserDefaultForKey:@"user_no"];
    [UserInfoDefaults removeUserDefaultForKey:@"timeArr"];
    [UserInfoDefaults removeUserDefaultForKey:@"zhouyi"];
    [UserInfoDefaults removeUserDefaultForKey:@"zhouer"];
    [UserInfoDefaults removeUserDefaultForKey:@"zhousan"];
    [UserInfoDefaults removeUserDefaultForKey:@"zhousi"];
    [UserInfoDefaults removeUserDefaultForKey:@"zhouwu"];
    [self.tableView reloadData];
    [self.navigationController pushViewController:vc animated:NO];
}
-(void)copyNum:(UIButton *)sender{
    [self.view toast:@"复制成功"];
    if ([[UserInfoDefaults valueForKey:@"user_no"] isEmpty]) {
          [self.view toast:@"请获取复制码"];
        return;
    }
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string =[UserInfoDefaults valueForKey:@"user_no"];

}






- (void)sendNotificationMessage{
    
if (@available(iOS 10.0,*)) {
    // 通知中心
    UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
    // 通知内容
    UNMutableNotificationContent * content = [[UNMutableNotificationContent alloc]init];
//    content.title = @"简单课程表";
//    content.subtitle = @"通知子标题";
    content.body = @"第一节课快开始啦！";
    // 默认铃声
    content.sound = [UNNotificationSound defaultSound];
    // 自定义铃声
    content.sound = [UNNotificationSound soundNamed:@"Define_Sound"];
    // 角标
    content.badge = @10;
    // 设置多长时间之后发送
    
    
    
    NSTimeInterval time = [[NSDate dateWithTimeIntervalSinceNow:1] timeIntervalSinceNow];
    UNTimeIntervalNotificationTrigger * trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:time repeats:NO];
    
    // id：便于以后移除、更新 指定通知
    NSString * noticeId = @"noticeId";
    // 通知请求
    UNNotificationRequest * request = [UNNotificationRequest requestWithIdentifier:noticeId content:content trigger:trigger];
    // 添加通知请求
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"本地推送成功");
        }
    }];
    
}else{
    UILocalNotification * locationNotice = [[UILocalNotification alloc]init];
    // 发送时间
    locationNotice.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
    // 通知内容
    locationNotice.alertBody = @"第一节课快开始啦";
    locationNotice.userInfo = @{@"json":@"第一节课快开始啦",@"NoticeID":@"123"};
    // 角标
    locationNotice.applicationIconBadgeNumber = 1;
    // 默认铃声
    locationNotice.soundName = UILocalNotificationDefaultSoundName;
    // 循环提醒
    locationNotice.repeatInterval = kCFCalendarUnitMinute;
    // 发送
    [[UIApplication sharedApplication] scheduleLocalNotification:locationNotice];
}
    
}
#pragma mark -- 检测通知 开关状态
- (void)checkNotificationSwitchState{
    if (@available(iOS 10.0,*)) {
        UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.notificationCenterSetting == UNNotificationSettingEnabled) {
                NSLog(@"通知权限开启");
            }else{
                NSLog(@"通知权限关闭");
            }
        }];
    }else{
        UIUserNotificationSettings * settings = [[UIApplication sharedApplication] currentUserNotificationSettings];
        
        if (settings.types == UIUserNotificationTypeNone) {
            NSLog(@"通知权限关闭");
        }else{
            NSLog(@"通知权限开启");
        }
        
    }
}
#pragma mark -- 移除某个通知
-(void)removeNoticeWithNoticeId:(NSString *)noticeID{
    if (@available(iOS 10.0,*)) {
        
        UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
        // 判断noticeID是否存在
        [center getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
        
            for (UNNotificationRequest * request in requests) {
                if([noticeID isEqualToString:request.identifier]){
                    [center removePendingNotificationRequestsWithIdentifiers:@[noticeID]];
                }
            }
            
        }];
        
    }else{
        // 获取scheduled中的通知
        NSArray * scheduledArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
        
        for (UILocalNotification * localNotice in scheduledArray) {
            NSDictionary * userInfo = localNotice.userInfo;
            NSString * userNoticeID = [userInfo objectForKey:@"NoticeID"];
            if ([userNoticeID isEqualToString:noticeID]) {
                [[UIApplication sharedApplication] cancelLocalNotification:localNotice];
            }
        }
    }
}
#pragma mark -- 移除所有通知
- (void)removeAllNotification{
    if (@available(iOS 10.0,*)) {
        UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
        [center removeAllPendingNotificationRequests];
    }else{
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
}

- (NSTimeInterval)pleaseInsertStarTime:(NSString *)starTime andInsertEndTime:(NSString *)endTime{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"mm:ss"];//根据自己的需求定义格式
    NSDate* startDate = [formater dateFromString:starTime];
    NSDate* endDate = [formater dateFromString:endTime];
    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    return time;
}





@end
