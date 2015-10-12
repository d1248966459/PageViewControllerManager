//
//  PageScrollManager.m
//  PageScrollTest
//
//  Created by dcj on 15/9/21.
//  Copyright © 2015年 dcj. All rights reserved.
//

#import "PageScrollManager.h"

#define kContentViewTag 24
#define kTitleButtonTag 55


@interface PageScrollManager ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (nonatomic,assign) NSUInteger defaultIndex;
@property (nonatomic,strong) NSMutableArray * contentViewControllers;
@property (nonatomic,strong) UIViewController * mainViewController;
@property (nonatomic,strong) UIPageViewController * pageViewController;
@property (nonatomic,strong) UIScrollView * titleTab;
@property (nonatomic,assign) CGFloat titleLabelWidth;
@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic,strong) UIView * animationView;
@property (nonatomic,strong) UIView * contentView;

@end

@implementation PageScrollManager

-(instancetype)init{
    if (self = [super init]) {
        [self defaultInit];
    }
    return self;
}

-(void)defaultInit{
    self.defaultIndex = 0;
    self.selectedIndex = 0;
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    
}

-(void)reloadData{
    [self.mainViewController addChildViewController:self.pageViewController];
    [self.mainViewController.view addSubview:self.pageViewController.view];
    UIViewController * defaultVC = [self.contentViewControllers objectAtIndex:self.defaultIndex];
    [self.pageViewController setViewControllers:@[defaultVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self setContentVIewContrains];
    [self createTabView];
    [self createAnimationView];
}

-(void)setContentVIewContrains{
    self.contentView = [self.mainViewController.view viewWithTag:kContentViewTag];
    if (!self.contentView) {
        
        // Populate pageViewController.view in contentView
        self.contentView = self.pageViewController.view;
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.contentView.bounds = self.mainViewController.view.bounds;
        self.contentView.tag = kContentViewTag;
        [self.mainViewController.view insertSubview:self.contentView atIndex:0];
        
        // constraints
        CGFloat height = [self titleLabelHeight]+20;

            self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
            NSDictionary *views = @{ @"contentView" : self.contentView };
            [self.mainViewController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[contentView]-0-|" options:0 metrics:nil views:views]];
//            [self.mainViewController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[contentView]-0-|" options:0 metrics:nil views:views]];
        
        NSMutableArray * constrains = [[NSMutableArray alloc] init];
        NSLayoutConstraint * top = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.mainViewController.view attribute:NSLayoutAttributeTop multiplier:1 constant:height];
        [constrains addObject:top];
        NSLayoutConstraint * bottom = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.mainViewController.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        [constrains addObject:bottom];
        [self.mainViewController.view addConstraints:constrains];
        
    }

}

-(void)createTabView{
    CGFloat height = [self titleLabelHeight];
    self.titleTab = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, self.mainViewController.view.bounds.size.width, height)];
    self.titleTab.backgroundColor =[UIColor lightGrayColor];
    [self.mainViewController.view addSubview:self.titleTab];
    self.titleTab.backgroundColor = [UIColor whiteColor];

    [self.contentViewControllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton * titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.backgroundColor = [UIColor lightGrayColor];
        titleButton.frame = CGRectMake(idx*self.titleLabelWidth, 0, self.titleLabelWidth, height);
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        [titleButton setTitle:[self getTitleNameWithIndex:idx] forState:UIControlStateNormal];
        [titleButton addTarget:self action:@selector(titleLabelClick:) forControlEvents:UIControlEventTouchUpInside];
        titleButton.titleLabel.font = [self titleLabelFontWithIndex:idx];
        if (idx == self.defaultIndex) {
            titleButton.selected = YES;
        }
        titleButton.tag = kTitleButtonTag + idx;
        [self.titleTab addSubview:titleButton];
    }];
}

-(void)createAnimationView{
    
    self.animationView = [[UIView alloc] initWithFrame:CGRectMake(self.titleLabelWidth*self.selectedIndex, self.titleTab.bounds.size.height-2, self.titleLabelWidth, 2)];
    [self.titleTab addSubview:self.animationView];
    self.animationView.backgroundColor = [UIColor greenColor];
}

-(void)setSelectedTitleButton:(NSInteger)selectedButtonIndex{

    [self.contentViewControllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton * tempTitle = (UIButton *)[self.titleTab viewWithTag:(kTitleButtonTag + idx)];
        if (idx == selectedButtonIndex) {
            tempTitle.selected = YES;
        }else{
            if (tempTitle.selected) {
                tempTitle.selected = NO;
            }else{
                tempTitle.selected = NO;
            }
        
        }
        
    }];

}

