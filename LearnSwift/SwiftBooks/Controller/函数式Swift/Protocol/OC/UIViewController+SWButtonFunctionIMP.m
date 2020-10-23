//
//  UIViewController+SWButtonFunctionIMP.m
//  LearnSwift
//
//  Created by 张君君 on 2020/9/25.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

#import "UIViewController+SWButtonFunctionIMP.h"
#import <SCLAlertView.h>

@implementation UIViewController (SWButtonFunctionIMP)

- (void)doCollectWithItemID:(nonnull NSString *)itemID {
    SCLAlertView *alertView = [SCLAlertView new];
    NSString * text = [NSString stringWithFormat:@"收藏的itemID:%@",itemID];
    [alertView showSuccess:self
                     title:@"收藏操作"
                  subTitle:text
          closeButtonTitle:@"知道了"
                  duration:0];
}

- (void)doFavorWithItemID:(nonnull NSString *)itemID {
    SCLAlertView *alertView = [SCLAlertView new];
    NSString * text = [NSString stringWithFormat:@"点赞的itemID:%@",itemID];
    [alertView showSuccess:self
                     title:@"点赞操作"
                  subTitle:text
          closeButtonTitle:@"知道了"
                  duration:0];
}



- (NSMutableArray *)testOCModelArray {
    NSMutableArray *tempArray = [NSMutableArray new];
    for (int i = 1; i < 16; i ++) {
        NSString * name = [NSString stringWithFormat:@"这个水果拼盘看起来还是很好的 id是:%@",@(i)];
        SWTestOCModel *model = [SWTestOCModel new];
        model.name = name;
        model.IDNumber = @(i).stringValue;
        [tempArray addObject:model];
    }
   return tempArray;

}

@end
