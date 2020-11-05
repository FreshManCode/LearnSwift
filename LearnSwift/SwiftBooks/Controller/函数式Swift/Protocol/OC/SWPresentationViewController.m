//
//  SWPresentationViewController.m
//  LearnSwift
//
//  Created by 张君君 on 2020/10/26.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

#import "SWPresentationViewController.h"
#import "SWAppTools.h"

@interface SWPresentationViewController ()

@property (nonatomic, strong) UIView *blackView;

@end

@implementation SWPresentationViewController


- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                       presentingViewController:(UIViewController *)presentingViewController
                                     viewHeight:(CGFloat)viewHeight {
    if (self = [super initWithPresentedViewController:presentedViewController
                             presentingViewController:presentingViewController]) {
        self.viewHeight = viewHeight;
    }
    return self;
}


/// 如果不指定Pop View的视图高度,默认为300 pt
/// @param presentedViewController presentedViewController
/// @param presentingViewController presentingViewController
- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                       presentingViewController:(UIViewController *)presentingViewController {
    
    return  [self initWithPresentedViewController:presentedViewController
                         presentingViewController:presentingViewController
                                       viewHeight:300.f];
}

// MARK: - 重写相关方法
- (void)presentationTransitionWillBegin {
    self.blackView.alpha = 0;
    [self.containerView addSubview:self.blackView];
    [UIView animateWithDuration:kAnimationDuration
                     animations:^{
        self.blackView.alpha = 1.f;
    }];
}

- (void)dismissalTransitionWillBegin {
    [UIView animateWithDuration:kAnimationDuration
                     animations:^{
        self.blackView.alpha = 0.f;
    }];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        [self.blackView removeFromSuperview];
    }
}

- (CGRect)frameOfPresentedViewInContainerView {
    return  CGRectMake(0,
                       [SWAppTools screenH] - self.viewHeight ,
                       [SWAppTools screenW],
                       self.viewHeight);
}


- (UIView *)blackView{
    if(!_blackView){
        _blackView = [UIView new];
        _blackView.frame = self.containerView.bounds;
        _blackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
    return _blackView;
}




@end
