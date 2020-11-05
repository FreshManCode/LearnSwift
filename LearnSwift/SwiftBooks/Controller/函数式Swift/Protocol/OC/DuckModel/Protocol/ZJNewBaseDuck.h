//
//  ZJNewBaseDuck.h
//  LearnSwift
//
//  Created by 张君君 on 2020/11/5.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJDuckProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJNewBaseDuck : NSObject

/// 鸭子模型
@property (nonatomic, strong) id <ZJDuckProtocol> duckModel;


/// 鸭子的行为
- (void)duckAction;


@end

NS_ASSUME_NONNULL_END
