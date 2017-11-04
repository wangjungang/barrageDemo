//
//  user.h
//  barrageDemo
//
//  Created by 王俊钢 on 2017/11/4.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface user : NSObject
//评论内容
@property(nonatomic,copy)NSString * comment;
//用户头像
@property(nonatomic,copy)NSString * iconUrl;
//点赞数
@property(nonatomic,assign)int *zan;
@end
