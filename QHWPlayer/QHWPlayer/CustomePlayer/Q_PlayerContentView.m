//
//  Q_PlayerContentView.m
//  QHWPlayer
//
//  Created by 秦宏伟 on 2018/3/15.
//  Copyright © 2018年 明镜止水. All rights reserved.
//

#import "Q_PlayerContentView.h"

@interface Q_PlayerContentView()
    @property (nonatomic,strong) UIView *topView;
@end

@implementation Q_PlayerContentView

-(instancetype)init{
    if(self = [super init]){
        self.backgroundColor = [UIColor clearColor];
        [self addSubViewForContentView];
        [self addSubViewConstraint];
    }
    return self;
}
#pragma mark - 添加子控件
-(void)addSubViewForContentView{
    [self addSubview:self.topView];
}
#pragma mark - 添加控件约束
-(void)addSubViewConstraint{
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@50);
    }];
}
#pragma mark - 添加渐变色
-(void)addGradientColor{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(0, 1);
    layer.colors = @[(__bridge id)[[UIColor blackColor] colorWithAlphaComponent:0.5] .CGColor,
                          (__bridge id)[[UIColor grayColor]colorWithAlphaComponent:0.4].CGColor,
                          (__bridge id)[[UIColor grayColor]colorWithAlphaComponent:0.15].CGColor];
    
    // 颜色分割线
    layer.locations  = @[@(0.25), @(0.5), @(0.75)];

    [_topView.layer addSublayer:layer];
    layer.frame = _topView.bounds;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self addGradientColor];
    
}
    
-(UIView *)topView{
    if(!_topView){
        _topView = [UIView new];
        _topView.backgroundColor = [UIColor clearColor];
       
        
    }
    return _topView;
}

@end
