//
//  SWGenericsViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/8/21.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

/// 使用非泛型的堆
struct IntStack {
    var items = [Int]()
    mutating func push(_ item : Int)  {
        items.append(item)
    }
    mutating func pop()->Int {
        return items.removeLast()
    }
}

/// 使用泛型的堆
struct Stack <Element> {
    var items = [Element]()
    mutating  func push(_ item: Element)  {
        items.append(item)
    }
    
    mutating  func pop()-> Element?  {
        if items.isEmpty {
            return nil
        }
        return items.removeLast()
    }
    
    var isEmpty:Bool {
        return items.isEmpty
    }
    
}


// MARK: - Extending a Generic Type (扩展泛型类型)
extension Stack {
    /// 该扩展中的计算属性现在可以在Stack 的实例对象中去访问获取该栈中最顶部的Item.
    var topItem:Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}


// MARK: - Associated Types
protocol Container {
//  使用一个关联的类型,来确保后面三个方法操作的Item相同
    associatedtype Item
    mutating func append(_ item:Item)
    var count:Int {get}
    subscript(i:Int)->Item{get}
}

/// 非泛型的遵从协议
struct IntStack2:Container {
    var items = [Int]()
    mutating func push(_ item:Int) {
        items.append(item)
    }
    mutating func pop()->Int {
        return items.removeLast()
    }
    
    
//  Container 协议中定义的,使用typealias 表明协议中定义的Item的类型是Int类型.
    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}


/// 泛型的遵从Container 协议
struct Stack2<Element>:Container {
    var items = [Element]()
    mutating func push(_ item:Element) {
        items.append(item)
    }
    mutating func pop()->Element {
        return items.removeLast()
    }
    
