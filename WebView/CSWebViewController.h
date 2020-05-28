//
//  CSWebViewController.h
//  ClassSchedule
//
//  Created by 纪明 on 2019/11/21.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "CSBaseViewController.h"
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CSWebViewController : CSBaseViewController
@property(copy,nonatomic)NSString *linkUrl;
@end

NS_ASSUME_NONNULL_END
