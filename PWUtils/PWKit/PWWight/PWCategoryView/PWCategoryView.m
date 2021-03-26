//
//  PWCategoryView.m
//  PWUtils
//
//  Created by mac on 2017/5/11.
//  Copyright © 2017年 mac. All rights reserved.
//
#import "PWCategoryView.h"
#import "BaseTool.h"
#import "NSBundle+PWBundleTool.h"
#import <SDWebImage/SDWebImage.h>
#import "PWCategoryViewCell.h"
@import CHIPageControl;

@interface PWCollectionViewLayout : UICollectionViewFlowLayout{}
/** 列间距 */
@property (nonatomic, assign) CGFloat columnSpacing;
/** 行间距 */
@property (nonatomic, assign) CGFloat rowSpacing;
/** collectionView的内边距 */
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

/** 多少行 */
@property (nonatomic, assign) NSInteger rowCount;
/** 每行展示多少个item */
@property (nonatomic, assign) NSInteger itemCountPerRow;

//固定宽度
@property (nonatomic, assign) CGFloat itemWidth; //设置完这个，就会自动计算列间距
//固定高度
@property (nonatomic, assign) CGFloat itemHight;//设置完这个，就会自动计算行间距

/** 所有item的属性数组 */
@property (nonatomic, strong) NSMutableArray *attributesArrayM;

/** 设置行列间距及collectionView的内边距 */
- (void)setColumnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing edgeInsets:(UIEdgeInsets)edgeInsets;
/** 设置多少行及每行展示的item个数 */
- (void)setRowCount:(NSInteger)rowCount itemCountPerRow:(NSInteger)itemCountPerRow;

#pragma mark - 构造方法
/** 设置多少行及每行展示的item个数 */
+ (instancetype)horizontalPageFlowlayoutWithRowCount:(NSInteger)rowCount itemCountPerRow:(NSInteger)itemCountPerRow;
/** 设置多少行及每行展示的item个数 */
- (instancetype)initWithRowCount:(NSInteger)rowCount itemCountPerRow:(NSInteger)itemCountPerRow;

@end


@implementation PWCollectionViewLayout

#pragma mark - Public
- (void)setColumnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing edgeInsets:(UIEdgeInsets)edgeInsets
{
    self.columnSpacing = columnSpacing;
    self.rowSpacing = rowSpacing;
    self.edgeInsets = edgeInsets;
}

- (void)setRowCount:(NSInteger)rowCount itemCountPerRow:(NSInteger)itemCountPerRow
{
    self.rowCount = rowCount;
    self.itemCountPerRow = itemCountPerRow;
}

#pragma mark - 构造方法
+ (instancetype)horizontalPageFlowlayoutWithRowCount:(NSInteger)rowCount itemCountPerRow:(NSInteger)itemCountPerRow
{
    return [[self alloc] initWithRowCount:rowCount itemCountPerRow:itemCountPerRow];
}

- (instancetype)initWithRowCount:(NSInteger)rowCount itemCountPerRow:(NSInteger)itemCountPerRow
{
    self = [super init];
    if (self) {
        self.rowCount = rowCount;
        self.itemCountPerRow = itemCountPerRow;
    }
    return self;
}


#pragma mark - 重写父类方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setColumnSpacing:0 rowSpacing:0 edgeInsets:UIEdgeInsetsZero];
    }
    return self;
}

/** 布局前做一些准备工作 */
- (void)prepareLayout
{
    [super prepareLayout];
    if (self.attributesArrayM && self.attributesArrayM.count > 0) {
        [self.attributesArrayM removeAllObjects];
    }
    
    // 从collectionView中获取到有多少个item
    NSInteger itemTotalCount = [self.collectionView numberOfItemsInSection:0];
    
    // 遍历出item的attributes,把它添加到管理它的属性数组中去
    for (int i = 0; i < itemTotalCount; i++) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexpath];
        [self.attributesArrayM addObject:attributes];
    }
}

/** 计算collectionView的滚动范围 */
- (CGSize)collectionViewContentSize
{
    // 计算出item的宽度
    CGFloat itemWidth = (self.collectionView.frame.size.width - self.edgeInsets.left - self.itemCountPerRow * self.columnSpacing) / self.itemCountPerRow;
    // 从collectionView中获取到有多少个item
    NSInteger itemTotalCount = [self.collectionView numberOfItemsInSection:0];
    
    // 理论上每页展示的item数目
    NSInteger itemCount = self.rowCount * self.itemCountPerRow;
    // 余数（用于确定最后一页展示的item个数）
    NSInteger remainder = itemTotalCount % itemCount;
    // 除数（用于判断页数）
    NSInteger pageNumber = itemTotalCount / itemCount;
    // 总个数小于self.rowCount * self.itemCountPerRow
    if (itemTotalCount <= itemCount) {
        pageNumber = 1;
    }else {
        if (remainder == 0) {
            pageNumber = pageNumber;
        }else {
            // 余数不为0,除数加1
            pageNumber = pageNumber + 1;
        }
    }
    
    CGFloat width = 0;
    // 考虑特殊情况(当item的总个数不是self.rowCount * self.itemCountPerRow的整数倍,并且余数小于每行展示的个数的时候)
    if (pageNumber > 1 && remainder != 0 && remainder < self.itemCountPerRow) {
        width = self.edgeInsets.left + (pageNumber - 1) * self.itemCountPerRow * (itemWidth + self.columnSpacing) + remainder * itemWidth + (remainder - 1)*self.columnSpacing + self.edgeInsets.right;
    }else {
        width = self.edgeInsets.left + pageNumber * self.itemCountPerRow * (itemWidth + self.columnSpacing) - self.columnSpacing + self.edgeInsets.right;
    }
    
    // 只支持水平方向上的滚动
    return CGSizeMake(width, 150);
}

