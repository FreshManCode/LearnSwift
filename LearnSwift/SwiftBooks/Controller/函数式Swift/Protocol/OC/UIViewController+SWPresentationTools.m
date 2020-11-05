//
//  UIViewController+SWPresentationTools.m
//  LearnSwift
//
//  Created by 张君君 on 2020/10/26.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

#import "UIViewController+SWPresentationTools.h"
#import "SWPresentationViewController.h"
#import "SWBottomPopOCViewController.h"
#import <objc/runtime.h>


static NSString * const kMapKey = @"kMapContainerKey";

@implementation UIViewController (SWPresentationTools)

- (void)bottomPresentation:(Class )controllerClass {
    id instance = [controllerClass new];
    [self bottomPresentedVC:instance];
}

- (void)bottomPresentedVC:(SWBottomPopOCViewController *)presentedVC {
    NSAssert([presentedVC isKindOfClass:[UIViewController class]], @"参数类型有误,需要UIViewController相关类型");
    if (![presentedVC isKindOfClass:[UIViewController class]]) {
        return;
    }
    presentedVC.modalPresentationStyle = UIModalPresentationCustom;
    presentedVC.transitioningDelegate  = self;
    [self presentViewController:presentedVC animated:true completion:nil];
}



- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    CGFloat viewH = 300.f;
    if ([presented isKindOfClass:[SWBottomPopOCViewController class]]) {
        viewH = [(SWBottomPopOCViewController *)presented  viewHeight];
    }
    
    NSString *hashKey = [self keyWithPresentedVC:presented presentingVC:presenting];
    
    SWPresentationViewController *presentationVC = [self.mapTable objectForKey:hashKey];
    if (!presentationVC) {
        presentationVC = [[SWPresentationViewController alloc]
                          initWithPresentedViewController:presented
                          presentingViewController:presenting
                          viewHeight:viewH];
        [self.mapTable setObject:presentationVC forKey:hashKey];
    }
    return presentationVC;
}

- (void)setMapTable:(NSMapTable *)mapTable {
    objc_setAssociatedObject(self, &kMapKey, mapTable, OBJC_ASSOCIATION_COPY);
}

- (NSMapTable *)mapTable {
    NSMapTable *mapTable = objc_getAssociatedObject(self, &kMapKey);
    if (!mapTable) {
        mapTable = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory
                                             valueOptions:NSPointerFunctionsStrongMemory
                                                 capacity:0];
        self.mapTable = mapTable;
        return mapTable;
    }
    return mapTable;
}


- (NSString *)keyWithPresentedVC:(UIViewController *)presented
                    presentingVC:(UIViewController *)presenting {
    NSString *hashKey = [NSString stringWithFormat:@"%lu_%lu",presented.hash,presenting.hash];
    return  hashKey;
}

@end
