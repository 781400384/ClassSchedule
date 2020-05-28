//
//  LoginViewController.m
//  ClassSchedule
//
//  Created by Superme on 2019/10/29.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "LoginViewController.h"
#import "ClassCopyViewController.h"
#import "DWDirectionPanGestureRecognizer.h"
#import "DWPopView.h"
#import "CSBaseTabbarController.h"

#import "UserInfoModel.h"
@interface LoginViewController ()<WXApiDelegate,WXApiLogDelegate>
@property (nonatomic,strong) DWPopView *myPopView;
@property (nonatomic, strong) NSDictionary    *  dictionary;
@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.hidden=YES;
    [self configUI];
    self.view.backgroundColor=[UIColor whiteColor];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WXLoginNoti:) name:CSWXLoginNotification object:nil];
   
}
- (void)dealloc {

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)configUI{
   
    UIImageView *  bgImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (IS_X) {
        bgImg.image=[UIImage imageNamed:@"x_baseBg"];
    }else{
        bgImg.image=[UIImage imageNamed:@"base_bg"];
        
    }
    bgImg.clipsToBounds=YES;
    bgImg.contentMode=UIViewContentModeScaleToFill;
    bgImg.userInteractionEnabled=YES;
    [self.view addSubview:bgImg];
    
    
    UIButton  *    wxBtn=[[UIButton alloc]initWithFrame:CGRectMake(23*KScaleW, SCREEN_HEIGHT-207*KScaleW, SCREEN_WIDTH-46*KScaleW, 64*KScaleH)];

    [wxBtn setBackgroundImage:[UIImage imageNamed:@"wx_bg"] forState:UIControlStateNormal];
       wxBtn.titleLabel.font=[UIFont boldSystemFontOfSize:18*KScaleW];
       [wxBtn setImage:[UIImage imageNamed:@"login_wx"] forState:UIControlStateNormal];
       [wxBtn setTitle:@"微信登录" forState:UIControlStateNormal];
       [wxBtn setTitleColor:[UIColor colorWithHexString:@"#29675F"] forState:UIControlStateNormal];
       [wxBtn setRadius:32*KScaleH];
      wxBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10*KScaleW, 0, 0);
      wxBtn.titleEdgeInsets = UIEdgeInsetsMake(0,10*KScaleW, 0, 0);
       [wxBtn addTarget:self action:@selector(wxLogin) forControlEvents:UIControlEventTouchUpInside];
       [bgImg addSubview:wxBtn];
    UIButton  *    customerBtn=[[UIButton alloc]initWithFrame:CGRectMake(23*KScaleW,wxBtn.bottom+11*KScaleH, SCREEN_WIDTH-46*KScaleW,64*KScaleH)];
    [customerBtn setBackgroundImage:[UIImage imageNamed:@"customer_bg"] forState:UIControlStateNormal];
    customerBtn.titleLabel.font=[UIFont boldSystemFontOfSize:18*KScaleW];
    [customerBtn setImage:[UIImage imageNamed:@"login_customer"] forState:UIControlStateNormal];
    [customerBtn setTitle:@"游客登录" forState:UIControlStateNormal];
    [customerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customerBtn setRadius:32*KScaleH];
    customerBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10*KScaleW, 0, 0);
         customerBtn.titleEdgeInsets = UIEdgeInsetsMake(0,10*KScaleW, 0, 0);
    [customerBtn addTarget:self action:@selector(customerLogin) forControlEvents:UIControlEventTouchUpInside];
    [bgImg addSubview:customerBtn];
    
    _myPopView = [[DWPopView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH,294*KScaleH)];
    _myPopView.backgroundColor = [UIColor clearColor];
    [bgImg addSubview:self.myPopView];
    UIImageView  *  loginBg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_bg"]];
    loginBg.clipsToBounds=YES;
    loginBg.userInteractionEnabled=YES;
    loginBg.frame=CGRectMake(0, 0, SCREEN_WIDTH, 294*KScaleH);
    [self.myPopView addSubview:loginBg];
    
    
    UIButton  *  createBtn=[[UIButton alloc]initWithFrame:CGRectMake(39.5*KScaleW, 74*KScaleH, 109*KScaleW, 147.5*KScaleH)];
    [createBtn setBackgroundImage:[UIImage imageNamed:@"sel_creat"] forState:UIControlStateNormal];
    [createBtn addTarget:self action:@selector(createBtn) forControlEvents:UIControlEventTouchUpInside];
    [loginBg addSubview:createBtn];
    
    UIButton  *  copyBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-148.5*KScaleW, 74*KScaleH, 109*KScaleW, 147.5*KScaleH)];
       [copyBtn setBackgroundImage:[UIImage imageNamed:@"sel_copy"] forState:UIControlStateNormal];
       [copyBtn addTarget:self action:@selector(copyBtn) forControlEvents:UIControlEventTouchUpInside];
       [loginBg addSubview:copyBtn];
}
#pragma mark - 游客登录
-(void)customerLogin{


    [ClassHandle loginWithCode:[self getRandomStr] bundle_name:[NSString getBundleIdentifier] version:[NSString getVersion] sys:@"1" channel:@"appstore" identification:@"1" type:@"phone" uuid:[NSString getDeviceUUID] success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==1) {
            [self.myPopView dw_popView];
            self.dictionary=dic;
        }
        NSLog(@"obj==%@",obj);
    } failed:^(id  _Nonnull obj) {
            
        [self.view toast:@"登录失败"];
    }];
}
-(void)wxLogin{
   
    if ([WXApi isWXAppInstalled]) {
           SendAuthReq * req=[[SendAuthReq alloc]init];
           req.scope=@"snsapi_userinfo";
           req.state=@"ClassSchedule";
      
        [WXApi sendAuthReq:req
            viewController:self
                  delegate:self
                completion:nil];
       }else{


       }
}
-(void)WXLoginNoti:(NSNotification *)wxLogin{
 
    NSLog(@"asa=%@",wxLogin);
    NSDictionary * code=[wxLogin userInfo];
    NSString * str=[code objectForKey:@"code"];
    [ClassHandle loginWithCode:str bundle_name:[NSString getBundleIdentifier] version:[NSString getVersion] sys:@"1" channel:@"appstore" identification:@"0" type:@"phone" uuid:[NSString getDeviceUUID] success:^(id  _Nonnull obj) {
           NSDictionary * dic=(NSDictionary *)obj;
    NSLog(@"dic==%@",dic);
           if ([dic[@"code"] intValue]==1) {
               [self.myPopView dw_popView];
               self.dictionary=dic;
           }
       } failed:^(id  _Nonnull obj) {
               
           [self.view toast:@"登录失败"];
       }];
}
-(void)createBtn{
    [self.myPopView dw_dismissView];
    
    [self saveModel];
    
    CSBaseTabbarController  *  vc=[[CSBaseTabbarController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}
-(void)copyBtn{
    [self.myPopView dw_dismissView];
    [self saveModel];
    CSBaseViewController *vc = [[NSClassFromString(@"ClassCopyViewController") alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
     
}
-(void)saveModel{
    UserInfoModel  *  model=[UserInfoModel mj_objectWithKeyValues:self.dictionary[@"data"]];
                [UserInfoDefaults  saveUserInfo:model];
    
     
}
-(NSString *)getRandomStr
{
    char data[10];
    
    for (int x=0;x < 10;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    NSString *randomStr = [[NSString alloc] initWithBytes:data length:10 encoding:NSUTF8StringEncoding];


    NSString *string = [NSString stringWithFormat:@"%@",randomStr];


    NSLog(@"获取随机字符串 %@",string);


    return string;
    
}


@end
