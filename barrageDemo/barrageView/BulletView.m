//
//  BulletView.m
//  barrageDemo
//
//  Created by 王俊钢 on 2017/11/4.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "BulletView.h"
#import "user.h"
#define kPadding 10     //图文间隔
#define kPhotoHeight 30  //照片款高度
#define kViwHeight 30   //view高度
@interface BulletView()
@property(nonatomic,strong)UILabel * lbComment;
@property(nonatomic,strong)UIImageView * phtotoView;
@end

@implementation BulletView
-(UILabel *)lbComment{
    if(!_lbComment){
        _lbComment = [[UILabel alloc] initWithFrame:CGRectZero];
        _lbComment.font = [UIFont systemFontOfSize:14];
        _lbComment.textColor = [UIColor whiteColor];
        _lbComment.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_lbComment];
    }
    return _lbComment;
}
-(UIImageView *)phtotoView{
    if(!_phtotoView){
        _phtotoView = [[UIImageView alloc] init];
        _phtotoView.clipsToBounds = YES;
        _phtotoView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_phtotoView];
    }
    return _phtotoView;
}
//重写model的set方法
-(void)setModel:(user *)model{
    //求出文字实际高度
    NSDictionary * attr = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    CGFloat width = [model.comment sizeWithAttributes:attr].width;
    self.bounds = CGRectMake(0, 0, width + 2 * kPadding + kPhotoHeight, kViwHeight);
    //设置头像
    self.lbComment.text = model.comment;
    self.lbComment.frame = CGRectMake(kPadding + kPhotoHeight, 0, width, kViwHeight);
    
    self.phtotoView.layer.borderColor = [UIColor greenColor].CGColor;
    self.phtotoView.layer.borderWidth = 1;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.iconUrl]];
    UIImage * image = [UIImage imageWithData:data];
    if(image){
        self.phtotoView.image = image;
    }else{
        self.phtotoView.image = [UIImage imageNamed:@"123.jpeg"];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor redColor];
    self.layer.cornerRadius = kViwHeight/2;
    self.layer.masksToBounds = YES;
    self.phtotoView.frame = CGRectMake(0, 0, kPhotoHeight, kPhotoHeight);
    self.phtotoView.layer.cornerRadius =(kPhotoHeight)/2;
    
}
//开始动画
-(void)startAnimate{
    //更具弹幕长度执行弹幕效果
    CGFloat scrennWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat duration = 4.0f;
    CGFloat wholeWidth = scrennWidth + CGRectGetWidth(self.bounds);
    if(self.moveStatusBlock){
        self.moveStatusBlock(start);
    }
    CGFloat speed = wholeWidth / duration;
    CGFloat enterDuration = self.bounds.size.width/speed;
    [self performSelector:@selector(EnterScreen) withObject:nil afterDelay:enterDuration];
    __block CGRect frame = self.frame;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        frame.origin.x -= wholeWidth;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if(self.moveStatusBlock){
            self.moveStatusBlock(end);
        }
    }];
}
//进入动画
-(void)EnterScreen{
    if(self.moveStatusBlock){
        self.moveStatusBlock(enter);
    }
}
//结束动画
-(void)endAnimate{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

@end

