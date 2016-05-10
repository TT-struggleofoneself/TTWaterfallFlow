//
//  TTWaterFlowLayout.h
//  TTWaterfallFlow
//
//  Created by TT_code on 16/5/7.
//  Copyright © 2016年 TT_code. All rights reserved.
//




#import <UIKit/UIKit.h>

@class TTWaterFlowLayout;
@protocol TTWaterFlowLayoutDelegate <NSObject>
@required
/** 设置cell每一个  高度 */
- (CGFloat)waterflowLayout:(TTWaterFlowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
/** 设置相关间距 */
- (CGFloat)columnCountInWaterflowLayout:(TTWaterFlowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(TTWaterFlowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(TTWaterFlowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(TTWaterFlowLayout *)waterflowLayout;


@end



@interface TTWaterFlowLayout : UICollectionViewLayout

/** *代理  */
@property(nonatomic,weak)id<TTWaterFlowLayoutDelegate> delegate;

@end



