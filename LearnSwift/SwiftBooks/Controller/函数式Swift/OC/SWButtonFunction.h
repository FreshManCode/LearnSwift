//
//  SWButtonFunction.h
//  LearnSwift
//
//  Created by 张君君 on 2020/9/25.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

/* OC中协议的作用:声明一些方法/接口,让其他类去遵守,
 作用:如果一个类遵守了某个协议,就应该实现这个协议中定义的必须要实现的方法.任何类只要遵守了Protocol,就相当于拥有了Protocol的所有方法声明.
 
 协议和继承的区别:
 1.继承之后默认就有实现,但是Protocol只有声明没有实现.
 2.相同类型的类可以使用继承,但是不同类型的类只能使用协议.
 3.Protocol 可以用于存储方法的声明可以将多个类中共同的方法抽取出来,以后让这些类遵守协议即可.
 
 注意:
 1.协议只能声明方法,不能声明属性
 2.父类遵守了某个协议,子类也会自动遵守这个协议.
 3.在OC中一个类可以遵守一个或者多个协议.
 
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SWButtonFunction <NSObject>

/// 点赞 操作
/// - Parameter itemID: 商品ID
- (void)doFavorWithItemID:(NSString *)itemID;


/// 收藏操作
/// - Parameter itemID: 商品ID
- (void)doCollectWithItemID:(NSString *)itemID;

@end

NS_ASSUME_NONNULL_END
