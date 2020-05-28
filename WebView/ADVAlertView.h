//
//  ADVAlertView.h
//  ClassSchedule
//
//  Created by 纪明 on 2019/11/21.
//  Copyright © 2019 Superme. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ADVAlertView;
@protocol ADVAlertViewDelegate <NSObject>

@end
NS_ASSUME_NONNULL_BEGIN

@interface ADVAlertView : UIView
@property (nonatomic, weak) id<ADVAlertViewDelegate> delegate;


- (instancetype)initWithImage:(NSString *)imageName ;

- (void)showView;

-(void)dismissAlertView;
@end

NS_ASSUME_NONNULL_END
