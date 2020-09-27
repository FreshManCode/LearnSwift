//
//  UIViewController+SWButtonFunctionIMP.h
//  LearnSwift
//
//  Created by 张君君 on 2020/9/25.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWButtonFunction.h"
#import "SWTestOCModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (SWButtonFunctionIMP) <SWButtonFunction>

/// 测试数据
- (NSMutableArray <SWTestOCModel *> *)testOCModelArray;

@end

NS_ASSUME_NONNULL_END
