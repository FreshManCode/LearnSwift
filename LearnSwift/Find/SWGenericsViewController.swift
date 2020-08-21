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
    
    mutating  func pop()->Element  {
        return items.removeLast()
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
        //事例1:使用非泛型版本的堆(stack)
        
        
        
        
        
        
        
        
        
        
        
        
    }
}
