//
//  CSBaseViewController.m
//  ClassSchedule
//
//  Created by Superme on 2019/10/26.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "CSBaseViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "AppDelegate.h"

@interface CSBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation CSBaseViewController
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
//    if ([SVProgressHUD isVisible]) {
//        [SVProgressHUD dismiss];
//    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;
}
- (void)viewDidAppear:(BOOL)animated

{

    [super viewDidAppear:animated];

    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {self.navigationController.interactivePopGestureRecognizer.delegate =self;

    }

}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer

{

    return NO;

}
#pragma mark - UI

- (void)initUI{
    
    [self.view addSubview:self.naviView];
    [self.naviView.leftItemButton addTarget:self action:@selector(leftDismiss) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightTitleLabelTap)];
    [self.naviView.rightTitleLabel addGestureRecognizer:tap];
}
#pragma mark - UI event

- (void)rightTitleLabelTap {
    
}

- (void)leftDismiss {
    
    if (self.navigationController.topViewController == self) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)showLeftItemButton:(BOOL)show {
    
    self.naviView.leftItemButton.hidden = !show;
}
- (void)showRightItemButton:(BOOL)show{
    
    self.naviView.rightItemButton.hidden = !show;
}

#pragma mark - lazy

-(CSNaview *)naviView {
    
    if (!_naviView) {
        CGFloat height = IS_X ? NAVI_HEIGHT_X : NAVI_HEIGHT;
        _naviView = [[CSNaview alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height+39*KScaleH)];
//        _naviView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"class_copy"]]; ;
    }
    return _naviView;
}


@end
