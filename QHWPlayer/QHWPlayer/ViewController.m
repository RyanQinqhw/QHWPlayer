//
//  ViewController.m
//  QHWPlayer
//
//  Created by 秦宏伟 on 2018/3/15.
//  Copyright © 2018年 明镜止水. All rights reserved.
//

#import "ViewController.h"
#import "Q_PlayerView.h"
@interface ViewController ()
    @property (nonatomic, strong) UIView *fatherView;
    @property (nonatomic, strong) Q_PlayerView *playerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    [self.navigationController.navigationBar setTranslucent:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.fatherView];
    [self.fatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.leading.trailing.mas_equalTo(0);
        // 这里宽高比16：9,可自定义宽高比
        make.height.mas_equalTo(self.view.mas_width).multipliedBy(9.0f/16.0f);
    }];
    
    [self.fatherView addSubview:self.playerView];
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.fatherView);
    }];
    [self.playerView play];
    
    
}

-(Q_PlayerView *)playerView{
    if(!_playerView){
        _playerView = [Q_PlayerView new];
    }
    return _playerView;
}
    
-(UIView *)fatherView{
    if(!_fatherView){
        _fatherView = [UIView new];
        _fatherView.backgroundColor = [UIColor blackColor];
    }
    return _fatherView;
}

@end
