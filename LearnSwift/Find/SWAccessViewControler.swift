//
//  SWAccessViewControler.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/9/2.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWAccessViewControler: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefaultData()
        
    }
    
    func p_initDefaultData()  {
        view.addSubview(tableView)
        self.title = "AccessControl(访问控制)";
        listArray.append("AccessControlBrief")
        listArray.append("AdvancedOperators")
        tableView.reloadData()
    }
    
    
    // MARK: - AccessControlBrief
    @objc  func AccessControlBrief()  {
        //1.Modules and Source Files
        //Swift的访问权限是基于组件和文件源的概念
        //Swift 对于代码中的实体类提供了不同的访问权限.这些访问权限与这些实体定义的文件源有关,也与这些文件所属的组件有关.
        //1.1 Open access and public access  允许实体实体可以在组件内定义的任何文件中可用.尤其是定义工具包的公共接口时
        //经常使用open 或者public访问权限.
        
        //1.2 Interal access 允许在定义组件的内部实体可以使用任何源文件,但是外部不行.尤其是在定义一个App或者工具包的内部框架时
        //使用Interal access
        
        //1.3 File-private access 限制了定义源文件本身实例类的使用.使用File-private access 当在整个文件中使用时 隐藏了特定功能的代码片段的实现细节.
        
        //1.4 Private access 限制了实体类只能在其封装的定义中使用,以及同一个文件的扩展中可用.
        
        //Open access 访问权限最高(限制最少),Private access 权限最低(限制最高).
        
        //Open access 仅仅可以应用于类和类成员变量,它与public access不同的是,允许基类继承并且进行重写.
        //把一个Class标记为open访问权限,意味着你已经考虑到使用这个类作为父类对代码造成的影响,并且你已经相应的设计了你自己类的代码.
        
        //2.Guiding Principle of Access Levels (访问权限的引导法则)
        //Swift的访问控制遵循一个总的法则:没有任何实体可以用一个比自己级别更低的实体来进行定义.
        //例如
        //1.公共变量不能定义为内部已经有的,文件私有的,或者私有的类型,因为这些类型在公共变量可以使用的地方不一定可用.
        //2.函数的访问权限不能高于它的参数或者返回类型的权限.
        
        
        //2.Default Access Levels
        //我们代码中的所有实体类(一些特别的类除外),如果没有明显设置访问权限,内部都会有一个默认的访问权限.
        //因此,在许多情况下并不需要在代码中显式指定访问权限.
        
        //2.1 Access Levels for Single-target Apps (单一目标App的访问权限)
        //当我们在简单的单一目标App内部编写代码时,这些代码大多是在App自己的内部使用,在App的模块外是不可用.
        //此时,默认的内部访问权限(interal access )已经满足了需求.
        
        //2.2 Access Levels for Frameworks
        //当在开发工具包时(framwork)时,这些标记为公共的开放接口,在App导入该工具包之后这些开放或者公共的接口就可以
        //被其他的组件访问和使用.
        
        
        //3.Access Control syntax
        //通过放置这些关键词中的一个(open,public,internal,fileprivate,private)在实体类声明之前,来定义这些实体访问级别.
//        public var somePublicVariable = 0
//        internal let someInteralContant = 0
//        fileprivate func someFilePrivateFunction(){}
//        private func somePrivateFunction(){}
        
        
        //4.Custom Types
        //类型的访问权限也影响了其成员的访问权限,(它的属性,方法,构造函数,以及下标语法等).如果你定义一个类型为private或者
        //file private,其成员的默认访问权限也将是private或者是file private.如果你定义一个访问权限为interal或者public,
        //该成员的默认访问权限为interal
        
        //注意:公共的类型默认有interal 成员,而不是公开的成员.如果想让类型的成员是公开的,必须显式进行标记.
        
        
        //5.Tuple Types
        //元组的访问权限是由组成元组的所有类型中限制最高的类型决定的.
        //注意:因为元组类型没有独立的定义,与类,结构体,枚举或者函数不同.
        //元组的访问权限是由组从元组的类型自动决定的,并且不能显式指定.
        
        
        //6.函数类型
        //函数类型的访问权限使用函数参数中以及返回类型中限制最严格的类型来评估.如果函数的评估类型与默认的语境一致,必须显式声明
        //函数的访问权限,作为定义的一部分.
        //someFunction() 函数如果不显示加上private 修饰词会编译错误.
        
        
        //7.枚举类型
        //在枚举实例中,枚举所有的case自动接收枚举所属的访问权限,不能在同一个枚举中给不同的case指定不同的访问权限.
        //如下例:
        
        
        //8.Subclassing 继承
        //子类不能比父类有更高的访问权限,例如,你不能把继承于internal的父类的子类声明为public
        //重写可以使得继承的子类的成员相对于父类更易获取.如下:
        
        
        //9.Constants ,variables,Peoperties,subscripts
        //如果常量,变量,属性或者下标想使用private类型,必须进行显式标记
        
        
        //10.Getters 和 setters
        //可以给setter方法一个较低的访问权限,用来限制变量的读写范围.通过在var或者subscript之前使用
        //fileprivate(set),private(set),或者internal(set),来设置setter的访问权限.
        var stringToEidt = TrackedString()
        stringToEidt.value = "ac"
        stringToEidt.value += "de"
        stringToEidt.value += "fg"
        print("the number of edits is \(stringToEidt.numberOfEdits)")
        //我们可以在别的文件中访问numberOfEdits属性,但是却无法在别的文件中修改该属性.
        //该限制就隐藏了其相关的实现细节.
    }
    
    // MARK: - AdvancedOperators
    @objc  func AdvancedOperators()  {
        //1.BitWise Operators (位运算符)
        //位操作运算符使得你可以在数据结构内操作单个的位数据.
        //1.1 BitWise Not Operator (~)反位运算符,按位进行取反操作
        //位取反运算符是前置运算符,中间没有任何空格
        let initialBits:UInt8 = 0b00001111
        let invertedBits = ~initialBits
        
//      转换成二进制的字符串输出
        print("\(String(invertedBits,radix: 2))")
        //11110000
        
        
        //1.2 Bitwise And Operator (位与运算符)
        //位运算符把两个数的位组合在一起.返回一个新的数字,如果对应的位都是1,则返回为1
        let numberOne:UInt8 = 0b11111100
        let numberTwo:UInt8 = 0b00111100
        let midFourBits = numberOne & numberTwo
        //00111100
        print("\(String(midFourBits,radix: 2))")
        
        //1.3 Bitwise Or Operator (位或运算符)
        //两个数字中对应的位,只要有一个为1,则运算后的结果就为1
        let orResult = numberOne | numberOne
        print("\(String(orResult,radix: 2))")
        //11111100
        
        //1.4 Bitwise XOR operator (位异或运算符)
        //把两个数字按位进行比较,如果对应位的数字相同,结果为0,否则为1
        let orAndResult = numberOne ^ numberTwo
        print("\(String(orAndResult,radix: 2))")
        //11000000
        
        //1.5 Bitwise left and right shift operators 左移以及右移运算符
        //左移或者右移运算符,一个数字的所有向左或者向右移动指定的位置,根据如下规则:
        //1.5.1 无符号整数的位移运算
        
        //1.根据需要把存在的位向左或者向右移动
        //2.任何超出整型范围的位被抛弃
        //3.在位向左或者向右移动的时候,往对应的方向的位置插入0
        //事例:
        //左移两个位置
        let leftShiftResult = numberTwo << 2
        print("\(String(leftShiftResult,radix: 2))")
        //00111100 左移两个位置之前
        //11110000 左移两个位置之后
        
        let rightShiftResult = numberOne >> 1
        //11111100 右移一个位置之前
        print("\(String(rightShiftResult,radix: 2))")
        //01111110 右移一个位置之后
        
        let pink:UInt32 = 0xCC6699
        //CC (R) ,66(B),99(B)
        let redComponenet  = (pink & 0xFF0000) >> 16
        let greenComponent = (pink & 0x00FF00) >> 8
        let blueComponent  = (pink & 0x0000FF)
        
        print("\(String(pink,radix: 2))")
        //1100 1100 0110 0110 1001 1001
        
        
        //2.Shifting Behavior for singed Integers (有符号整型的位移运算)
        //有符号整型的第一位是符号位用来表示是正数还是负数.符号位位0表示着是正数,为1表示着是负数
        //余下的位称为值位,存着着实际的值.正数的存储方式与无符号整型存储方式一样,从0开始计数.
        let int8_numberOne:Int8 = 0b00000100
        print("\(String(int8_numberOne,radix: 2))")
        //有符号整数,符号位0,余下7为是值位,数值为4
        
        //2.2 负数的存储方式就不同了.它们的值以减去2的n次方的绝对值,n代表着值的位数.例如:一个8位的有符号整数,值为就是7
       
        
        //3.Overflow Operators (内存溢出运算符)
        //例如:Int16 整型可以存储在-32768-32767 之间的数值.如果试着给一个常量或者变量设置的值不在这个范围内就会你内存溢出.
        var potentialOverflow = Int16.max
//        以下操作就会报错
//        potentialOverflow += 1
//1. &+ 溢出加法, &- 溢出减法, &* 溢出乘法
        
        //4.Value Overflow (值溢出)
        //下面是一个例子,让一个无符号的整数以正方向溢出
        var unsignedOverflow = UInt8.max
        print("unsignedOverflow is:\(unsignedOverflow)")
        //unsignedOverflow is:255 11111111
        unsignedOverflow = unsignedOverflow &+ 1
        print("newunsignedOverflow is:\(unsignedOverflow)")
        //newunsignedOverflow is:0 00000000
        
        //又是会出现类似的情况,比如无符号整数允许进行负方向的溢出操作,如下:
        var unsignedOverflow2 = UInt.min
        //00000000
        unsignedOverflow2 = unsignedOverflow2 &- 1
        //11111111
        
        
        //5.Precedence and Associativity (优先级和结和性)
        //1.不同优先级先考虑优先级
        //2.同优先级考虑结合性
        
        
        //6.Operator Methods
        //类和结构体可以对已经存在的运算符提供自己的实现.这被称作运算符的重载.
        //重载后的运算符可以直接对Vector2D的实例使用
        let vector = Vector2D(x: 3.0, y: 1.0)
        let anotherVectorr = Vector2D(x: 2.0, y: 4.0)
        let combinedVector = vector + anotherVectorr
        
        
        //7.Prefix and postfix Operators (前置和后置运算符)
        //上面的例子说明了一个自定义的二进制中缀运算符.类和结构体也可以提供标准的一元运算符,一元运算符对一个目标进行操作,
        //可以对目标进行前置或者后置运算.例如(b!)
        //注意:实现一元运算符的时候,当在定义一元运算符方法的时候,在func关键词前加上prefix或者postfix修饰符,
        
        let positive = Vector2D(x: 3.0, y: 4.0)
        let negative = -positive
        let alsoPositive = -negative
        
        
        //8.Compound Assignment Operators
        //组合赋值属性把= 和另一个操作符组合在一起.例如和"+"组合在一起,+=.把组合运算符左边的输入参数类型使用inout关键词,
        //因为,左边的参数值在操作方法的内部直接被修改了.
        var original = Vector2D(x: 1.0, y: 2.0)
        //point is:(1.0,2.0)
        original.printLog()
        let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
        original += vectorToAdd
        //point is:(4.0,6.0)
        original.printLog()
        
        //注意:不能去重载默认的赋值(==)运算符.仅仅可以重载组合赋值运算符,同时三元条件运算符也不能重载(a?b:C)
        
        
        //9.Equivalence Operators (等价运算符)
        //自定义等价运算符需要遵从Equatable协议
        //可以使用自定义的== 运算符来检查两个Vector2D的实例是否相等
        let twoThree = Vector2D(x: 2.0, y: 3.0)
        let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
        if twoThree == anotherTwoThree {
            print("These two vectors are equivalent")
        }
        
        //在许多情况下,可以让Swift合成这些等价运算符的实现.Swift对于下面的自定义类型提供了合成实现.
        //1.struct 中的属性都实现了 Hashable.
        //2.枚举中的泛型必须实现了 Hashable
        //3.枚举中无泛型
        //事例
        struct Vector3D:Equatable {
            var x = 0.0 ,y = 0.0, z = 0.0
        }
        let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
        let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
        if twoThreeFour == anotherTwoThreeFour {
            print("These two vectors are also equivalent")
        }
        
        
        //10. Custom Operators (自定义运算符)
        //除了Swift库提供的标准的运算符之外,可以自己定义运算符.
        //自定义的运算符使用operator关键字被声明为全局的,也可以使用Prefix,infix,postfix来进行标记.(前缀,中缀,后缀)
        
        var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
        var afterDoubling = +++toBeDoubled
        //point is:(2.0,8.0)
        afterDoubling.printLog()
        let afterHalfing = ---afterDoubling
        //point is:(1.0,4.0)
        afterHalfing.printLog()
        
        
        //11.Precedence for custom infix Operators (自定义中缀运算符的优先级)
        //下面的例子定义了一个新的中缀运算符名为 +-,属于AdditionPrecedence优先级组
        let firstVector = Vector2D(x: 1.0, y: 2.0)
        let secondVector = Vector2D(x: 3.0, y: 4.0)
        let plusMinusVector = firstVector +- secondVector

        
    }
    
    
    
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row], tableView: tableView);
    }
    
}

