//
//  CSNaview.m
//  ClassSchedule
//
//  Created by Superme on 2019/10/25.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "CSNaview.h"

@implementation CSNaview

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.image];
    [self.image addSubview:self.leftItemButton];
    [self.image addSubview:self.naviTitleLabel];
    [self.image addSubview:self.rightItemButton];
    [self.image addSubview:self.rightTitleLabel];
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(self.width);
        make.height.mas_equalTo(self.height);
    }];
    [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(@(-15*KScaleW));
        make.centerY.equalTo(self.naviTitleLabel);
    }];
  
    
}

- (UIButton *)leftItemButton {
    
    if (!_leftItemButton) {
        CGFloat y = IS_X ? NAVI_SUBVIEW_Y_iphoneX : NAVI_SUBVIEW_Y_Normal;
        _leftItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftItemButton.frame = CGRectMake(0, y, 60, self.height-y-39*KScaleH);
        _leftItemButton.titleLabel.font = [UIFont systemFontOfSize:18*KScaleW];
        [_leftItemButton setImage:[UIImage imageNamed:@"navi_back"] forState:UIControlStateNormal];
        [_leftItemButton setTitleColor:APP_COLOR forState:UIControlStateNormal];
    }
    return _leftItemButton;
}
- (UIButton *)rightItemButton {
    
    if (!_rightItemButton) {
        CGFloat y = IS_X ? NAVI_SUBVIEW_Y_iphoneX : NAVI_SUBVIEW_Y_Normal;
        _rightItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightItemButton.frame = CGRectMake(SCREEN_WIDTH-70, y, 65, self.height-y-39*KScaleH);
        _rightItemButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightItemButton setTitleColor:APP_COLOR forState:UIControlStateNormal];
    }
    return _rightItemButton;
}

- (UILabel *)rightTitleLabel {
    
    if (!_rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc]init];
        _rightTitleLabel.font = [UIFont boldSystemFontOfSize:18*KScaleW];
        _rightTitleLabel.textAlignment = NSTextAlignmentRight;
        [_rightTitleLabel sizeToFit];
        _rightTitleLabel.userInteractionEnabled = YES;
    }
    return _rightTitleLabel;
}

- (UILabel *)naviTitleLabel {
    
    if (!_naviTitleLabel) {
        
        CGFloat y = IS_X ? NAVI_SUBVIEW_Y_iphoneX : NAVI_SUBVIEW_Y_Normal;
        _naviTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.leftItemButton.right+10, y, SCREEN_WIDTH-self.leftItemButton.width*2-10*2, self.height-y-39*KScaleH)];
        _naviTitleLabel.textAlignment = NSTextAlignmentCenter;
        _naviTitleLabel.textColor = APP_COLOR;
        _naviTitleLabel.font = [UIFont boldSystemFontOfSize:20];
    }
    return _naviTitleLabel;
}
-(UIImageView *)image{
    if (!_image) {
        _image=[[UIImageView alloc]init];
        _image.userInteractionEnabled=YES;
        _image.contentMode=UIViewContentModeScaleToFill;
        _image.clipsToBounds=YES;
        _image.image=[UIImage imageNamed:@"class_copy"];
    }
    return _image;
}
@end
