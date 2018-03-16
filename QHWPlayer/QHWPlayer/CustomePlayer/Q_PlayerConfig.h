//
//  Q_PlayerConfig.h
//  QHWPlayer
//
//  Created by 秦宏伟 on 2018/3/16.
//  Copyright © 2018年 明镜止水. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum :NSUInteger {
    GradientDirectionTop = 0,  //渐变色从上到下
    GradientDirectionBottom ,   //渐变从下到上
}GradientDirection;

#define Q_PlayerBundleName @"Q_PlayerBundle.bundle"
#define Q_PlayerBundleImagePath(imageName) [Q_PlayerBundleName stringByAppendingPathComponent:imageName]
#define Q_PlayerBundleImage(imageName) [UIImage imageNamed:Q_PlayerBundleImagePath(imageName)]
