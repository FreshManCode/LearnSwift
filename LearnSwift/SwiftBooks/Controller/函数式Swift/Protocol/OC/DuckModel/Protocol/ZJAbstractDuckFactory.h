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

//抽象的鸭子模型工厂,
//也就是不知道传递过来的的鸭子模型的实例对象
@interface ZJAbstractDuckFactory : NSObject

/// 鸭子模型  (此时不用关心该鸭子模型到底是什么,只要遵守了鸭子模型的协议类即可.)
@property (nonatomic, strong) id <ZJDuckProtocol> duckModel;

/// 鸭子的行为
- (void)duckAction;




@end

NS_ASSUME_NONNULL_END
