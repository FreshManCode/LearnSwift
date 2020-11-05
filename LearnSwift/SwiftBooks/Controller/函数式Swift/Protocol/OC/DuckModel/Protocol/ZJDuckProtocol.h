//
//  ZJDuckProtocol.h
//  LearnSwift
//
//  Created by 张君君 on 2020/11/5.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//  定义了一个鸭子模型,只定义了接口的声明,没有对应的实现

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZJDuckProtocol <NSObject>

@optional;

/**
 呱呱叫
 */
- (void)quack;

/**
 游泳
 */
- (void)swim;

@end

NS_ASSUME_NONNULL_END
