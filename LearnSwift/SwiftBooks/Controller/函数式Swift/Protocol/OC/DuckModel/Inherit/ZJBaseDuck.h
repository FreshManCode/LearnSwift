//
//  ZJBaseDuck.h
//  LearnSwift
//
//  Created by 张君君 on 2020/11/5.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//  继承模式的基类 (基类鸭子)

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseDuck : NSObject

//定义了鸭子的两个基本行为,一个是呱呱叫,一个是游泳
//不知道子类鸭子具体的行为,有可能只会叫不会游泳,有可能既会游泳又会呱呱叫,
//此时父类只能对此行为进行空载,利用面向对象多态的特性,让子类重载其行为.

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
