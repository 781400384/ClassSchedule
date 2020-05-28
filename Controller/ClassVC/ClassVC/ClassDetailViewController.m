//
//  ClassDetailViewController.m
//  ClassSchedule
//
//  Created by Superme on 2019/10/30.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "ClassDetailViewController.h"
#import "SelClassViewController.h"
@interface ClassDetailViewController ()
@property (nonatomic, strong) NSArray     *    array;
@end

@implementation ClassDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.naviTitleLabel.text=@"课程详情";
    self.naviView.image.image=[UIImage imageNamed:@"class_aaa_bg"]; ;
    self.view.backgroundColor=RGB(247, 244, 249);
    self.array=@[@"class_detail_class",@"class_detail_week",@"class_detail_num",@"class_detail_teacher"];
    [self configUI];
   
}

-(void)configUI{
    UIView   *  bgView=[[UIView alloc]initWithFrame:CGRectMake(30*KScaleW, self.naviView.bottom+8*KScaleH, SCREEN_WIDTH-60*KScaleW, 195*KScaleH)];
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.clipsToBounds=YES;
    bgView.userInteractionEnabled=YES;
    [bgView setRadius:37*KScaleW];
    [self.view addSubview:bgView];
    
    UILabel   *   titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(23.33*KScaleW, 28.67*KScaleH, bgView.width-86.66*KScaleW, 15*KScaleH)];
    titleLabel.textAlignment=NSTextAlignmentLeft;
    titleLabel.font=[UIFont boldSystemFontOfSize:18*KScaleW];
    titleLabel.text=self.title;
    [bgView addSubview:titleLabel];
    UIButton  *   editBtn=[[UIButton alloc]initWithFrame:CGRectMake(bgView.width-86.66*KScaleW, 25*KScaleH, 63.33*KScaleW, 22.93*KScaleH)];
    editBtn.backgroundColor=[UIColor colorWithHexString:@"#29675F"];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitleColor:[UIColor colorWithHexString:@"#F4E0E7"] forState:UIControlStateNormal];
    editBtn.titleLabel.font=[UIFont systemFontOfSize:13*KScaleW];
    [editBtn setRadius:11*KScaleW];
    [editBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:editBtn];
    
    for (int i=0; i<4; i++) {
        UIImageView   *  image=[[UIImageView alloc]initWithFrame:CGRectMake(23.67*KScaleW, titleLabel.bottom+20*KScaleH+30*KScaleH*i, 13.67*KScaleW, 13.67*KScaleW)];
        image.image=[UIImage imageNamed:self.array[i]];
        image.contentMode=UIViewContentModeScaleToFill;
        image.clipsToBounds=YES;
        [bgView addSubview:image];
        
        UILabel   *   label=[[UILabel alloc]initWithFrame:CGRectMake(image.right+7*KScaleW, titleLabel.bottom+20*KScaleH+29.67*KScaleH*i, 40*KScaleW, 14*KScaleH)];
        label.font=[UIFont systemFontOfSize:14*KScaleW];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=[UIColor colorWithHexString:@"#A4A4A4"];
        label.text=@[@"教室",@"周数",@"节数",@"老师"][i];
        [bgView addSubview:label];
        
        UILabel  *  detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(label.right+24.67*KScaleW, titleLabel.bottom+20*KScaleH+29.67*KScaleH*i, bgView.width-85*KScaleW, 14*KScaleH)];
        detailLabel.textAlignment=NSTextAlignmentLeft;
        detailLabel.font=[UIFont boldSystemFontOfSize:13*KScaleW];
        detailLabel.textColor=[UIColor colorWithHexString:@"#5E5E5B"];
        detailLabel.text=@[self.room,[NSString stringWithFormat:@"%@周",self.weeknum],self.week,self.teacher][i];
        [bgView addSubview:detailLabel];
    }
    
}
-(void)edit{
    SelClassViewController    *  vc=[[SelClassViewController alloc]init];
    vc.classType=@"1";
    vc.class_id=self.id;
    vc.naviView.naviTitleLabel.text=@"编辑课程";
    vc.className=self.className;
    vc.roomName=self.room;
    vc.weekNum=self.week;
    vc.sectionRoom=self.weeknum;
    vc.weekStart=self.weekSatrt;
    vc.teachername=self.teacher;
    [self.navigationController pushViewController:vc animated:NO];
}
@end
