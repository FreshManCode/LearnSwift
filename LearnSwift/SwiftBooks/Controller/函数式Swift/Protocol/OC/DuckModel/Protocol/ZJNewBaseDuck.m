//
//  ZJNewBaseDuck.m
//  LearnSwift
//
//  Created by 张君君 on 2020/11/5.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

#import "ZJNewBaseDuck.h"

@implementation ZJNewBaseDuck

/// 鸭子的行为
- (void)duckAction {
    [self.duckModel swim];
    
    [self.duckModel quack];
}

@end
