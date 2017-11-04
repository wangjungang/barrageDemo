//
//  BulletManager.h
//  barrageDemo
//
//  Created by 王俊钢 on 2017/11/4.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BulletView;
@interface BulletManager : NSObject

@property(nonatomic,copy) void(^generateViewBlock)(BulletView * view);
//初始化数据源方法
-(instancetype)initWithDataSource:(NSArray *)dataSource;
//开始动画
-(void)start;
//结束动画
-(void)end;

@end
