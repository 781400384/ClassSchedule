//
//  SelTermTableViewCell.h
//  ClassSchedule
//
//  Created by Superme on 2019/11/7.
//  Copyright © 2019 Superme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TermsListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SelTermTableViewCell : UITableViewCell
@property (nonatomic, strong) TermsListModel  *  model;
@property (nonatomic, strong) UIImageView      *     bgView;
@property (nonatomic, strong) UILabel     *     yearLabel;

@end

NS_ASSUME_NONNULL_END
