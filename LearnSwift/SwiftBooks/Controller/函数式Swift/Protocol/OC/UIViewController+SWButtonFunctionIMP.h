//
//  UIViewController+SWButtonFunctionIMP.h
//  LearnSwift
//
//  Created by 张君君 on 2020/9/25.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//  用来实现UIViewController 类中,SWButtonFunction 协议的方法

#import <UIKit/UIKit.h>
#import "SWButtonFunction.h"
#import "SWTestOCModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (SWButtonFunctionIMP) <SWButtonFunction>

/// 测试数据
- (NSMutableArray <SWTestOCModel *> *)testOCModelArray;

@end

NS_ASSUME_NONNULL_END
