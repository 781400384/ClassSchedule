//
//  SelTermTableViewCell.m
//  ClassSchedule
//
//  Created by Superme on 2019/11/7.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "SelTermTableViewCell.h"

@implementation SelTermTableViewCell

-(void)layoutSubviews{
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(22*KScaleW);
        make.top.mas_equalTo(11*KScaleH);
        make.width.mas_equalTo(self.width-22*KScaleW);
        make.height.mas_equalTo(self.height-11*KScaleH);
    }];
    [self.bgView addSubview:self.yearLabel];
    [self.yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25*KScaleW);
        make.centerY.mas_equalTo(self.mas_centerY).offset(20*KScaleW);
    }];
   
    
}

-(UIImageView *)bgView{
    if (!_bgView) {
        _bgView=[[UIImageView alloc]init];
        _bgView.contentMode=UIViewContentModeScaleToFill;
        _bgView.clipsToBounds=YES;
      
    }
    return _bgView;
}
-(UILabel *)yearLabel{
    if (!_yearLabel) {
        _yearLabel=[[UILabel alloc]init];
        _yearLabel.font=[UIFont boldSystemFontOfSize:15*KScaleW];
        _yearLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _yearLabel;
}
-(void)setModel:(TermsListModel *)model{
    _model=model;
//    self.yearLabel.text=[NSString stringWithFormat:@"%@-%@ ",model.start_year,model.end_year];
    
    if ([model.num intValue]==1) {
        self.bgView.image=[UIImage imageNamed:@"class_term_one_small"];
        NSString  *  str1=[NSString stringWithFormat:@"%@-%@",model.start_year,model.end_year];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@   第一学期 ",str1]];
        NSRange range1 = [[str string] rangeOfString:str1];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FEC295"] range:range1];
        NSRange range2 = [[str string] rangeOfString:@"第一学期"];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#F4E0E7"] range:range2];
        self.yearLabel.attributedText = str;
    }
    if ([model.num intValue]==2) {
        NSString  *  str1=[NSString stringWithFormat:@"%@-%@",model.start_year,model.end_year];
               NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@   第二学期 ",str1]];
               NSRange range1 = [[str string] rangeOfString:str1];
               [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FEC295"] range:range1];
               NSRange range2 = [[str string] rangeOfString:@"第二学期"];
               [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#F4E0E7"] range:range2];
               self.yearLabel.attributedText = str;
           self.bgView.image=[UIImage imageNamed:@"class_term_two_small"];
       }
}
@end
