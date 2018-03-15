//
//  Q_PlayerView.m
//  QHWPlayer
//
//  Created by 秦宏伟 on 2018/3/15.
//  Copyright © 2018年 明镜止水. All rights reserved.
//

#import "Q_PlayerView.h"
#import <AVFoundation/AVFoundation.h>

@interface Q_PlayerView()

    @property (nonatomic, strong) AVPlayer *player;
    @property (nonatomic, strong) AVPlayerLayer *playerLayer;
    @property (nonatomic, strong) AVPlayerItem *playerItem;
    
@end

@implementation Q_PlayerView

-(instancetype)init{
    if(self = [super init]){
        [self initPlayer];
    }
    return self;
}
    
-(void)initPlayer{
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"];
    self.playerItem = [AVPlayerItem playerItemWithURL:url];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
//    self.playerLayer.backgroundColor = [UIColor redColor].CGColor;
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect; //视频为填充模式
    self.backgroundColor = [UIColor blueColor];
    [self.layer addSublayer:self.playerLayer];
    
}
    
-(void)addObserverForPlayerItem{
    //播放状态
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //获取视频的缓存情况
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    // 缓冲区空了，需要等待数据 ---- 这里加载loading
    [self.playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    // 缓冲区有足够数据可以播放了 ---- 消除loading
    [self.playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
}
-(void)addNotification{
    
}
    
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if([keyPath isEqualToString:@"status"]){
        switch (self.playerItem.status) {
            case AVPlayerItemStatusUnknown:{
                
            }
            break;
            case AVPlayerItemStatusReadyToPlay:{
                [self.player play];
                self.player.rate = 1.5;//更改播放速率,播放的时候才生效
            }
            
            break;
            case AVPlayerItemStatusFailed:{
                NSSLog(@"播放失败");
            }
            break;
        }
    }
}
    

#pragma mark - layoutSubviews
//展示的时候,设置frame
- (void)layoutSubviews {
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
}
    
-(void)play{
    [self addObserverForPlayerItem];
}
    
@end