/** 设置每个item的属性(主要是frame) */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // item的宽高由行列间距和collectionView的内边距决定
    CGFloat itemWidth = (self.collectionView.frame.size.width) / self.itemCountPerRow;
    CGFloat itemHeight = (self.collectionView.frame.size.height) / self.rowCount;
    
    NSInteger item = indexPath.item;
    // 当前item所在的页
    NSInteger pageNumber = item / (self.rowCount * self.itemCountPerRow);
    NSInteger x = item % self.itemCountPerRow + pageNumber * self.itemCountPerRow;
    NSInteger y = item / self.itemCountPerRow - pageNumber * self.rowCount;
    
    // 计算出item的坐标
    CGFloat itemX = itemWidth * x;
    CGFloat itemY = itemHeight * y;
    
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    // 每个item的frame
    attributes.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
    
    return attributes;
}

/** 返回collectionView视图中所有视图的属性数组 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributesArrayM;
}


#pragma mark - Lazy
- (NSMutableArray *)attributesArrayM
{
    if (!_attributesArrayM) {
        _attributesArrayM = [NSMutableArray array];
    }
    return _attributesArrayM;
}
@end

@import QuartzCore;

@interface PWCategoryView(){
    PWCollectionViewLayout *collectionViewLayout;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collection_left;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collection_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collection_right;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collection_bottom;
@property (weak, nonatomic) IBOutlet CHIPageControlJaloro *pageControlJaloro;


@end

@implementation PWCategoryView

- (instancetype)init{
    NSString *className = NSStringFromClass([self class]);
    if ([className containsString:@"."]) {
        NSArray *array = [className componentsSeparatedByString:@"."];
        if (array.count > 1) {
            className = [className componentsSeparatedByString:@"."][1];
        }
    }
    NSBundle *bundle = [NSBundle bundleWith:self.class fileName:className fileType:@"nib"];
    if (bundle) {
        NSArray *array = [bundle loadNibNamed:className owner:self options:nil];
        self = array[0];
    }else{
        self = [super init];
    }
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _line = 2;
        _cols = 5;
    }
    return self;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)setCollection:(UICollectionView *)collection{
    _collection = collection;
    [_collection setCollectionViewLayout:self.collectionViewLayout];
    NSBundle *bundle = [NSBundle bundleWith:[self class] fileName:@"PWCategoryViewCell" fileType:@"nib"];
    [_collection registerNib:[UINib nibWithNibName:@"PWCategoryViewCell" bundle:bundle] forCellWithReuseIdentifier:@"PWCategoryViewCell"];
}
- (void)setPadding:(UIEdgeInsets)padding{
    _padding = padding;
    _collection_left.constant = padding.left;
    _collection_right.constant = padding.right;
    _collection_top.constant = padding.top;
    _collection_bottom.constant = padding.bottom;
}

- (void)setCollectionCornerRadius:(CGFloat)collectionCornerRadius{
    _collectionCornerRadius = collectionCornerRadius;
    _collection.layer.cornerRadius = collectionCornerRadius;
    _collection.layer.masksToBounds = YES;
    _collection.pagingEnabled = YES;
}

- (PWCollectionViewLayout *)collectionViewLayout{
    if (collectionViewLayout == nil){
        collectionViewLayout = [[PWCollectionViewLayout alloc] init];
        collectionViewLayout.rowCount = _line;
        collectionViewLayout.itemCountPerRow = _cols;
    }
    return collectionViewLayout;
}

- (void)setPageControlJaloro:(CHIPageControlJaloro *)pageControlJaloro{
    _pageControlJaloro = pageControlJaloro;
    pageControlJaloro.elementWidth = 15;
    pageControlJaloro.elementHeight = 2;
    pageControlJaloro.numberOfPages = 0;
}

- (void)setDatas:(NSMutableArray<PWCategoryModel *> *)datas{
    _datas = datas;
    [self updatePageControl];
    self.collectionViewLayout.rowCount = _line;
    self.collectionViewLayout.itemCountPerRow = _cols;
    [_collection reloadData];
}

- (void)updatePageControl{
    NSInteger _numberOfOnePage = 1;
    if (_line * _cols > 0){
        _numberOfOnePage = _line * _cols;
    }
    _pageControlJaloro.numberOfPages = ceil((double)_datas.count / _numberOfOnePage);
}


- (void)actionButtonPressed:(int)index{
    if (_clickEvent) {
        _clickEvent(self , index);
    }
}

- (IBAction)pageControlValueChanged:(id)sender{
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _datas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PWCategoryModel *model = _datas[indexPath.row];
    PWCategoryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PWCategoryViewCell" forIndexPath:indexPath];
    cell.model = model;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(60,80);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _pageControlJaloro.progress = (scrollView.contentOffset.x) / scrollView.frame.size.width;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    _pageControlJaloro.progress = (scrollView.contentOffset.x) / scrollView.frame.size.width;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_pageControlJaloro setProgress:scrollView.contentOffset.x / scrollView.bounds.size.width];
}
@end
