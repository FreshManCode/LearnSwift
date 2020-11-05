//
//  UIViewController+SWPresentationTools.h
//  LearnSwift
//
//  Created by 张君君 on 2020/10/26.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SWBottomPopOCViewController;

@interface UIViewController (SWPresentationTools) <UIViewControllerTransitioningDelegate>

@property (nonatomic, copy) NSMapTable  * mapTable;

- (void)bottomPresentation:(Class )controllerClass;


- (void)bottomPresentedVC:(SWBottomPopOCViewController *)presentedVC;


@end

NS_ASSUME_NONNULL_END
