//
//
//
//
//
//   
//

#import "TTWaterFlowLayout.h"

/** 默认的列数 */
static const NSInteger TTDefaultColumnCount = 3;

/** 每一列间间距 */
static const CGFloat TTDefaultColumnMargin=10;
/** 每一行间间距 */
static const CGFloat TTDefaultRowMargin=10;
/** 边缘间距 */
static const UIEdgeInsets TTDefaultEdgeInsets = {10, 10, 10, 10};

@interface TTWaterFlowLayout()
@property(nonatomic,strong)NSMutableArray* attrsArray;

/** 存放所有列的当前高度--- */
@property (nonatomic, strong) NSMutableArray *columnHeights;

//声明获取方法
- (CGFloat)rowMargin;
- (CGFloat)columnMargin;
- (NSInteger)columnCount;
- (UIEdgeInsets)edgeInsets;

@end
@implementation TTWaterFlowLayout

/**
 *  懒加载
 *
 */
-(NSMutableArray *)attrsArray
{
    if(!_attrsArray){
        _attrsArray=[NSMutableArray array];
    }
    return _attrsArray;
}

-(NSMutableArray *)columnHeights
{
    if(!_columnHeights){
        _columnHeights=[NSMutableArray array];
    }
    return _columnHeights;
}


#pragma mark - 常见数据处理
- (CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout:)]) {
        return [self.delegate rowMarginInWaterflowLayout:self];
    } else {
        return TTDefaultRowMargin;
    }
}

- (CGFloat)columnMargin
{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterflowLayout:)]) {
        return [self.delegate columnMarginInWaterflowLayout:self];
    } else {
        return TTDefaultColumnMargin;
    }
}

- (NSInteger)columnCount
{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterflowLayout:)]) {
        return [self.delegate columnCountInWaterflowLayout:self];
    } else {
        return TTDefaultColumnCount;
    }
}

- (UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterflowLayout:)]) {
        return [self.delegate edgeInsetsInWaterflowLayout:self];
    } else {
        return TTDefaultEdgeInsets;
    }
}



/**
 * 初始化
 */
- (void)prepareLayout
{
    [super prepareLayout];
    // 清除以前计算的所有高度
    [self.columnHeights removeAllObjects];
    //先移除所有的 因为这里刷新就会进来执行。
    [self.attrsArray removeAllObjects];
    //设置默认数字高度
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }

    
   //让初始化的时候就算好布局
    NSInteger count=[self.collectionView numberOfItemsInSection:0];
    for (int i=0; i<count; i++) {
        //获取位置
        NSIndexPath* indexpath=[NSIndexPath indexPathForItem:i inSection:0];
        //创建布局属性
        UICollectionViewLayoutAttributes* attrs=[self  layoutAttributesForItemAtIndexPath:indexpath];
        [self.attrsArray addObject:attrs];
    }
}


/**
 * 决定cell的排布
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //返回布局元素
    return self.attrsArray;
}


/**
 * 返回indexPath位置cell对应的布局属性---核心方法
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //创建布局属性
    UICollectionViewLayoutAttributes* attrs=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat collectionW=self.collectionView.frame.size.width;
    
    CGFloat Width=(collectionW-self.edgeInsets.left-self.edgeInsets.right- (self.columnCount- 1)*self.columnMargin)/self.columnCount;
     CGFloat Height = [self.delegate waterflowLayout:self heightForItemAtIndex:indexPath.item itemWidth:Width];
    
    // 找出高度最短的那一列
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.columnCount; i++) {
        // 取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    //找出最短的一列
    CGFloat X=self.edgeInsets.left+destColumn*(Width+self.columnMargin);
    CGFloat Y=minColumnHeight;
    if(Y!=self.edgeInsets.top){
        Y+=self.rowMargin;
    }
    
    attrs.frame=CGRectMake(X, Y, Width, Height);
    self.columnHeights[destColumn]=@(CGRectGetMaxY(attrs.frame));

    return  attrs;
}




- (CGSize)collectionViewContentSize
{
    CGFloat maxColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.columnCount; i++) {
        // 取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        
        if (maxColumnHeight < columnHeight) {
            maxColumnHeight = columnHeight;
        }
    }
    return CGSizeMake(0, maxColumnHeight + self.edgeInsets.bottom);
}

@end





