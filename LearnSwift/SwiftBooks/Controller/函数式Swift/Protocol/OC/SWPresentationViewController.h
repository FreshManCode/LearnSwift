//
//  SWPresentationViewController.h
//  LearnSwift
//
//  Created by 张君君 on 2020/10/26.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWPresentationViewController : UIPresentationController

/// 设置Pop的View视图大小
@property (nonatomic, assign) CGFloat viewHeight;


/// 指定View高度的初始化方法
/// @param presentedViewController presentedViewController
/// @param presentingViewController presentingViewController
/// @param viewHeight 视图高度
- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                       presentingViewController:(UIViewController *)presentingViewController
                                     viewHeight:(CGFloat)viewHeight;

@end

NS_ASSUME_NONNULL_END
