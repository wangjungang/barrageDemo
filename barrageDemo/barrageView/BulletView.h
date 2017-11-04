//
//  BulletView.h
//  barrageDemo
//
//  Created by 王俊钢 on 2017/11/4.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class user;
//弹幕的13种状态   开始   全部进去   全部出去
typedef NS_ENUM(NSInteger,MoveStatus) {
    start,
    enter,
    end
};
@interface BulletView : UIView
//view模型数据
@property(nonatomic,strong)user * model;
//弹道   第几行显示
@property(nonatomic,assign)int dandao;
//弹幕状态
@property(nonatomic,copy)void(^moveStatusBlock)(MoveStatus status);
//开始动画
-(void)startAnimate;
//结束动画
-(void)endAnimate;
@end