-(void)titleLabelClick:(UIButton *)title{
    [self setSelectedTitleButton:title.tag - kTitleButtonTag];
    [self setSelectedPageWithIndex:title.tag - kTitleButtonTag];
    [self setSelectedAnimationWithIndex:title.tag - kTitleButtonTag];
}

-(void)setSelectedAnimationWithIndex:(NSInteger)index{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.animationView.frame = CGRectMake(self.titleLabelWidth*index, self.animationView.frame.origin.y, self.titleLabelWidth,2);
    }];

}

-(void)setSelectedPageWithIndex:(NSInteger)index{
    UIViewController *viewController = [self.contentViewControllers objectAtIndex:index];
    
    if (!viewController) {
        viewController = [[UIViewController alloc] init];
        viewController.view = [[UIView alloc] init];
        viewController.view.backgroundColor = [UIColor redColor];
    }
    
    if (index == self.selectedIndex) {
        
        [self.pageViewController setViewControllers:@[viewController]
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:NO
                                         completion:^(BOOL completed){// none
                                         }];
        
    } else {
        
        NSInteger direction = 0;
        if (index>self.selectedIndex) {
            direction = UIPageViewControllerNavigationDirectionForward;
        }else{
            direction = UIPageViewControllerNavigationDirectionReverse;
        }
        [self.pageViewController setViewControllers:@[viewController]
                                          direction:direction
                                           animated:YES
                                         completion:^(BOOL completed){
                                         }];
    }

    _selectedIndex = index;
}


#pragma mark -- pageviewcontroller 代理
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSInteger cruuentIndex = [self indexOfViewController:viewController];
    cruuentIndex ++;
    if (cruuentIndex == self.contentViewControllers.count) {
        
    }else{
        return [self.contentViewControllers objectAtIndex:cruuentIndex];
    }
    
    return nil;
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{

    NSInteger cruuentIndex = [self indexOfViewController:viewController];

    if (cruuentIndex == 0) {
        
    }else{
        cruuentIndex --;
        return [self.contentViewControllers objectAtIndex:cruuentIndex];
    }
    
    return nil;
}

/**
 *  pageVC的代理 将要到某个vc时调用
 *
 *  @param pageViewController     pageviewController
 *  @param pendingViewControllers 将要展示的vc
 */
-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
//    UIViewController * tempVC = [pendingViewControllers firstObject];
//    NSInteger index = [self indexOfViewController:tempVC];
//    [self setSelectedAnimationWithIndex:index];
//    [self setSelectedTitleButton:index];

}
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    UIViewController * tempVC = [self.pageViewController.viewControllers firstObject];
    NSInteger index = [self indexOfViewController:tempVC];
    [self setSelectedAnimationWithIndex:index];
    [self setSelectedTitleButton:index];

}
#pragma mark -- getter
-(NSUInteger)indexOfViewController:(UIViewController *)controller{

    return [self.contentViewControllers indexOfObject:controller];
}

-(NSUInteger)defaultIndex{
    if ([self.delegate respondsToSelector:@selector(pageScrollDefaultShowIndexWithManager:)]) {
        return [self.delegate pageScrollDefaultShowIndexWithManager:self];

    }
    return _defaultIndex;
}

-(CGFloat)titleLabelWidth{
    if ([self.delegate respondsToSelector:@selector(pageScrollManagerWidthForTitleWithManager:)]) {
        return [self.delegate pageScrollManagerWidthForTitleWithManager:self];
    }
    return [UIScreen mainScreen].bounds.size.width/3;
}

-(CGFloat)titleLabelHeight{
    if ([self.delegate respondsToSelector:@selector(pageScrollManagerHeightForTitleWithManager:)]) {
        return [self.delegate pageScrollManagerHeightForTitleWithManager:self];
    }
    return 35;
}

-(UIFont *)titleLabelFontWithIndex:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(pageScrollManagerFontForTitlewithManager:index:)]) {
        return [self.delegate pageScrollManagerFontForTitlewithManager:self index:index];
    }
    return [UIFont systemFontOfSize:15];
}

-(NSMutableArray *)contentViewControllers{
    if (_contentViewControllers) {
        return _contentViewControllers;
    }else{

        return [self.dataSource pageScrollDataSourceWithManager:self];
    }
}

-(UIViewController *)mainViewController{
    if (_mainViewController) {
        return _mainViewController;
    }else{
        return [self.dataSource pageScrollMainViewControllerWithManager:self];
    }

}
-(NSString *)getTitleNameWithIndex:(NSUInteger)idx{
    
    return [self.delegate pageScrollTabTitleWithManager:self index:idx];
}

@end
