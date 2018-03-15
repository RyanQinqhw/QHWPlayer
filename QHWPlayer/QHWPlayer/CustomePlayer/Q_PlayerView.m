//
//  Q_PlayerView.m
//  QHWPlayer
//
//  Created by 秦宏伟 on 2018/3/15.
//  Copyright © 2018年 明镜止水. All rights reserved.
//

#import "Q_PlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import "Q_PlayerContentView.h"
@interface Q_PlayerView()

    //播放视频有关
    @property (nonatomic, strong) AVPlayer *player;
    @property (nonatomic, strong) AVPlayerLayer *playerLayer;
    @property (nonatomic, strong) AVPlayerItem *playerItem;
    @property (nonatomic, strong) AVURLAsset *urlAsset;
    //播放进度
    @property (nonatomic, assign) CGFloat progress;
    
    //内容view
    @property (nonatomic, strong) Q_PlayerContentView *contentView;
    
@end

@implementation Q_PlayerView

-(instancetype)init{
    if(self = [super init]){
        [self initPlayer];
        [self initPlayerContentView];
    }
    return self;
}
    
-(void)initPlayer{
    
//    NSURL *url = [NSURL URLWithString:@"http://cctv.cntv.dnion.com/cache/208_/seg0/index.m3u8?AUTH=cntv0002eioemwtj7gwZ8E/4A74SDHdpLlMcMi9X+PeRplbpDaNRWRwOKVJZIUMtTaYy1S2d/vq+uKxSwGq63i0LLDXlpx3mGgLHGA=="];
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_03.mp4"];
    AVURLAsset *asset = [AVURLAsset assetWithURL:url];
    self.playerItem = [AVPlayerItem playerItemWithAsset:asset];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect; //视频为填充模式
    self.backgroundColor = [UIColor blueColor];
    [self.layer addSublayer:self.playerLayer];
    
}
-(void)initPlayerContentView{
    self.contentView = [Q_PlayerContentView new];
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
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
//                self.player.rate = 1.5;//更改播放速率,播放的时候才生效
            }
            
            break;
            case AVPlayerItemStatusFailed:{
                NSSLog(@"播放失败");
            }
            break;
        }
    }
    if([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *array = [[self.player currentItem] loadedTimeRanges];
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];
        CGFloat startSecond = CMTimeGetSeconds(timeRange.start);//开始时间
        CGFloat durationSecond = CMTimeGetSeconds(timeRange.duration);//长度;
        NSTimeInterval totalBuffer = startSecond + durationSecond; //缓存时间;
        
        CMTime duration             = self.playerItem.duration;
        CGFloat totalDuration       = CMTimeGetSeconds(duration);
        
        self.progress = totalBuffer/ totalDuration;
        NSSLog(@"当前缓冲时间:%f",totalBuffer);
        NSSLog(@"当前缓冲百分比:%f",totalBuffer/totalDuration);
    }
    
    if([keyPath isEqualToString:@"playbackBufferEmpty"]){ //缓存器空,等待缓存数据 ,加载loading
        //加载loading
    }
    
    if([keyPath isEqualToString:@"playbackLikelyToKeepUp"]){ //缓存区有足够的数据播放视频, 消去loading
        //播放视频
        [self.player play];
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

-(void)dealloc{
    NSSLog(@"销毁view");
    //移除kvo 和 通知
}
    
@end
