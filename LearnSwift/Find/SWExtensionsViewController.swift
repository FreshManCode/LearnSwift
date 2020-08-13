//
//  SWExtensionsViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/8/11.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWExtensionsViewController: SWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefaultData();
    }
    

    func p_initDefaultData() -> Void {
        self.title = "Extensions";
        listArray.append("ExtensionsIntroduce")
        listArray.append("ExtensionsUse")
        self.view.addSubview(self.tableView);
        tableView.reloadData()
    }
    
    // MARK: - Extensions Introduce
    @objc  func ExtensionsIntroduce()  {
        /* 扩展可以对已经存在的类,结构体,枚举或者协议类型添加新的功能.这包含了你对无法获取源代码的Class扩展器功能类型.
         与OC中的Category类似,但是扩展没有名字.
         Swift中的扩展有以下功能:
         1.增加计算实例属性和计算类型属性.
         2.定义实例方法和类型方法.
         3.提供新的初始化方法.
         4.定义和使用新的嵌套类型.
         5.使存在的类型遵从某个协议
         
         注意:扩展可以给一个类型添加新的函数功能,但是不能覆写已经存在的功能.
         */
        
        //1.Extension Syntax (扩展语法) 如下定义
//        extension UIColor {
//
//        }
        
        //2.扩展可以遵从一个或者多个协议,如下:
//        extension SomeType : Protocol1,Protocol2 {
//
//        }
    }
    
    // MARK: - ExtensionsUse
    @objc func ExtensionsUse()  {
        //1.Computed Properties
        //扩展可以对已经存在的类型添加计算实例属性和计算类型属性.如Extensions.swift 中的Double extension
        let oneInch   = 25.4.mm
        print("OneInch is \(oneInch) meters")
        let threeFeet = 3.ft
        print("Three feet is \(threeFeet) meters")
        
        
        //2.Initializers
        //可以通过扩展来给Rect结构体实现一个需要中心点和size初始化参数的函数
        let defaultRect = Rect()
        let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
        
        //通过extension 扩展的初始化函数来创建实例
        let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
        //注意:如果通过扩展新增了初始化函数,必须要确保一旦初始化函数完成的时候,每个实例都完全初始化了.
        
        
        //3.Methods
        //扩展可以对已经存在的类型添加实例或者类型方法.
        //对于Extensions中添加的Int扩展方法,我们使用如下:
        3.repetitions {
            print("Hello!")
        }
        //Hello!
        //Hello!
        //Hello!
        
        
        //4.Mutating Instance Methods
        var someInt = 3
        someInt.square()
        print(someInt)
        
        
        //5.Subscripts 
        //通过扩展,为int类型添加了一个从右边开始获取指定index索引的数字
        print(18238393[0]) //3
        print(18238393[3]) //8
        print(18238393[5]) //2
        //如果指定的index大于该整型的长度,那么返回的数字是0
        print(18238393[10]) //0
        
        
        //6.Nested Types
        func printInterKinds(_ numbers:[Int])  {
            for number in numbers {
                switch number.kind {
                case .negative:
                    print("_ ",terminator:"")
                case .positive:
                    print("+ ",terminator:"")
                default:
                    print("0 ",terminator:"")
                }
            }
            print("")
        }
        printInterKinds([3,19,-20,0,-6]) //+ + _ 0 _
        
    }

}
 



