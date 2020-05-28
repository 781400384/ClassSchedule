//
//  FeedBackViewController.m
//  ClassSchedule
//
//  Created by Superme on 2019/10/30.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "FeedBackViewController.h"
#import "LYYTextView.h"
@interface FeedBackViewController ()<UITextViewDelegate>
@property (nonatomic, strong) LYYTextView *textView;
@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
   
    self.naviView.naviTitleLabel.text=@"意见反馈";
    self.naviView.rightTitleLabel.text=@"提交";
    self.naviView.image.image=[UIImage imageNamed:@"personal_center_bg"]; ;
    self.naviView.rightTitleLabel.textColor=[UIColor colorWithHexString:@"#f4e0e7"];
     self.view.backgroundColor=RGB(247, 244, 249);
    
    UIView   *   bgView=[[UIView alloc]initWithFrame:CGRectMake(30*KScaleW,self.naviView.bottom+8*KScaleH, SCREEN_WIDTH-60*KScaleW, 227*KScaleH)];
    bgView.backgroundColor=[UIColor whiteColor];
     [bgView setRadius:32*KScaleW];
    [self.view addSubview:bgView];
   _textView = [[LYYTextView alloc]initWithFrame:CGRectMake(24*KScaleW,24*KScaleH, bgView.width-48*KScaleW, bgView.height-24*KScaleW)];
    _textView.placeholder = @"请输入您的建议";
    _textView.backgroundColor=[UIColor whiteColor];
   
    _textView.font = [UIFont boldSystemFontOfSize:20.0];
        //对齐
    _textView.textAlignment = NSTextAlignmentLeft;
        //字体颜色
    _textView.textColor = [UIColor blackColor];
        //允许编辑
        _textView.editable = YES;
        //用户交互     ///////若想有滚动条 不能交互 上为No，下为Yes
        _textView.userInteractionEnabled = YES; ///
         _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应
        //自定义键盘
     _textView.scrollEnabled = YES;//滑动
        //textView.inputView = view;//自定义输入区域
        //textView.inputAccessoryView = view;//键盘上加view
        _textView.delegate = self;
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
          self.automaticallyAdjustsScrollViewInsets = NO;
      }
      
    [bgView addSubview:_textView];
}

-(void)rightTitleLabelTap{
    if ([_textView.text isEmpty]) {
        [self.view toast:@"请输入意见反馈信息"];
        return;
    }
    [ClassHandle feedBackWithToken:[UserInfoDefaults userInfo].token info:_textView.text success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==1) {
              [self.view toast:@"提交成功，感谢您的反馈"];
        }else{
             [self.view toast:@"提交失败"];
        }
     
    } failed:^(id  _Nonnull obj) {
        
    }];
}
 -(void)textViewDidChange:(UITextView *)textView{
    NSLog(@"已经修改");
    //自适应文本高度
    //计算文本的高度
    CGSize constraintSize;
    constraintSize.width = textView.frame.size.width-16;
    constraintSize.height = MAXFLOAT;
    CGSize sizeFrame =[textView.text sizeWithFont:textView.font
                                constrainedToSize:constraintSize
                                    lineBreakMode:UILineBreakModeWordWrap];

    //重新调整textView的高度
    textView.frame = CGRectMake(textView.frame.origin.x,textView.frame.origin.y,textView.frame.size.width,sizeFrame.height+5);
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