// MARK: - 3.Access Control syntax
public class SomePublicClass{}
internal class SomeInteralClass{}
fileprivate class SomeFilePrivateClass{}
private class SomePrivateClass{}

/// 隐式的 interal
class SomeDefaultInteralClass{}


// MARK: - 4.Custom Types
//显式声明为public
public class SomeCustomPublicClass {
    //显式声明成员变量
    public var somePublicProperty = 0
    //默认为interal
    var someInteralProperty = 0
    fileprivate func someFilePrivateMethod() {
        
    }
    private func somePrivateMethod() {
        
    }
}
class someCustomInteralClass {
    var someInteralProperty = 0
    fileprivate func someFilePrivateMethod() {}
    private func somePrivateMethod() {}
}

fileprivate class SomeCustomFilePrivateClass {
    func someFilePrivateMethod()  {
        
    }
    private func somePrivateMethod() {
        
    }
}
private class SomeCustomPrivateClass {
    func  somePrivateMethod()  {
        
    }
}

// MARK: - 函数类型
private func someFunction() ->(someCustomInteralClass,SomeCustomPrivateClass)  {
    return (someCustomInteralClass(),SomeCustomPrivateClass())
}

// MARK: - 7.枚举类型
public  enum CompassPoint {
    case north
    case south
    case east
    case west
}


