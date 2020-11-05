//
//  SWAppTools.m
//  LearnSwift
//
//  Created by 张君君 on 2020/10/26.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

#import "SWAppTools.h"

@implementation SWAppTools

+ (CGFloat)screenW {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)screenH {
    return [UIScreen mainScreen].bounds.size.height;
}

@end
