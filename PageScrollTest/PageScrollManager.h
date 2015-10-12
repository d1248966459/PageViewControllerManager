//
//  PageScrollManager.h
//  PageScrollTest
//
//  Created by dcj on 15/9/21.
//  Copyright © 2015年 dcj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class PageScrollManager;
@protocol PageScrollDelegate <NSObject>
@optional
/**
 *  默认选中index
 *
 *  @param manager manager
 *
 *  @return 默认选中index
 */
-(NSUInteger)pageScrollDefaultShowIndexWithManager:(PageScrollManager *)manager;
/**
 *  title 宽度
 *
 *  @param manager manager
 *
 *  @return 宽度
 */
-(CGFloat)pageScrollManagerWidthForTitleWithManager:(PageScrollManager *)manager;
/**
 *  title height
 *
 *  @param manager manager
 *
 *  @return 高度
 */
-(CGFloat)pageScrollManagerHeightForTitleWithManager:(PageScrollManager *)manager;
/**
 *  设置title font
 *
 *  @param manager manager
 *  @param index   index
 *
 *  @return font
 */
-(UIFont *)pageScrollManagerFontForTitlewithManager:(PageScrollManager *)manager index:(NSUInteger)index;
@required
/**
 *  title name
 *
 *  @param manager manager
 *  @param index   index
 *
 *  @return name
 */
-(NSString *)pageScrollTabTitleWithManager:(PageScrollManager *)manager index:(NSUInteger)index;

@end

@protocol PageScrollDataSource <NSObject>
@required
/**
 *  pageScrollVC 所在vc
 *
 *  @param manager manager
 *
 *  @return pageScrollVC 所在vc
 */
-(UIViewController *)pageScrollMainViewControllerWithManager:(PageScrollManager *)manager;
/**
 *  获得 数据VC
 *
 *  @param manager manager
 *
 *  @return 数组
 */
-(NSMutableArray <UIViewController*> *)pageScrollDataSourceWithManager:(PageScrollManager *)manager;

@end

@interface PageScrollManager : NSObject

@property (nonatomic,weak)id<PageScrollDelegate>delegate;
@property (nonatomic,weak)id<PageScrollDataSource>dataSource;

/**
 *  对页面进行布局操作
 */
-(void)reloadData;

@end
