//
//  TestVieController.m
//  PageScrollTest
//
//  Created by dcj on 16/3/8.
//  Copyright © 2016年 dcj. All rights reserved.
//

#import "TestVieController.h"



@implementation TestVieController

+(instancetype)testVC{
    UIStoryboard * board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TestVieController * VC = [board instantiateViewControllerWithIdentifier:@"TestVieController"];
    return VC;
    
    return nil;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    UIScrollView * scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 250)];
    self.tableView.tableHeaderView = scrollview;
    for (int i = 0; i<3; i++) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(1*self.view.bounds.size.width, 0, self.view.bounds.size.width, 250)];
        [scrollview addSubview:view];
    }
    scrollview.contentSize = CGSizeMake(self.view.bounds.size.width*3, 250);
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

@end
