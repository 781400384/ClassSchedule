//
//  LuanchViewController.m
//  ClassSchedule
//
//  Created by Superme on 2019/11/5.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "LuanchViewController.h"
#import "CSBaseTabbarController.h"
#import "LoginViewController.h"
#import "FLAnimatedImageView.h"
#import "FLAnimatedImageView+WebCache.h"
@interface LuanchViewController (){
    // 判断是否是第一次进入应用
    BOOL flag;
}


@end

@implementation LuanchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addLaunch];
    
    NSLog(@"11");
}

- (void)addLaunch {

    UIImageView  *   bgImage=[[UIImageView alloc]init];
    if (IS_X) {
        bgImage.image=[UIImage imageNamed:@"x_luanch_bg"];
    }else{
         bgImage.image=[UIImage imageNamed:@"luanch_bg"];
    }
    bgImage.userInteractionEnabled=YES;
    bgImage.clipsToBounds=YES;
    bgImage.contentMode=UIViewContentModeScaleToFill;
    bgImage.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:bgImage];
    
  
    UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    for (int i=0; i<4; i++) {
        
       
        
        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        if (i == 3) {
            imageView.userInteractionEnabled = YES;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//            button.center = CGPointMake(self.view.center.x, self.view.center.y+220*KScaleH);
//            button.bounds = CGRectMake(0, SCREEN_HEIGHT-142*KScaleH, 130, 32);
            button.frame=CGRectMake((SCREEN_WIDTH-130*KScaleW)/2, SCREEN_HEIGHT-142*KScaleH, 130*KScaleW, 32*KScaleH);
            [button setTitle:@"立即体验" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.layer.cornerRadius = 16*KScaleW;
            button.titleLabel.font=[UIFont systemFontOfSize:13*KScaleW];
            button.clipsToBounds = YES;
            button.backgroundColor=[UIColor colorWithHexString:@"#3F3166"];
            [button addTarget:self action:@selector(goMain) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
        }
        if (IS_X) {
             NSURL   *   imageUrl=[[NSBundle mainBundle]URLForResource:[NSString stringWithFormat:@"x_luanch_%d",i+1] withExtension:@"gif"];
            FLAnimatedImage *animatedImg = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:imageUrl]];
                 imageView.animatedImage=animatedImg;
        }else{
             NSURL   *   imageUrl=[[NSBundle mainBundle]URLForResource:[NSString stringWithFormat:@"luanch_%d",i+1] withExtension:@"gif"];
            FLAnimatedImage *animatedImg = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:imageUrl]];
                 imageView.animatedImage=animatedImg;
        }
        [myScrollView addSubview:imageView];
    }
    
    myScrollView.bounces = NO;
    myScrollView.pagingEnabled = YES;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 4, SCREEN_HEIGHT);
    [bgImage addSubview:myScrollView];
    

}


- (void) goMain{
    flag = YES;
    NSUserDefaults *useDef = [NSUserDefaults standardUserDefaults];
    [useDef setBool:flag forKey:@"notFirst"];
    [useDef synchronize];
    
    LoginViewController *main = [[LoginViewController alloc]init];
      CSBaseNavigationViewController  *  nav=[[CSBaseNavigationViewController alloc]initWithRootViewController:main];
    self.view.window.rootViewController = nav;
}



@end
