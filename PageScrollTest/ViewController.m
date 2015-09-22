//
//  ViewController.m
//  PageScrollTest
//
//  Created by dcj on 15/9/21.
//  Copyright © 2015年 dcj. All rights reserved.
//

#import "ViewController.h"
#import "PageScrollManager.h"
#import "FirstViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"

//@interface ViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@interface ViewController ()<PageScrollDelegate,PageScrollDataSource>


@property (nonatomic,strong) NSMutableArray * contentViewControllers;
@property (nonatomic,strong) PageScrollManager * manager;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.manager = [[PageScrollManager alloc] init];
    self.manager.delegate = self;
    self.manager.dataSource = self;
    [self.manager reloadData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIViewController *)pageScrollMainViewControllerWithManager:(PageScrollManager *)manager{
    return self;
}

-(NSMutableArray *)pageScrollDataSourceWithManager:(PageScrollManager *)manager{
    return self.contentViewControllers;
}

-(NSString *)pageScrollTabTitleWithManager:(PageScrollManager *)manager index:(NSUInteger)index{

    return @"TOP";
}


-(NSArray *)contentViewControllers{
    if (_contentViewControllers == nil) {
        _contentViewControllers = [[NSMutableArray alloc] init];
        FirstViewController * firstVC = [[FirstViewController alloc] init];
        TwoViewController * twoVC = [[TwoViewController alloc] init];
        ThreeViewController * threeVC = [[ThreeViewController alloc] init];
        [_contentViewControllers addObject:twoVC];
        [_contentViewControllers addObject:threeVC];
        [_contentViewControllers addObject:firstVC];
    }
    
    return _contentViewControllers;
}

@end