    //遵从Container 协议
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

// MARK: - Extending an existing Type to Specify an Associated Type (通过扩展类型来指定管理按类型)
extension Array:Container {
    
}

// MARK: - Adding Constraints to an associated type (对于关联值添加限制)
//遵从该协议的类型,必须遵从了Equatable协议
protocol Container2 {
    associatedtype Item:Equatable
    mutating func append(_ item:Item)
    var count:Int{get}
    subscript(i:Int)->Item {get}
}


// MARK: - Using a Protocol in Its Associated Type's Constraints
protocol SuffixableContainer:Container {
    associatedtype Suffix:SuffixableContainer where Suffix.Item == Item
    func suffix(_ size:Int) -> Suffix
}
extension Stack2:SuffixableContainer {
    func suffix(_ size: Int) -> Stack2 {
        var result = Stack2()
        for index in (count - size) ..< count {
            result.append(self[index])
        }
        return result
    }
}

// MARK: - Extensions with a generic Where Clause

//使用泛型的where语句作为扩展的一部分.如下所示:
extension Stack2 where Element:Equatable {
    func isTop(_ item:Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
    //注意:如果没有使用where语句,可能会导致这样一个问题,Stack2中的Item没有遵从Equatable协议,就会报一个编译错误.
    //对泛型使用where语句,允许对扩展添加新的要求,因为扩展添加的方法isTop(_:)仅仅当Stack2中的item是可比较的.
}


// MARK: - 对协议的扩展使用泛型where语句.如Container协议的扩展
extension Container2 where Item:Equatable {
    func startsWith(_ item:Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}

//使用泛型的where语句把item指定位特定类型: (把item指定为Double类型)
extension Container2 where Item == Double {
    func avarage() -> Double {
        var sum = 0.0
        for index in 0 ..< count{
            sum += self[index]
        }
        return sum / Double(count)
    }
}


// MARK: - Associated Types with a Generic Where Clause (关联类型使用泛型的where语句)
protocol ContainerAssociatedWhere {
    associatedtype Item
    mutating  func append(_ item:Item)
    var count:Int {get}
    subscript(i:Int)->Item {get}
    associatedtype Iterator:IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}


// MARK: - Generic Subscripts (泛型下标语法)
extension Container2 {
    subscript <Indices:Sequence>(indices:Indices)->[Item] where Indices.Iterator.Element == Int {
        var result = [Item]()
        for index in indices {
            result.append(self[index])
        }
        return result
    }
}





class SWGenericsViewController: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefaultData()
    }
    
    
    func p_initDefaultData() -> Void {
        self.title = "Generics(泛型)";
        listArray.append("GenericsIntroduction")
        listArray.append("AssociatedTypes")
        listArray.append("GenericWhereClauses")
        self.view.addSubview(self.tableView);
        tableView.reloadData()
    }
    
    
    // MARK: - Generics Introduction
    @objc  func GenericsIntroduction()  {
        //1.The problem that generics solve (泛型解决的问题类型)
        func swapTwoInts(_ a: inout Int,_ b: inout Int)  {
            let temporaryA = a
            a = b
            b = temporaryA
        }
        //该方法交换了a和b的值
        var someInt = 3
        var anotherInt = 107
        swapTwoInts(&someInt, &anotherInt)
        print("someInt is now\(someInt),and anotherInt is now\(anotherInt)")
        
        //该函数在交换两个整数的值非常实用,但是仅仅只能交互整数.如果想交互其他的类型呢?
        func swapTwoStrings(_ a: inout String,_ b: inout String)  {
            let temporaryA = a
            a = b
            b = temporaryA
        }
        
        //注意:以上两个方法除了参数的类型不同之外,其功能完全一样.
        //如果此时实用泛型,函数会更加灵活,因为如果上述方法中传入了不匹配的参数类型,会报编译错误.
        
        
        //2.Generic Functions (泛型函数可以处理任何类型.下面是一个新的交换两个变量值的函数.)
        func swapTwoValues<T> (_ a: inout T,_ b: inout T)  {
            let temporaryA = a
            a = b
            b = temporaryA
        }
        //泛型的版本;占位类型的T没有表明是什么类型,但是它表明a和b必须是相同的类型T;T实际的类型是什么,只有在每次调用该函数的时候才知道.
        //泛型函数和非泛型函数的区别是:在函数之后是否紧跟着名为T的占位类型并且使用<>包裹着.
        
        //现在swapTwoValues函数可以交换任意任意类型的变量,只要两个变量是同一个类型.
        //每次调用swapTwoValues(_:_:)的时候,便可以推断出其类型
        
        swapTwoValues(&someInt, &anotherInt)
        
        var someString = "1"
        var anotherString = "2"
        swapTwoValues(&someString, &anotherString)
        
        
        //3.Type Parameters (类型参数)
        //上述swapTwoValues(_:_:),占位类型T是一种类型参数.类型参数紧跟着函数名称之后,使用<>包裹起来.例如:<T>
        
        //4.Naming Type Parameters (命名类型参数)
        //注意:总是给类型参数使用大写开头的字母来命名,如T和MyType等来描述这是一个类型参数,而不是一个值.
        
        //5.Generic types (泛型类型)
        //除了泛型函数,swift允许自定义泛型类型.这些自定义的类,结构体,枚举可以处理任何类型像数组或者字典一样.
        //事例1:使用非泛型版本的堆(stack)  struct IntStack
        //事例2:使用泛型版本的堆
        var stackOfStrings = Stack<String>()
        stackOfStrings.push("uno")
        stackOfStrings.push("dos")
        stackOfStrings.push("tres")
        stackOfStrings.push("cuatro")
        
        let fromThePop = stackOfStrings.pop()
        
        
        //6.Extending a Generic Type (扩展泛型类型)
        //使用了扩展中的计算属性功能
        if let topItem = stackOfStrings.topItem {
            print("The top item on the stack is \(topItem)")
        }
        
        
        //7.Type Constraints (类型限制)
        //类型限制表明该类型参数必须从某个特定的class继承而来或者遵从一个特定的协议或者协议组合.
        //7.1 Type Constraints Syntax (类型限制语法)
        func someFunction <T:SWBaseViewController,U:SomePtorocol>(someT:T,someU:U)  {
            
        }
        //以上函数功能有两个类型参数.第一个类型参数T限制了类型需要是SWBaseViewController的一个子类
        //第一个参数U,限制了U需要SomePtorocol协议.
        
        //7.2 Type Constraints in Action (行为中的类型限制)
        //以下是一个名为findIndex(ofString:in:)的函数,用来给定一个字符串值并且找到在Array中的索引.
        func findIndex(ofString valueToFind:String,in array:[String]) -> Int?  {
            for (index,value) in array.enumerated() {
                if value == valueToFind {
                    return index
                }
            }
            return nil
        }
        
        let strings = ["cat","dog","llama","parakeet","terrapin"]
        if let foundIndex = findIndex(ofString: "llama", in: strings) {
            print("The index of llama is 2")
        }
        //The index of llama is 2
        
        //下面是一个泛型事例 ,如果未加上限制,会报错,因为 == 操作符实际上是遵从了Equatable协议才可以使用的,
//        func genericFindIndex<T>(of valueOf:T,in array:[T])->Int?  {
//            for (index,value) in array.enumerated() {
//                //在Swift中并不是每个类型都可以使用"=="进行比较
//                if value == valueOf {
//                    return index
//                }
//                return nil
//            }
//        }
        func genericFindIndex<T:Equatable> (of valueOfFind:T,in array:[T]) ->Int? {
            for (index,value) in array.enumerated() {
                if value == valueOfFind {
                    return index
                }
            }
            return nil
        }
        //T:Equatable 意味着任何类型T都遵从 Equatable协议.
        let doubleIndex = genericFindIndex(of: 9.3, in: [3.14,0.1,0.25])
        print("doubleIndex is \(doubleIndex)")
        //doubleIndex is nil
        let stringIndex = genericFindIndex(of: "Andrea", in: ["Mike","Malcolm","Andrea"])
        print("stringIndex is \(stringIndex)")
        //stringIndex is Optional(2)
    }
    
