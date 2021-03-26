//
//  PWCategoryView.h
//  PWUtils
//
//  Created by mac on 2017/5/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWCategoryModel.h"
#import "PWPageControl.h"
typedef void(^PWCategoryViewButtonEvent)(id categoryView , NSInteger index);
@interface PWCategoryView : UIView<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@property (nonatomic, assign) UIEdgeInsets padding;
@property (nonatomic, assign) CGFloat collectionCornerRadius;
@property (nonatomic, strong) NSMutableArray<PWCategoryModel *> *datas;

@property (nonatomic, assign) NSInteger line;
@property (nonatomic, assign) NSInteger cols;

@property(nonatomic,copy) PWCategoryViewButtonEvent clickEvent;

@end
