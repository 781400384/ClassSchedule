//
//  CSBaseTableView.h
//  ClassSchedule
//
//  Created by Superme on 2019/10/26.
//  Copyright © 2019 Superme. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^RefreshBlock)();
@protocol CSBaseTableViewDelegate <NSObject>


/**
 点击空数据区域刷新
 */
- (void)tapEmptyForRefresh;

@end
@interface CSBaseTableView : UITableView
@property (nonatomic, assign) BOOL        shouldAddRefresh;


@property (nonatomic, copy) RefreshBlock        headerRefreshBlock;
@property (nonatomic, copy) RefreshBlock        footerRefreshBlock;

@property (nonatomic, copy) NSString         *           emptyString;

@property (nonatomic, strong)UIImage * emptyImage;
@property (nonatomic, assign) id<CSBaseTableViewDelegate>  emptyDelegate;

/**
 是否添加下拉刷新
 
 @param add <#add description#>
 */
- (void)shouldAddHeaderRefresh:(BOOL)add;


/**
 是否添加上拉加载
 
 @param add <#add description#>
 */
- (void)shouldAddFooterRefresh:(BOOL)add;


/**
 结束刷新
 */
- (void)endRefreshing;

- (void)setEmptyData;
@end

NS_ASSUME_NONNULL_END
