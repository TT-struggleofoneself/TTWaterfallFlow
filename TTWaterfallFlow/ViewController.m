//
//  ViewController.m
//  TTWaterfallFlow
//
//  Created by TT_code on 16/5/7.
//  Copyright © 2016年 TT_code. All rights reserved.
//

#import "ViewController.h"
#import "Shop.h"
#import "ShopCell.h"
#import "TTWaterFlowLayout.h"
#import "TTCollectionview.h"
#import "MJExtension.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,TTWaterFlowLayoutDelegate>
/** 所有的商品数据 */
@property (nonatomic, strong) NSMutableArray *shops;

@property (nonatomic, weak) TTCollectionview *collectionView;

@end

@implementation ViewController
static NSString* idetifier=@"shop";

/**
 *  懒加载
 *
 *  @return
 */
- (NSMutableArray *)shops
{
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //基础设置
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    
    //布局
    TTWaterFlowLayout* layout=[[TTWaterFlowLayout alloc]init];
    layout.delegate=self;
    // 创建CollectionView
    TTCollectionview *collectionView = [[TTCollectionview alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor=[UIColor whiteColor];
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    self.collectionView=collectionView;
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ShopCell class]) bundle:nil] forCellWithReuseIdentifier:idetifier];
    
    
    [collectionView TagetHeadFresh:^(NSInteger index) {
     [self ReqshopListhead:YES];
    } andCollecFootBlock:^(NSInteger index) {
        [self ReqshopListhead:NO];
    }];
    [self.collectionView beginheadRefreshing];
    
}



-(void)ReqshopListhead:(BOOL)ishead{
    //头部刷新了
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shops = [Shop objectArrayWithFilename:@"1.plist"];
        if(ishead){
            [self.shops removeAllObjects];
        }
        [self.shops addObjectsFromArray:shops];
        // 刷新数据
        [self.collectionView reloadData];
        [self.collectionView  endAllRefreshing];
        
    });
}






#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:idetifier forIndexPath:indexPath];
    
    cell.shop = self.shops[indexPath.item];
    
    return cell;
}





#pragma mark - <XMGWaterflowLayoutDelegate>
- (CGFloat)waterflowLayout:(TTWaterFlowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
    Shop *shop = self.shops[index];
    
    return itemWidth * shop.h / shop.w;
}






- (CGFloat)rowMarginInWaterflowLayout:(TTWaterFlowLayout *)waterflowLayout
{
    return 10;
}

- (CGFloat)columnCountInWaterflowLayout:(TTWaterFlowLayout *)waterflowLayout
{
   
    return 4;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(TTWaterFlowLayout *)waterflowLayout
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}





@end
