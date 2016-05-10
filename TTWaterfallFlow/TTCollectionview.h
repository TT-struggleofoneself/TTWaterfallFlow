//
//  TTCollectionview.h
//  Chudao
//
//  Created by 优致文化 on 15/9/14.
//  Copyright (c) 2015年 youzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  头部刷新blok
 */
typedef void (^CollecHeadBlock) (NSInteger index);
/**
 *  底部刷新blok
 */
typedef void (^CollecFootBlock) (NSInteger index);





@interface TTCollectionview : UICollectionView





/**
 *  头部刷新blok
 */
@property(nonatomic,copy)CollecHeadBlock Reheadfreshblock;
/**
 *  底部刷新blok
 */
@property(nonatomic,copy)CollecFootBlock Refootfreshblock;




/**
 *  是否需要显示头部刷新
 */
@property(nonatomic)BOOL isheadRefresh;
/**
 *  是否需要显示底部刷新
 */
@property(nonatomic)BOOL isfootRefresh;





/**
 *  UITableView + 下拉+上拉   刷新 传统
 */
- (void)example01;






/**
 *  上拉刷新 全部加载完毕(没有数据)
 */
- (void)FootRefreshendNoData;
/**
 *  上拉刷新 全部加载完毕恢复加载状态
 */
- (void)FootRefreshendReState;
/**
 *  上拉刷新 禁止自动加载底部
 */
- (void)FootNoreFreshBottom;
/**
 *  上拉刷新加载完成后隐藏
 */
-(void)FoothearHidden;
/**
 *  上拉刷新加载完成后显示
 */
-(void)FoothearShow;







/**
 *  监听刷新和各种操作
 */
-(void)Jianting:(CollecHeadBlock)Reheadfreshblock andCollecFootBlock:(CollecFootBlock)Refootfreshblock;

/**
 *  监听开始刷新事件
 */
-(void)TagetHeadFresh:(CollecHeadBlock)Reheadfreshblock andCollecFootBlock:(CollecFootBlock)Refootfreshblock;









/**
 *  所有头部停止刷新
 */
-(void)beginheadRefreshing;
/**
 *  所有头部停止停止
 */
-(void)endheadRefreshing;
/**
 *  所有底部刷新
 */
-(void)beginfootRefreshing;
/**
 *  所有头部底部停止
 */
-(void)endfootRefreshing;
/**
 *  结束所有的刷新
 */
-(void)endAllRefreshing;



@end
