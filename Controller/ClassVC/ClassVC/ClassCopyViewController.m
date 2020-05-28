//
//  ClassCopyViewController.m
//  ClassSchedule
//
//  Created by Superme on 2019/10/29.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "ClassCopyViewController.h"
#import "CSBaseTabbarController.h"
@interface ClassCopyViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField   *  tf;
@end

@implementation ClassCopyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self configUI];
    self.naviView.naviTitleLabel.text=@"导入课程表";
    
}

-(void)configUI{

    self.tf=[[UITextField alloc]initWithFrame:CGRectMake(30*KScaleW, self.naviView.bottom+8*KScaleH, SCREEN_WIDTH-60*KScaleW, 75*KScaleH)];
    [self.tf setRadius:37.5*KScaleH];
    self.tf.placeholder=@"填写复制码";
    UIView  *  leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 15*KScaleW, 75*KScaleH)];
    leftView.backgroundColor=[UIColor whiteColor];
    self.tf.leftView=leftView;
    self.tf.layer.borderColor=[UIColor colorWithHexString:@"#EBE9F0"].CGColor;
    self.tf.layer.borderWidth=0.67*KScaleW;
    self.tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.tf.leftViewMode = UITextFieldViewModeAlways;
    self.tf.delegate=self;
    [self.view addSubview:self.tf];
    
    
    UIButton   *  confirmBtn=[[UIButton alloc]initWithFrame:CGRectMake(22.5*KScaleW, self.tf.bottom+8*KScaleH, SCREEN_WIDTH-45*KScaleW, 65*KScaleH)];
    [confirmBtn setRadius:32*KScaleH];
//    confirmBtn.backgroundColor=[UIColor colorWithHexString:@"#FEC295"];
    [confirmBtn setBackgroundImage:[UIImage imageNamed:@"class_copy_bg"] forState:UIControlStateNormal];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font=[UIFont boldSystemFontOfSize:18*KScaleW];
    [confirmBtn setTitleColor:[UIColor colorWithHexString:@"#29675F"] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    
    
}
-(void)confirmBtn{
    if ([self.tf.text isEmpty]) {
        [self.view toast:@"请输入复制码"];
        return;
    }
    
    [ClassHandle copyClassWithToken:[UserInfoDefaults userInfo].token user_no:self.tf.text success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        NSLog(@"%@",obj);
        if ([dic[@"code"] intValue]==1) {
            CSBaseTabbarController  *  vc=[[CSBaseTabbarController alloc]init];
               [self.navigationController pushViewController:vc animated:NO];
        }else{
            [self.view toast:dic[@"msg"]];
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
   
}

@end