// MARK: - 8.Subclassing 继承
public class A {
    
    /// 显式标记为private,如果想声明为私有变量
    private var privateInstance = 10
    fileprivate func someMethod(){}
}
internal class B:A {
    override internal func someMethod() {
        super.someMethod()
    }
}


// MARK: - 10.Getters 和 setters
struct TrackedString {
//  把numberOfEdits属性设置为只能通过TrackedString结构体内部修改,getter方法仍然是默认的internal访问权限.
//  这样numberOfEdits对外部展示的就是一个只读的属性.
    private(set) var numberOfEdits = 0
    var value:String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}


// MARK: - Operator Methods
struct Vector2D {
    var x = 0.0,y = 0.0
}
//先进行自定义操作符声明
prefix operator +++
prefix operator ---
//自定义+- 中缀运算符 ,属于AdditionPrecedence 优先级组
infix  operator +-:AdditionPrecedence
extension Vector2D  : Equatable{
    // 6.Operator Methods
    static func + (left:Vector2D,right:Vector2D)->Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
    //7.Prefix and postfix Operators (前置和后置运算符)
    static prefix func -(vector:Vector2D)->Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
    //8.Compound Assignment Operators
    static func += (left: inout Vector2D,right:Vector2D) {
        left = left + right
    }
    
    //9.Equivalence Operators (等价运算符) 先遵从Equatable协议,然后实现== 方法
    static func == (left:Vector2D,right:Vector2D)->Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
    
    
    //10. Custom Operators (自定义运算符)
    //自定义双倍运算符
    static prefix func +++ (vector:inout Vector2D)->Vector2D {
        vector += vector
        return vector
    }
    
    //自定义减半运算符
    static prefix func ---(vector:inout Vector2D)->Vector2D {
        vector = Vector2D(x: vector.x / 2.0, y: vector.y / 2.0)
        return vector
    }
    
    //中缀运算符
    static  func +- (left:Vector2D,right:Vector2D)->Vector2D  {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
    
    
    func printLog() {
        print("point is:(\(x),\(y))")
    }
}

