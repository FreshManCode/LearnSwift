//
//  SWButtonFunction.h
//  LearnSwift
//
//  Created by 张君君 on 2020/9/25.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//  ZJBKDuckModelVC

/*  iOS编程官方现在提供了两种语言:
 1.O-C:Objective-C ,官方最早推出的iOS编程语言
 2.Swift ,后续苹果官方推出的,相对于OC来说更加简洁(API简洁明了),强大,安全(强类型语言).
 3.先简单介绍一下OC语言,然后再介绍一下Swift
 
 1. O-C面向对象的语言
 说到面向对象的语言,就不得不说,面向对象语言的基本特点.:
 面向对象的三大特点：继承、封装、多态，其中继承的最大优点就是代码复用。但是很多时候继承如果没有限制很可能会被滥用，造成代码结构散乱，分散到各个类中，如果想要做功能迁移，可能会拔出萝卜带出泥，高耦合也是继承无法避免的问题。另外，后期维护困难，如果新人加入项目，那么掌握各个父类中的功能也是一项不小的成本。
 对于这些大家应该都比较了解,就不多做介绍,下面接入今天的正题, iOS面向协议的编程.
 
 可能对于不了解iOS语言特性的同学就比较困惑了,只知道面向接口编程,难道iOS比较特殊?并不是iOS比较特殊,而是因为准确的
 来说iOS语言中没有接口这一概念,不像Java提供了Interface关键词.难道iOS就不能使用如此强大的功能了?
 那肯定不是的,不然写出来的代码不乱糟糟的一团了.
 iOS 中的协议 (Protocol) 可以理解为接口，面向接口编程即面向协议编程。下面就来具体看看iOS中的面向协议编程,
 具体等同于你们所熟悉的面向接口编程.
 
 
 2.面向对象比较重要的一个特点就是继承,也是使用比较多的一个特点.下面来简单看下继承和协议(接口)的使用.
 我这里定义了一个鸭子基类ZJBaseDuck,给其赋予了 quack (呱呱叫),swim (游泳)两个基本行为,当动物鸭和橡皮鸭都继承了
 ZJBaseDuck类之后,拥有了父类里面的行为.(使用继承能够提高代码复用),有时候,子类并没有满足父类的基本行为,此时子类
 需要重写父类的行为(多态的行为.)
 
 
 3.我们使用面向协议(接口)的方式来实现此特点.
 在这里定义了协议(接口) ZJDuckProtocol,里面定义了几个行为的抽象接口,没有实现.
 此时 ZJNewAnimalDuck与 ZJNewRubberDuck 具有了🦆模型中的相关行为,并且和鸭子基类 ZJBaseDuck没有任何关系.
 这就说明和ZJBaseDuck 类不再耦合的同时也具备了鸭子模型中的行为.


 4.继承的多态和面向接口相比
 不同对象以自己不同的方式响应相同的消息的能力叫做多态，就如上述例子中，ZJAnimalDuck 对 - quack 的重写。
 
 4.1通过上面的例子能看出继承的写法存在的几个问题:
 >1.父类关于基类中声明的方法可能需要空载,对于父类没有任何意义.
 >2.如果在开发中,一个同学负责父类,别的同学负责实现子类.那么负责子类的同学可能会比较困惑,哪些方法需要覆盖加,
 哪些不需要覆盖.如果出现了子类没有重写该方法,父类对外提供的只是一个空方法,会出现想不到的问题.
 
 4.2: 相对于继承的写法,面向接口的写法有如下几个优势: 如 ZJNewBaseDuck 父类中:
 >1.父类中将不会再出现空载方法。
 >2.需要覆盖的重载的方法，不用出现在父类的声明中，而是放在接口中去实现。
 >3.子类如果引入了其他的逻辑，通过协议的控制，引入的逻辑很容易被剥离.
 */

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
