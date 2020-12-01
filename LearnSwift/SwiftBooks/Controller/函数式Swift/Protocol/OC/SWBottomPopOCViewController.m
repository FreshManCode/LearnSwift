//
//  SWBottomPopOCViewController.m
//  LearnSwift
//
//  Created by 张君君 on 2020/10/26.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

#import "SWBottomPopOCViewController.h"
#import "SWAppTools.h"

@interface SWBottomPopOCViewController ()

@property (nonatomic, strong) UIButton *testButton;

@end

@implementation SWBottomPopOCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_initDefault];
    
}

- (void)p_initDefault {
    self.view.backgroundColor = [UIColor whiteColor];
    if (!_testButton) {
        _testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [_testButton setTitle:@"close" forState:UIControlStateNormal];
    [_testButton setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    _testButton.frame = CGRectMake(([SWAppTools screenW] - 120)/2.0, 40, 120, 40);
    [_testButton addTarget:self action:@selector(dismissEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_testButton];
}

- (void)dismissEvent:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


/// View高度
- (CGFloat)viewHeight {
    return  300.f;
}
@end
