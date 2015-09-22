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
-(NSUInteger)pageScrollDefaultShowIndexWithManager:(PageScrollManager *)manager;
-(CGFloat)pageScrollManagerWidthForTitleWithManager:(PageScrollManager *)manager;
@required
-(NSString *)pageScrollTabTitleWithManager:(PageScrollManager *)manager index:(NSUInteger)index;

@end

@protocol PageScrollDataSource <NSObject>
@required
-(UIViewController *)pageScrollMainViewControllerWithManager:(PageScrollManager *)manager;
-(NSMutableArray *)pageScrollDataSourceWithManager:(PageScrollManager *)manager;

@end

@interface PageScrollManager : NSObject

@property (nonatomic,weak)id<PageScrollDelegate>delegate;
@property (nonatomic,weak)id<PageScrollDataSource>dataSource;

-(void)reloadData;

@end
