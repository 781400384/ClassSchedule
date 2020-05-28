//
//  ADVAlertView.m
//  ClassSchedule
//
//  Created by 纪明 on 2019/11/21.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "ADVAlertView.h"
@interface ADVAlertView()
@property (nonatomic, strong) UIView *alertView;

@property (nonatomic, strong) UIImageView *imageView;
@end
@implementation ADVAlertView

-(instancetype)initWithImage:(NSString *)imageName {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        
        self.alertView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.alertView.center = self.center;
        [self addSubview:self.alertView];
        CAGradientLayer *gl = [CAGradientLayer layer];
           gl.frame = CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
           gl.startPoint = CGPointMake(0, 0);
           gl.endPoint = CGPointMake(1, 1);
           gl.colors = @[(__bridge id)[UIColor colorWithRed:244/255.0 green:224/255.0 blue:231/255.0 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithRed:254/255.0 green:194/255.0 blue:149/255.0 alpha:0.8].CGColor];
           gl.locations = @[@(0.0),@(1.0f)];

           [self.alertView.layer addSublayer:gl];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.imageView.center=self.center;
        self.imageView.contentMode=UIViewContentModeScaleAspectFit;
        self.imageView.userInteractionEnabled=YES;
        self.imageView.clipsToBounds=YES;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@""]];
        [self.alertView addSubview:self.imageView];
        
        UIButton  *  closeBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-70*KScaleW, 192*KScaleH, 23*KScaleW, 23*KScaleW)];
        [closeBtn setBackgroundImage:[UIImage imageNamed:@"alert_close"] forState:UIControlStateNormal];
        [self.imageView addSubview:closeBtn];
        [closeBtn addTarget:self action:@selector(hideAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

-(void)hideAction:(UIButton *)sender{
    [self dismissAlertView];
}
- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor clearColor];
        _alertView.layer.masksToBounds = YES;
        _alertView.layer.cornerRadius = 5;
        _alertView.userInteractionEnabled = YES;
      
       
    }
    return _alertView;
}

- (void)showView {
    self.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    
    self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.2,0.2);
    self.alertView.alpha = 0;
    [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        self.alertView.transform = transform;
        self.alertView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dismissAlertView {
     [self removeFromSuperview];
}


@end
