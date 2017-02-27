//
//  TestVieController.h
//  PageScrollTest
//
//  Created by dcj on 16/3/8.
//  Copyright © 2016年 dcj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestVieController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
+(instancetype)testVC;

@end
