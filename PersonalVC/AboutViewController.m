//
//  AboutViewController.m
//  ClassSchedule
//
//  Created by Superme on 2019/10/30.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.naviTitleLabel.text=@"关于我们";
    self.naviView.image.image=[UIImage imageNamed:@"personal_center_bg"]; ;
    [self configUI];
}

-(void)configUI{
    UIImageView  *  image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"555"]];
    image.frame=CGRectMake((SCREEN_WIDTH-153*KScaleW)/2, self.naviView.bottom+60*KScaleH, 153*KScaleW, 153*KScaleW);
    image.clipsToBounds=YES;
    [image setRadius:10.0*KScaleW];
    image.contentMode=UIViewContentModeScaleToFill;
    [self.view addSubview:image];
    
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, image.bottom+42*KScaleH, SCREEN_WIDTH, 15*KScaleH)];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:15*KScaleW];
    label.text=@"简单课程表V1.0.0";
    [self.view addSubview:label];
}

@end
