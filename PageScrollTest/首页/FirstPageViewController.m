//
//  FirstPageViewController.m
//  UTOUU_TEST
//
//  Created by UTOUU on 15/9/7.
//  Copyright (c) 2015年 UTOUU. All rights reserved.
//

#import "FirstPageViewController.h"
#import "Masonry.h"
#import "TOP_CollectionViewCell.h"

//#import "FirstPageListViewController.h"

#define SCROLLVIEW_TAG  1001
#define SCREENHIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define RgbColor(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
@interface FirstPageViewController ()

@property (nonatomic,assign) NSInteger page_no;

@end

@implementation FirstPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView{

    
    UICollectionViewFlowLayout *TOP_flowLayout= [[UICollectionViewFlowLayout alloc]init];
    TOP_flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    _TOP_CollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:TOP_flowLayout];
    _TOP_CollectionView.backgroundColor = RgbColor(234, 234, 234);
    [_TOP_CollectionView registerClass:[TOP_CollectionViewCell class] forCellWithReuseIdentifier:@"TOPCell"];
    _TOP_CollectionView.delegate = self;
    _TOP_CollectionView.dataSource = self;
    _TOP_CollectionView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height -50);
    [self.view addSubview:_TOP_CollectionView];
}



#pragma mark -- UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString * CellIdentifier = @"TOPCell";
        TOP_CollectionViewCell* cell = [_TOP_CollectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.TOP_label1.text = @"a@#$@#%$%$#%#$%#$";
        cell.TOP_label2.text = @"fksdf;msdfnsd打什么奶粉";
        return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.bounds.size.width - 20)/2, 250);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 6;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 3;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
