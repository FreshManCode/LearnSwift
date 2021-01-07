//
//  SWFunctionsViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/6/29.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//  Functions (函数)

import UIKit

class SWFunctionsViewController: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "函数"
        p_initDefaultData();
    }
    
    func p_initDefaultData() -> Void {
        self.view.addSubview(self.tableView);
        listArray.append("FunctionParametersAndReturnValues")
        listArray.append("OptionalTupleReturnTypes")
        listArray.append("FunctionsWithAnImplicitReturn")
        listArray.append("FunctionsArgumentsLabelsAndParameterNames")
        listArray.append("DefaultParameterValues")
        listArray.append("VariadicParameters")
        listArray.append("InOutParameters")
        listArray.append("FunctionTypes")
        listArray.append("Closures")
        listArray.append("Closures_CapturingValues")
        listArray.append("EscapingClosures")
        listArray.append("Autoclosures")
        tableView.reloadData()
    }
    
    
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row], tableView: tableView);
    }
    
    
    // MARK: - 函数
    @objc func FunctionParametersAndReturnValues() {
        //1. Functions Without Return Values (无返回值的函数)
        //.因为该函数无返回值,所以该函数可以不用包含->
        func greet(person:String) {
            print("This a function without return value")
        }
        //This a function without return value
        greet(person: "bac")
        //注意:函数的返回值可以忽略,但是如果一个函数定义的有返回值,返回值是必须有的,如果在一个有返回值的函数,尝试着在函数执行的底部
        //没有返回值,将会导致一个运行时错误.
        
        //2.Functions with Multiple Return Values (函数有多个返回值)
        //如果函数有多个返回值,使用元组来进行表示
        
        func findMax(array:[Int])->(min:Int,max:Int) {
            var currentMin = array[0]
            var currentMax = array[1]
            for value in array {
                if value < currentMin {
                    currentMin = value
                }
                else if value > currentMax {
                    currentMax = value
                }
            }
            return (currentMin,currentMax)
        }
        let result = findMax(array: [1,2,3,4,5,6,4,1])
        //min is:1 max is:6
        print("min is:\(result.min) max is:\(result.max)")
    }
    
    // MARK: - Optional Tuple Return Types (可选元组返回类型)
    @objc func OptionalTupleReturnTypes() {
        /* 如果函数的返回类型的这个元组有可能没有值,可以使用可选型元组类型来表示.
         通过在元组的括号后面放置一个?来实现." ()? ",例如(Int,Int)?,(String,Int,Bool)?
         可选型元组类型例如(Int,Int)?与元组包含的是可选型类型是不同的(Int?,Int?)
         使用可选型元组类型,整个元组是可选的,并不是元组中的每个值都是可选型的.
         */
        
        //为了解决空数组的安全问题,对于该函数的返回值使用了一个可选型的元组类型,当数组为空的时候返回值为nil
        func minMax(array:[Int]) ->(min:Int,max:Int)? {
            if array.isEmpty {
                return nil
            }
            var currentMin = array[0]
            var currentMax = array[0]
            for value in array {
                if value < currentMin {
                    currentMin = value
                }
                else if value > currentMax {
                    currentMax = value
                }
            }
            return (currentMin,currentMax)
        }
        //(min: 1, max: 5)
        print(minMax(array: [1,2,3,4,5]) ?? [])
        //nil
        print(minMax(array: []) as Any)
        
        //2.可以使用可选型绑定来检查函数的函数是一个元组值或者是nil
        if let bounds = minMax(array: [8,-6,19,20,9,0]) {
            print("min is \(bounds.min) and max is \(bounds.max)")
        }
    }
    
    // MARK: - Functions With An Implicit Return 函数隐式返回
    @objc func FunctionsWithAnImplicitReturn() {
        //1.如果函数体是一个单一的表达式,该函数隐式返回这个表达式.如下示例:
        func greeting(for person:String) -> String {
            "Hello," + person + "!"
        }
        //Hello,KangKang!
        print(greeting(for: "KangKang"))
        //该函数的完整定义是:返回它问候的信息.任何像上述函数功能的代码均可以省略return 关键词.
    }
    
    // MARK: - Functions Arguments Labels And Parameter Names (函数参数标签和参数名)
    @objc func FunctionsArgumentsLabelsAndParameterNames() {
        /* 每个函数参数都有一个标签名和一个参数名.标签名在我们调用函数的时候使用,参数名在函数体中使用.通常,参数使用参数名作为它们的标签名.
         */
        func someFunction(firstParameterName:Int,secondParameterName:Int) {
            
        }
        someFunction(firstParameterName: 1, secondParameterName: 2)
        
        //1.Spcecifying Argument Labels (指定参数标签)
        //可以在参数名之前通过空格给其一个标签名:
        func someFunction2(argumentLabel parameterName:Int) {
            
        }
        //请看下例:
        func greet(person:String,from hometown:String)-> String {
            return "Hello \(person)! glad you visit from\(hometown)"
        }
        print(greet(person: "礼拜", from: "唐朝"))
        
        //2.Omitting Argument Lables (省略参数标签)
        //如果不想要一个参数的标签名,使用_来代替这个参数的标签名
        func someFunction3(_ firstParameter:Int,secondParameter:Int) {
            
        }
        someFunction3(2, secondParameter: 4)
        //如果一个参数有标签,那么当你调用该参数的时候会用到该标签.
    }
    
    // MARK: - Default Parameter Values 默认参数值
    @objc func DefaultParameterValues() {
        /* 可以通过在定义函数的是给参数赋值一个默认的值.如果有默认值,那么调用该函数的时候该参数值可以忽略.
         */
        func someFunction(parameterWithoutDefault:Int,parameterWithDefault:Int = 12) {
            print("parameterWithoutDefault is:\(parameterWithoutDefault) parameterWithDefault is:\(parameterWithDefault) ")
        }
        //parameterWithoutDefault is:10 parameterWithDefault is:0
        someFunction(parameterWithoutDefault: 10, parameterWithDefault: 0)
        
        //parameterWithoutDefault is:15 parameterWithDefault is:12
        someFunction(parameterWithoutDefault: 15)
    }
    
    // MARK: - Variadic Parameters (不定个数的参数)
    @objc func VariadicParameters()  {
        /* 不定参数个数接受0个或者多个特定类型的值.使用不定参数意味着当调用该函数时,可以传递多个数值.
         使用 ... 在参数的类型名之后.
         
         传递在不定参数的值在函数体中是一个可用的合适类型的数组.例如,一个名为 numbers 并且是Double类型的参数,在函数体中
         numbers 就是一个包含了Double类型常量的数组.
         */
        func arithmeticMean(_ numbers:Double ...) -> Double {
            var total:Double = 0
            for number in numbers {
                total += number
            }
            return total / Double(numbers.count)
        }
        
        print(arithmeticMean(1,2,3,4,44))
        print(arithmeticMean(4,56))
    }
    
    // MARK: - In Out Parameters (参数的输入和输出)
    @objc func InOutParameters()  {
        /* 通常情况下在函数的参数值是常量.如果在函数体中修改参数的值,将会报运行时错误.如果想要修改参数的值,
         需要在函数运行结束之后改变其存储方式,我们把这种参数定位in-out 参数.
         
         通过在参数类型前放置inout 关键词.一个in out参数的值传递到函数中,可以由函数修改,并且最终传递出去取代原始值.
         
         注意:仅仅可以在in out参数里面传递百年来那个.不能传递常量或者字符参数,因为常量和字符是不能修改的.
         在调用函数的传递参数的时候,在参数之前放置&符号,这样就意味着该函数可以修改其值.
         
         注意:in out参数不能有默认值,不定个数参数也不能使用in out关键词 ,如下事例:
         简单的交互两个参数的值
         */
        func swapTwoInts(_ a:inout Int, _ b:inout Int) {
            let tempA = a
            a = b
            b = tempA
        }
        var a  = 10
        var b  = 20
        //a is:10 b is:20
        print("a is:\(a) b is:\(b)")
        swapTwoInts(&a, &b)
        //a is:20 b is:10
        print("a is:\(a) b is:\(b)")
        
        //通过以上的例子看书,即使变量a和b是在函数之外定义的,执行完之后,a和b的值发生了交换,说明已经修改了参数的原始值.
        
        //注意:in out参数和一个具有返回值的函数不同.上述函数没有定义一个返回类型或者返回值,但是仍然修改了参数的值.
        //in out参数方式是一个在函数内部修改外部变量的另一种方式.
    }
    
    // MARK: - Function Types 函数类型
    @objc func FunctionTypes()  {
        //1.Using Function Types (使用函数类型)
        //可以给一个常量或者变量一个函数类型并且赋值一个适当的函数类型
        func addTwoInts(_ a:Int, _ b:Int) -> Int {
            return a + b
        }
        var mathFunction :(Int,Int)-> Int = addTwoInts
        
        //以上的代码可理解为:定义一个名为mathFunction的变量,该变量是一个带有两个int类型的参数并且返回int类型值的函数.并且
        //把函数名为 addTwoInts 的值赋给该变量
        //addTwoInts(_:_:) 函数和mathFunction变量有相同的类型,因此在swift类型检查中是允许的.
        print(mathFunction(2,3))
        
        
        //2.Function Types as Parameter Types (函数类型作为参数类型)
        func printMathResult(_ mathFuntion:(Int,Int)->Int,_ a: Int,_ b:Int) {
            print("result:\(mathFunction(a,b))")
        }
        //result:8
        printMathResult(addTwoInts, 3, 5)
        //说明:printMathResult(_:_:_:) 该函数有3个参数.第一个参数叫做mathFuntion,是一个(Int,Int)->Int类型.
        //对于第一个参数可以传递任何功类型的函数.第二和第三个参数是int.
        
        //3.Function Type as Return Types (函数类型作为返回类型)
        //可以使用一个函数类型作为另一个函数类型的返回类型.通过在返回函数的返回箭头(->)之后跟着另一个函数类型
        //如下例子:
        func stepForward(_ input:Int) ->Int {
            return input + 1;
        }
        
        func stepBackward(_ input:Int) ->Int {
            return input - 1;
        }
        
        //看如下函数,返回类型是一个 (Int)->Int
        func chooseStepFunction(backward:Bool) -> (Int)->Int {
            return backward ? stepBackward : stepForward
        }
        
        var currentValue = 3
        let moveNearToZero = chooseStepFunction(backward: currentValue > 0)
        
        while currentValue != 0 {
            print("currentValue is:\(currentValue)")
            currentValue = moveNearToZero(currentValue)
        }
        print("Zero")
        /*
         currentValue is:3
         currentValue is:2
         currentValue is:1
         Zero
         */
    }
    
    // MARK: - Closures 闭包
    @objc func Closures()   {
        //Closure Expressions 闭包表达式
        //1.The sorted Method ,如下事例:
        let names = ["WangWei","LiBai","KangKang","Alex","Ewa","Barray","Dani","dani"]
        //sorted(by:) 方法接收一个包含两个和数组一样类型参数的闭包,并且返回一个bool类型的值;
        //一旦排序之后,第一个值在第二个值之前或者之后.
        //如果想要第一个值在第二个值之前返回true,否则闭包内部返回false
        //1.方法一:用正常的函数来提供这个排序的比好,并且把该函数传递到sorted(by:)方法中:
        func backward(_ s1:String,_ s2:String) -> Bool {
            return s1 > s2
        }
        //如果 s1 > s2 返回true,意味着s1 排在s2之前.按照ASCII码来.
        //字符s1比s2大的意思是,ASCII码比较大.也就意味着 B > A
        //reversedNames is:["dani", "WangWei", "LiBai", "KangKang", "Ewa", "Dani", "Barray", "Alex"]
        var reversedNames = names.sorted(by: backward)
        print("reversedNames is:\(reversedNames)")
        
        //2.Closure Expresson Syntax
        /*
         { (parameter) -> return type in
            
            statements
         }
         
         闭包表达式中的参数可以是in-out 参数,但是不能有默认值.如果你定义了不定个数参数,不定个数参数也可以使用.
         元组既可以作为参数类型也可以作为返回类型.
         */
        reversedNames = names.sorted(by: { (s1:String, s2:String) -> Bool in
            return s1 < s2;
        })
        //reversedNames is:["Alex", "Barray", "Dani", "Ewa", "KangKang", "LiBai", "WangWei", "dani"]
        print("reversedNames is:\(reversedNames)")
        //注意:闭包的结构中包含in 关键词.该关键词表示着闭包的参数和返回值已经完成了,闭包的内部代码可以执行了
        
        //3.Inferring Type From Context  从语境中推断类型
        //当传递一个闭包到一个函数或者方法中作为一个内部的闭包表达式时,很容易推断出参数以及返回类型.\
        //因此,如果作为以上用途时,不需要写出闭包的完整形式,
        reversedNames = names.sorted(by: { s1,s2  in
            return s1 < s2
        })
        
        //4.Implicit Returns from Single-Expresson Closures (隐式返回单一表达式的闭包)
        //单一表达式的闭包可以通过忽略声明时的return关键词来隐式返回其结果.如下事例:
        reversedNames = names.sorted(by:{s1,s2 in s1 < s2})
        
        
        //5.Shorthand argument Names (简写参数名)
        /**Swift 在闭包的内部自动提供了参数名的简写形式,可以通过$0,$1$2等来引用相关参数
         如果在闭包表达式中使用了简写参数名形式,可以忽略闭包中的它定义的参数,并且简写形式的参数类型可以推断出来.
         in 关键词也可以省略,因为闭包表达式完全由其自身组成.如下:
         */
        reversedNames = names.sorted(by: {$0 > $1})
        //$0,$1 引用的是闭包中的第一个和第二个string参数
        
        //6.Operator Methods (运算符方法)
        //实际上有更便捷的方法来表述上面的闭包.
        reversedNames = names.sorted(by: >)
        
        //7.Trailing Closures 尾闭包
        /*如果你在函数的最后一个参数传递一个闭包并且闭包表达式很长,此时可以用尾闭包来代替.当使用尾闭包语法的时候,不需要写出作为函数部分调用的闭包参数的标签名
         
         */
        func someFunctionThatTakesAClosure(closure:()->Void) {
            
        }
        someFunctionThatTakesAClosure {
            
        }
        /* 如果一个闭包表达式以函数或者方法唯一的参数并且是尾闭包表达式时,在调用函数的时候,不需要在函数名称之后加上()
         */
        reversedNames = names.sorted {$0 > $1}
        
        
        /// 把数组中包含的数字转换为对应的英文数字
        let digitNames = [0:"Zero",1:"One",2:"Two",3:"Three",4:"Four",5:"Five",6:"Six",7:"Seven",8:"Eight",9:"Nine"]
        let numbers = [16,58,510]
        
        let strings = numbers.map { (number) -> String in
            var num = number
            var outPut = ""
            repeat {
                outPut = digitNames[num % 10]! + outPut
                num /= 10
            } while num > 0
            return outPut
        }
        //strings is:["OneSix", "FiveEight", "FiveOneZero"]
        print("strings is:\(strings)")
    }
    
    // MARK: - Capturing Values 闭包的值捕获
    @objc func Closures_CapturingValues() {
        /* 闭包可以从定义的上下文捕获变量或者常量.
         在Swift中最简单捕获值的闭包形式就是嵌套函数.在一个函数体重嵌套另一个函数.一个嵌套函数可以捕获任何嵌套在上层函数外部的参数,也可以
         捕获该函数中定义的内部参数.
         如下事例:
         */
        func makeIncrementer(forIncrement amount:Int)->()->Int {
            var runningTotal = 0
            func incrementer() -> Int {
                runningTotal += amount
                return runningTotal
            }
            return incrementer
        }
        /*
         函数makeIncrementer的返回类型是 ()->Int.意味着返回的是一个函数类型,而不是一个简单值类型.
         
         通过引用捕获确保了在makeIncrementer函数执行完成之前,runningTotal,amount 参数不会被回收.并且确保了runningTotal变量
         在下次调用incrementer 函数的时候也是可用的.
         */
        let incrementByTen = makeIncrementer(forIncrement: 10)
        print(incrementByTen())
        print(incrementByTen())
        print(incrementByTen())
        //10  20  30
        let incrementBySeven = makeIncrementer(forIncrement: 7)
        print(incrementBySeven())
        //7
        /* 注意:如果你在一个Class中的实例创建了一个闭包属性,并且该闭包通过引用捕获了其成员变量,那么你在闭包和类实例之间创建了一个强引用.
         */
        
        //2.Closures Are Reference Types (闭包作为引用类型)
        /* 在上面的例子中,incrementBySeven以及incrementByTen 都是常量,但是这些闭包中的常量仍然可以对捕获的runningTotal 变量进行加法操作.这是因为函数和闭包是引用类型.
         当你给一个常量或者变量赋值函数或者闭包类型时,实际上是让该常量或者变量引用该函数或者闭包.上面的例子中,闭包选择的是对incrementByTen
         常量进行引用,而不是闭包其本身.
         
         这也就意味着如果你把一个闭包赋值到两个不用的常量或者变量,这些变量或者常量引用的是一个闭包.
         */
        let alsoIncrementByTen = incrementByTen
        //40
        print(alsoIncrementByTen())
        
        //50
        print(incrementByTen())
        
        //上面说明了,调用alsoIncrementByTen函数与调用incrementByTen函数是一样的.因为他们引用的是同一个闭包.
    }
    
    // MARK: - Escaping Closures (逃逸闭包)
    @objc func EscapingClosures () {
        // 闭包可以逃逸的一种方式是存储一个变量在函数之外.如下:
        var completionHandlers :[()->Void] = []
        func someFunctionWithEscapingClosure(completionHandler:@escaping ()->Void) {
            completionHandlers.append(completionHandler)
        }
        
    }
    
    // MARK: - Autoclosures 自动闭包
    @objc func Autoclosures() {
        /* 自动闭包是一个能自动创建一个作为函数参数传递的表达式.
         下面的代码展示闭包怎样延迟执行.
         */
        var customersInLine = ["Chris","Alex","Ewa","Barry","Daniella"]
        //5
        print(customersInLine.count)
        
        let customerProvider = {customersInLine.remove(at: 0)}
        //5
        print(customersInLine.count)
        //Now servingChris!
        print("Now serving\(customerProvider())!")
        //4
        print(customerProvider().count)
        
        /* 虽然 customersInLine 数组中的第一个元素在闭包中被移除了,但是数组直到该闭包被调用的时候才移除该元素.
         如果该闭包一直没调用,里面的表达式也一直不调用,也就是数组中的元素会一直没变化.
         */
        
        //2.在一个函数的参数中传递闭包也可以得到延迟执行的功能
        func serve(customer customerProvider:()->String) {
            print("Now serving\(customerProvider())!")
        }
        //Now servingEwa!
        serve(customer: {customersInLine.remove(at: 0)})
        
        //下面的例子执行相同的功能,它需要一个用autoclosure关键词标记的属性
        func serve2(customer customerProvider:@autoclosure()->String) {
            print("Now serving\(customerProvider())!")
        }
        //Now servingBarry!
        serve2(customer: customersInLine.remove(at: 0))
    }
}

