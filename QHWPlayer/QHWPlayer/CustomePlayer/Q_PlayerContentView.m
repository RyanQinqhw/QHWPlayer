//
//  Q_PlayerContentView.m
//  QHWPlayer
//
//  Created by 秦宏伟 on 2018/3/15.
//  Copyright © 2018年 明镜止水. All rights reserved.
//

#import "Q_PlayerContentView.h"

@interface Q_PlayerContentView()
    //上边view以及属性
    @property (nonatomic, strong) UIView *topView;
    @property (nonatomic, strong) CAGradientLayer *topLayer;
    @property (nonatomic, strong) UIButton *backBtn;
    
    //下边导航
    @property (nonatomic, strong) UIView *bottomView;
    @property (nonatomic, strong) CAGradientLayer *bottomLayer;
    @property (nonatomic, strong) UIButton *fullScreenBtn;
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
    [self addSubview:self.bottomView];
    
    //topSubView添加到topView
    [self.topView addSubview:self.backBtn];
    [self.bottomView addSubview:self.fullScreenBtn];
}
#pragma mark - 添加控件约束
-(void)addSubViewConstraint{
    //上面导航约束
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@50);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@40);
        make.left.equalTo(self.topView.mas_left).offset(10);
        make.top.equalTo(self.topView.mas_top).offset(3);
    }];
    
    //下面导航约束
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@50);
        make.left.right.bottom.equalTo(self);
    }];
    
    [self.fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@40);
        make.right.equalTo(self.bottomView.mas_right).offset(-3);
        make.bottom.equalTo(self.bottomView.mas_bottom).offset(-3);
    }];
}
#pragma mark - 添加渐变色
-(void)addGradientColor{
   
    self.topLayer.frame = _topView.bounds;
    self.bottomLayer.frame = _bottomView.bounds;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self addGradientColor];
    
}

#pragma mark -上边导航及控件
-(UIView *)topView{
    if(!_topView){
        _topView = [UIView new];
        _topView.backgroundColor = [UIColor clearColor];
        CAGradientLayer *layer = [self gradientLayerColor:[UIColor blackColor] andDirection:GradientDirectionTop];
        [_topView.layer addSublayer:self.topLayer = layer];
    }
    return _topView;
}

-(UIButton *)backBtn{
    if(!_backBtn){
        _backBtn = [[UIButton alloc] init];
        [_backBtn setImage:Q_PlayerBundleImage(@"Q_Player_back_full") forState:UIControlStateNormal];
    }
    return _backBtn;
}

#pragma mark -下边导航及控件
-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor clearColor];
        CAGradientLayer *layer = [self gradientLayerColor:[UIColor blackColor] andDirection:GradientDirectionBottom];
        [_bottomView.layer addSublayer:self.bottomLayer = layer];
    }
    return _bottomView;
}
-(UIButton *)fullScreenBtn{
    if (!_fullScreenBtn) {
        _fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenBtn setImage:Q_PlayerBundleImage(@"Q_Player_fullscreen") forState:UIControlStateNormal];
    }
    return _fullScreenBtn;
}
    
-(CAGradientLayer *)gradientLayerColor:(UIColor *)color andDirection:(GradientDirection) direction{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.startPoint = CGPointMake(0, direction);
    layer.endPoint = CGPointMake(0, 1 - direction);
    layer.colors = @[(__bridge id)[color colorWithAlphaComponent:0.5] .CGColor,
                     (__bridge id)[color colorWithAlphaComponent:0.4].CGColor,
                     (__bridge id)[color colorWithAlphaComponent:0.3].CGColor,
                     (__bridge id)[color colorWithAlphaComponent:0.2].CGColor,
                     (__bridge id)[color colorWithAlphaComponent:0.1].CGColor];
    
    // 颜色分割线
    layer.locations  = @[@(0.2), @(0.4), @(0.6),@(0.8),@(1.0)];

    return layer;
}
    
@end
