//
//  SWAppTools.h
//  LearnSwift
//
//  Created by 张君君 on 2020/10/26.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//视图底部弹出或者消失时间
static NSTimeInterval const kAnimationDuration = 0.35;


@interface SWAppTools : NSObject

+ (CGFloat)screenW;

+ (CGFloat)screenH;

@end

NS_ASSUME_NONNULL_END