    // MARK: - Associated Types
    @objc  func AssociatedTypes()  {
        //1.Associated Types in Action
        //上述的Container 只要遵从该协议必须实现三个函数.
        //1.要实现append(_:)防范,用来添加新的item
        //2.必须能通过属性来获取该容器的item的数量值
        //3.必须能够通过下标获取相应的item
        /*
         以上操作必须保证item是同一种类型,为了达到这个目的,Container协议定义了一个名为Item的关联类型,被写作associated Item.
         该协议没有定义Item究竟是什么类型,具体什么类型由遵从该协议的类型提供.
         */
        
        
        //2.Extending an existing Type to Specify an Associated Type (通过扩展类型来指定管理按类型)
        //数组已经存在append(_:)方法以及下标方法,swift能推断出item的类型,就像上面使用泛型的Stack 类型一样.通过对Array使用这个扩展
        //,可以把数组当做Container
        
        
        //3.Adding Constraints to an associated type
        //如下:下面的代码版本定义了一个Container协议并且需要遵从该协议的item是可比较的
        //参见Container2协议
        
        
        //4.Using a Protocol in Its Associated Type's Constraints
        //协议可以作为它自身需求的一部分.如
        var stackOfInts = Stack2<Int>()
        stackOfInts.append(10)
        stackOfInts.append(20)
        stackOfInts.append(30)
        let suffix = stackOfInts.suffix(2)
        printLog(suffix)
        //Stack2<Int>(items: [20, 30])
        //在extension Stack2:SuffixableContainer 中,Suffix的关联类型对于Stack2来说也是Stack2,因此
        //在Stack2 的suffix操作返回了另一个Stack2.
    }
    
    // MARK: - Generic Where Clauses (泛型的where语句)
    @objc  func GenericWhereClauses()  {
        func allItemsMatch<C1:Container,C2:Container> (_ someContainer:C1,_ anotherContainer:C2) ->Bool where C1.Item == C2.Item,C1.Item:Equatable {
            if someContainer.count != anotherContainer.count {
                return false
            }
            for i in 0..<someContainer.count {
                if someContainer[i] != anotherContainer[i] {
                    return false
                }
            }
            return true
        }
        
        //以上函数对于函数中放置的两个类型参数有如下要求:
        //1.C1 必须遵守Container协议,写作: C1:Container
        //2.C2 必须遵守Container协议,写作: C2:Container
        //3.在C1中的item必须与C2中的item相同,写作: C1.Item == C2.Item
        //4.C1中的Item必须遵从Equatable协议,写作: C1.Item:Equatable
        
        //第一和第二个要求定义在函数的参数列表中,第三和第四要求定义在函数的泛型函数的where语句
        var stackOfStrings = Stack2<String>()
        stackOfStrings.push("abc")
        stackOfStrings.push("def")
        stackOfStrings.push("ghi")
        var arrayOfString = ["abc","def","ghi"]
        if allItemsMatch(stackOfStrings, arrayOfString) {
            print("All item match.")
        } else {
            print("Not all items match")
        }
        //All item match.
        
        
        //2.Extensions with a generic Where Clause (使用泛型where语句的扩展)
        if stackOfStrings.isTop("ghi") {
            print("Top element is ghi")
        } else {
            print("Top element is others")
        }
        //Top element is ghi
        
        //如果尝试在一个堆中的元素不是可比较的堆调用isTop(_:)方法,会得到一个编译错误,以下代码会报错
        struct NotEquable {
            
        }
        var notEqutableStack = Stack2<NotEquable>()
        let notEquableValue = NotEquable()
        notEqutableStack.push(notEquableValue)
//        notEqutableStack.isTop(notEquableValue)
        
        //2.也可以对于协议扩展使用泛型的where语句.如Container协议的扩展
        //extension Container2 where Item:Equatable
        
        //3.Associated Types with a Generic Where Clause (关联类型使用泛型的where语句)
        
        //4.Generic Subscripts (泛型下标语法)
        //下标语法也可以是泛型的,并且可以包含泛型的where语句.书写占位类型名在<>中紧跟着subscript关键词之后,同时书写泛型where语句在下标语法的
        //大括号之前.如
        
        
    }
    
    
}
