//
//  FirstPageViewController.h
//  UTOUU_TEST
//
//  Created by UTOUU on 15/9/7.
//  Copyright (c) 2015年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstPageViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (nonatomic , strong) UICollectionView* TOP_CollectionView;
@property (nonatomic , strong) UICollectionView* BuyEarth_CollectionView;
@property (nonatomic , strong) UICollectionView* TSHIRT_CollectionView;


@end
