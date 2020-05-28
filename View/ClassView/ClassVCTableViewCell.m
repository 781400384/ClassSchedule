//
//  ClassVCTableViewCell.m
//  ClassSchedule
//
//  Created by Superme on 2019/10/29.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "ClassVCTableViewCell.h"
@interface ClassVCTableViewCell()
@end
@implementation ClassVCTableViewCell
-(void)layoutSubviews{
    [self addSubview:self.timeBgView];
    [self.timeBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(27.3*KScaleW);
        make.height.mas_equalTo(self.height);
    }];
    [self.timeBgView addSubview:self.num];
    [self.num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(18*KScaleH);
        make.centerX.mas_equalTo(self.timeBgView.mas_centerX);
    }];
    [self.timeBgView addSubview:self.startTime];
    [self.startTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.num.mas_bottom).offset(4.33*KScaleH);
        make.centerX.mas_equalTo(self.timeBgView.mas_centerX);
    }];
    [self.timeBgView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.startTime.mas_bottom).offset(4*KScaleH);
        make.centerX.mas_equalTo(self.timeBgView.mas_centerX);
        make.width.mas_equalTo(0.67*KScaleW);
        make.height.mas_equalTo(4.67*KScaleH);
    }];
    [self.timeBgView addSubview:self.endTime];
    [self.endTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(4*KScaleH);
        make.centerX.mas_equalTo(self.timeBgView.mas_centerX);
    }];
    
    [self.timeBgView addSubview:self.shortLine];
    [self.shortLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.67*KScaleH);
        make.width.mas_equalTo(4.67*KScaleW);
        make.centerX.mas_equalTo(self.timeBgView.mas_centerX);
    }];

}
-(UILabel *)num{
    if (!_num) {
        _num=[[UILabel alloc]init];
        _num.font=[UIFont systemFontOfSize:7*KScaleW];
        _num.textColor=[UIColor colorWithHexString:@"#A4A4A4"];
        _num.textAlignment=NSTextAlignmentCenter;
       
    }
    return _num;
}
-(UILabel *)startTime{
    if (!_startTime) {
        _startTime=[[UILabel alloc]init];
        _startTime.font=[UIFont boldSystemFontOfSize:8*KScaleW];
        _startTime.textColor=[UIColor colorWithHexString:@"#29675F"];
        _startTime.textAlignment=NSTextAlignmentCenter;
        _startTime.text=@"7:00";
    }
    return _startTime;
}
-(UILabel *)endTime{
    if (!_endTime) {
        _endTime=[[UILabel alloc]init];
        _endTime.font=[UIFont boldSystemFontOfSize:8*KScaleW];
        _endTime.textColor=[UIColor colorWithHexString:@"#29675F"];
        _endTime.textAlignment=NSTextAlignmentCenter;
        _endTime.text=@"8:00";
    }
    return _endTime;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=[UIColor colorWithHexString:@"#29675F"];
    }
    return _lineView;
}
-(UIView *)shortLine{
    if (!_shortLine) {
        _shortLine=[[UIView alloc]init];
        _shortLine.backgroundColor=[UIColor colorWithHexString:@"#EBECED"];
    }
    return _shortLine;
}
-(UIView *)timeBgView{
    if (!_timeBgView) {
        _timeBgView=[[UIView alloc]init];
        _timeBgView.backgroundColor=[UIColor whiteColor];
    }
    return _timeBgView;
}

-(void)classClick{
     NSLog(@"11");
}

@end
