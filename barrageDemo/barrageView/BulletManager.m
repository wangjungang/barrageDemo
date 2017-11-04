//
//  BulletManager.m
//  barrageDemo
//
//  Created by 王俊钢 on 2017/11/4.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "BulletManager.h"
#import "BulletView.h"
#import "user.h"
#define kDandaoNumber 4
@interface BulletManager()
//弹幕数据来源
@property(nonatomic,strong)NSArray * dataSource;

@property(nonatomic,strong)NSMutableArray<user *> * bulletComments;//存放弹幕内容

@property(nonatomic,strong)NSMutableArray * bulletViews;//存放弹幕视图

@property(nonatomic,assign)BOOL bStopAnimation;//判断是否结束弹幕

@end
@implementation BulletManager
-(instancetype)initWithDataSource:(NSMutableArray *)dataSource{
    if(self = [super init]){
        self.bStopAnimation = YES;
        self.dataSource = dataSource;
    }
    return self;
}

-(NSMutableArray *)bulletComments{
    if(!_bulletComments){
        _bulletComments = [NSMutableArray array];
    }
    return _bulletComments;
}
-(NSMutableArray *)bulletViews{
    if(!_bulletViews){
        _bulletViews = [NSMutableArray array];
    }
    return _bulletViews;
}

-(void)start{
    if(!self.bStopAnimation){
        return;
    }
    self.bStopAnimation = NO;
    [self.bulletComments removeAllObjects];
    //获取数据源
    [self.bulletComments addObjectsFromArray:self.dataSource];
    [self iniBulletComment];
}
//初始化弹幕过程
-(void)iniBulletComment{
    NSMutableArray * dandaoArray = [NSMutableArray array];
    for (int i =0; i<kDandaoNumber; i++) {
        [dandaoArray addObject:@(i)];
    }
    for (int i =0; i<kDandaoNumber; i++) {//显示kDandaoNumber行弹幕
        if(self.bulletComments.count > 0){
            //随机产生弹道
            NSInteger index = arc4random()%dandaoArray.count;
            int tra = [[dandaoArray objectAtIndex:index] intValue];
            [dandaoArray removeObjectAtIndex:index];
            //从弹幕数组中逐一取出数据
            user * model = [self.bulletComments firstObject];
            [self.bulletComments removeObjectAtIndex:0];
            //创建弹幕
            [self createBulletView:model tra:tra];
        }
    }
}
-(void)createBulletView:(user *)comment tra:(int)tra{
    if(self.bStopAnimation){
        return;
    }
    BulletView * view = [[BulletView alloc] init];
    view.dandao = tra;
    view.model = comment;
    [self.bulletViews addObject:view];
    __weak typeof (view) weakView = view;
    __weak typeof (self) weakSelf = self;
    view.moveStatusBlock = ^(MoveStatus status){
        if(self.bStopAnimation){
            return ;
        }
        switch (status) {
            case start:{
                [weakSelf.bulletViews addObject:weakView];
                break;
            }
            case enter:{
                user * nextCom = [weakSelf nextComment];
                if(nextCom){
                    //创建新的弹幕
                    [weakSelf createBulletView:nextCom tra:tra];
                }
                break;
            }
            case end:{
                //已出弹幕后销毁
                if([weakSelf.bulletViews containsObject:weakView]){
                    [weakView endAnimate];
                    [weakSelf.bulletViews removeObject:weakView];
                }
                if(weakSelf.bulletViews.count == 0){
                    weakSelf.bStopAnimation = YES;
                    [weakSelf start];
                }
                break;
            }
            default:
                break;
        }
    };
    if (self.generateViewBlock) {
        self.generateViewBlock(view);
    }
}
-(user *)nextComment{
    if(self.bulletComments.count == 0){
        return  nil;
    }
    user * comment = [self.bulletComments firstObject];
    if(comment){
        [self.bulletComments removeObjectAtIndex:0];
    }
    return comment;
}
-(void)end{
    if(self.bStopAnimation){
        return;
    }
    self.bStopAnimation = YES;
    [self.bulletViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BulletView * view = obj;
        [view endAnimate];
        view = nil;
    }];
    [self.bulletViews removeAllObjects];
}
@end

