//
//  CSBaseTabbarController.m
//  ClassSchedule
//
//  Created by Superme on 2019/10/26.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "CSBaseTabbarController.h"
#import "ClassVCViewController.h"
#import "PersonVCViewController.h"
@interface CSBaseTabbarController ()

@end

@implementation CSBaseTabbarController

+(void)initialize
{
    //设置未选中的TabBarItem的字体颜色、大小
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12*KScaleW];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    //设置选中了的TabBarItem的字体颜色、大小
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12*KScaleW];
    selectedAttrs[NSForegroundColorAttributeName] = APP_OTHER_COLOR;
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat tabbar_height = IS_X ? TABBAR_HEIGHT_X : TABBAR_HEIGHT;
    UIView *TabBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, tabbar_height)];
    TabBarView.backgroundColor = [UIColor whiteColor];
//    [TabBarView setRadius:tabbar_height/2];
    [self.tabBar addSubview:TabBarView];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
  
  
    [self setUpAllChildVc];
}
- (void)setUpAllChildVc
{
    [self setupChildVc:[[ClassVCViewController alloc] init] title:@"课程表" image:@"class_nor" selectedImage:@"class_sel"];
    
    [self setupChildVc:[[PersonVCViewController alloc] init] title:@"个人中心" image:@"person_nor" selectedImage:@"person_sel"];
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.title = title;
    if (image || selectedImage) {
        vc.tabBarItem.image = [UIImage imageNamed:image];
        UIImage *selectImage = [UIImage imageNamed:selectedImage];
        vc.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    
   CSBaseNavigationViewController *nav = [[CSBaseNavigationViewController alloc] initWithRootViewController:vc];
   
    [self addChildViewController:nav];
}


@end
