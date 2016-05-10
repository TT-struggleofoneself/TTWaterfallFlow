//
//  TTCollectionview.m
//  Chudao
//
//  Created by 优致文化 on 15/9/14.
//  Copyright (c) 2015年 youzhi. All rights reserved.
//

#import "TTCollectionview.h"
#import "MJRefresh.h"
@implementation TTCollectionview


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self AddRefresh];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        {
            [self AddRefresh];
        }
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        {
            [self AddRefresh];
        }
    }
    return self;
}



- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self AddRefresh];
    }
    return self;
}
#pragma mark-所有刷新
#pragma mark 所有头部刷新
-(void)beginheadRefreshing
{
    [self.header beginRefreshing];
}

#pragma mark 所有头部停止
-(void)endheadRefreshing
{
    [self.header endRefreshing];
}

#pragma mark 所有底部刷新
-(void)beginfootRefreshing
{
    [self.footer beginRefreshing];
}

#pragma mark 所有底部停止
-(void)endfootRefreshing
{
    [self.footer endRefreshing];
}


#pragma mark-集成刷新
-(void)AddRefresh
{
    //1.  设置是否刷新:(默认为yes)
    self.isheadRefresh=YES;
    self.isfootRefresh=YES;
    
    //默认是第一个刷新
    [self example01];
}



#pragma mark-监听下拉上拉刷新的
-(void)Jianting:(CollecHeadBlock)Reheadfreshblock andCollecFootBlock:(CollecFootBlock)Refootfreshblock
{
    self.Reheadfreshblock= ^(NSInteger index)
    {
        NSLog(@"头部开始刷新了");
        Reheadfreshblock(1);
    };
    
    
    self.Refootfreshblock= ^(NSInteger index)
    {
        NSLog(@"底部开始刷新了");
        Refootfreshblock(1);
    };
    
    
}


#pragma mark-监听下拉上拉刷新的
-(void)TagetHeadFresh:(CollecHeadBlock)Reheadfreshblock andCollecFootBlock:(CollecFootBlock)Refootfreshblock
{
    self.Reheadfreshblock= ^(NSInteger index)
    {
        NSLog(@"头部开始刷新了");
        Reheadfreshblock(1);
    };
    
    
    self.Refootfreshblock= ^(NSInteger index)
    {
        NSLog(@"底部开始刷新了");
        Refootfreshblock(1);
    };
    
    
}


#pragma mark - 示例代码
#pragma mark UITableView + 下拉刷新 传统
- (void)example01
{
    // 添加传统的下拉刷新
    // 设置回调（一旦进入刷新状态就会调用这个  refreshingBlock）
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    if(self.isheadRefresh)
    {
        self.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.Reheadfreshblock(1);
        }];
    }
    if(self.isfootRefresh)
    {
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
        self.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        // 设置了底部inset
        self.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
        // 忽略掉底部inset
        self.footer.ignoredScrollViewContentInsetTop = 30;
    }
}

#pragma mark-开始刷footer新了
-(void)loadData
{
    self.Refootfreshblock(1);
}



#pragma mark UITableView + 上拉刷新 全部加载完毕(没有数据)
- (void)FootRefreshendNoData
{
    // 添加传统的上拉刷新
    // 拿到当前的上拉刷新控件，变为没有更多数据的状态
    [self.footer noticeNoMoreData];
    
}
#pragma mark UITableView + 上拉刷新 全部加载完毕恢复加载状态
- (void)FootRefreshendReState
{
    // 添加传统的上拉刷新
    // 拿到当前的上拉刷新控件，变为没有更多数据的状态
    [self.footer resetNoMoreData];
    
}
#pragma mark UITableView + 上拉刷新 禁止自动加载底部
- (void)FootNoreFreshBottom
{
    // 添加传统的上拉刷新
    // 禁止自动加载
    //self.footer.automaticallyHidden = NO;
    
    // 此时self.tableView.footer == self.tableView.legendFooter
}
#pragma mark-上拉刷新加载完成后隐藏
-(void)FoothearHidden
{
    // 隐藏当前的上拉刷新控件
    self.footer.hidden = YES;
}

#pragma mark-上拉刷新加载完成后显示
-(void)FoothearShow
{
    // 显示当前的上拉刷新控件
    self.footer.hidden = NO;
}


#pragma mark-停止所有的刷新
-(void)endAllRefresh
{
    [self endfootRefreshing];
}

///结束所有的刷新
-(void)endAllRefreshing
{
    [self endfootRefreshing];
    [self endheadRefreshing];
}

@end
