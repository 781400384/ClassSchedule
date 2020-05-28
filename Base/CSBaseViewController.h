//
//  CSBaseViewController.h
//  ClassSchedule
//
//  Created by Superme on 2019/10/26.
//  Copyright © 2019 Superme. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSBaseViewController : UIViewController
@property (nonatomic, strong) CSNaview    *  naviView;
- (void)showLeftItemButton:(BOOL)show;
- (void)showRightItemButton:(BOOL)show;
- (void)leftDismiss;
- (void)rightTitleLabelTap;
@end

NS_ASSUME_NONNULL_END
