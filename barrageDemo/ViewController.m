//
//  ViewController.m
//  barrageDemo
//
//  Created by 王俊钢 on 2017/11/4.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "ViewController.h"
#import "BulletManager.h"
#import "BulletView.h"
#import "user.h"
@interface ViewController ()
@property(nonatomic,strong)BulletManager * manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //弹幕model对象
    user * u = [[user alloc]init];
    u.comment = @"弹幕冲击！！！！";
    u.iconUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497620019834&di=1560d81c313ba6500826dad0e589dac7&imgtype=0&src=http%3A%2F%2Fi1.17173cdn.com%2F2fhnvk%2FYWxqaGBf%2Fcms3%2FIamCETbkyatmnmB.jpg";
    user * u1 = [[user alloc]init];
    u1.comment = @"弹幕冲击！！！！弹幕冲击！！！！";
    u1.iconUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497620019834&di=1560d81c313ba6500826dad0e589dac7&imgtype=0&src=http%3A%2F%2Fi1.17173cdn.com%2F2fhnvk%2FYWxqaGBf%2Fcms3%2FIamCETbkyatmnmB.jpg";
    user * u2 = [[user alloc]init];
    u2.comment = @"弹幕冲击！！！！弹幕冲击！！！！弹幕冲击！！！！";
    u2.iconUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497620019834&di=1560d81c313ba6500826dad0e589dac7&imgtype=0&src=http%3A%2F%2Fi1.17173cdn.com%2F2fhnvk%2FYWxqaGBf%2Fcms3%2FIamCETbkyatmnmB.jpg";
    user * u3 = [[user alloc]init];
    u3.comment = @"弹幕冲击！！！！";
    u3.iconUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497620019834&di=1560d81c313ba6500826dad0e589dac7&imgtype=0&src=http%3A%2F%2Fi1.17173cdn.com%2F2fhnvk%2FYWxqaGBf%2Fcms3%2FIamCETbkyatmnmB.jpg";
    user * u4 = [[user alloc]init];
    u4.comment = @"弹幕冲击！！！！";
    u4.iconUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497620019834&di=1560d81c313ba6500826dad0e589dac7&imgtype=0&src=http%3A%2F%2Fi1.17173cdn.com%2F2fhnvk%2FYWxqaGBf%2Fcms3%2FIamCETbkyatmnmB.jpg";
    user * u5 = [[user alloc]init];
    u5.comment = @"弹幕冲击！！！！";
    u5.iconUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497620019834&di=1560d81c313ba6500826dad0e589dac7&imgtype=0&src=http%3A%2F%2Fi1.17173cdn.com%2F2fhnvk%2FYWxqaGBf%2Fcms3%2FIamCETbkyatmnmB.jpg";
    
    //初始化弹幕管理者   并传入数据源
    _manager = [[BulletManager alloc] initWithDataSource: @[u,u1,u2,u3,u4,u5]];
    __weak typeof (self)weakSelf = self;
    self.manager.generateViewBlock = ^(BulletView *view){
        [weakSelf addBulletView:view];
    };
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 50, 50);
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton * stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [stopBtn setTitle:@"停止" forState:UIControlStateNormal];
    stopBtn.backgroundColor = [UIColor greenColor];
    [stopBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    stopBtn.frame = CGRectMake(200, 100, 50, 50);
    [stopBtn addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)stop{
    [_manager end];
}
-(void)start{
    [_manager start] ;
}
-(void)addBulletView:(BulletView *)view{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    view.frame = CGRectMake(width, 300 + view.dandao * 50, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    [self.view addSubview:view];
    [view startAnimate];
    
}
@end
