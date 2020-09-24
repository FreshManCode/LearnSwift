//
//  SWMapFilterReduceVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/9/16.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWMapFilterReduceVC: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MapFilterReduce"
        listArray.append("Introduce")
        listArray.append("Filter")
        listArray.append("Reduce")
        listArray.append("ActualApplication")
        listArray.append("GenerailAndAnyTypes")
        view.addSubview(tableView)
        tableView.reloadData()
        
    }
    
    // MARK: - 泛型介绍
    @objc  func Introduce()  {
        
        func increment(array:[Int])->[Int]  {
            var result = [Int]()
            for item in array {
                result.append(item + 1)
            }
            return result
        }
        
        func double(array:[Int])->[Int]  {
            var result = [Int]()
            for item in result {
                result.append(item * 2)
            }
            return result
        }
        
        /* 接受其它函数作为参数的函数有时被称为高阶函数.
         泛型介绍:
         如下两个对于数组操作的函数:一个对于数组中的每一项进行+1操作,另一个是*2倍操作
         这两个函数都大量的相似代码,能否进行抽象出来呢?写出一个更加通用的函数?这样的函数需要追加一个新参数来接受一个参数,这个
         
         2.参数能根据各个数组项计算得到新的整型数值:如下:compute(_:,_:)函数
         
         3.代码仍然不是想象中的那么灵活,假设我们想得到一个布尔型的新数组,由于表示原数组中对应的数字是否是偶数.
         如:isEven;然而会报类型问题,因为compute 函数接受一个(Int)->(Int)类型的参数,也就说,该参数是一个返回整型值的函数.
         而isEven函数中,传递了(Int)->(Bool)类型的参数,于是导致了类型错误.
         
         如果说重新定义新版本的compute(array:action:)函数,接受一个(Int)->(Bool)类型的参数作为参数.
         如:compute2(array:action:)函数,但是这个方案的扩展性并不好.如果需要计算String类型呢?
         此时我们可以使用泛型,泛型函数的定义与compute是相同的,唯一不同的是类型签名(type signature).
         
         */
        func compute(array:[Int],action:(Int)->(Int))->[Int]  {
            var result = [Int]()
            for item in array {
                result.append(action(item))
            }
            return result
        }
        
        func compute2(array:[Int],action:(Int)->(Bool))->[Bool]  {
            var result = [Bool]()
            for x in array {
                result.append(action(x))
            }
            return result
        }
        
        
        //泛型函数
        func genericCompute<T>(array:[Int],action:(Int)->(T))->[T]  {
            var result = [T]()
            for x in array {
                result.append(action(x))
            }
            return result
        }
        
        //泛型函数,使用了Array的扩展
        func genericCompute2<T>(array:[Int],action:(Int)->(T))->[T]  {
            return array.map2(action)
        }
        
        func double2(array:[Int])->[Int]  {
            return compute(array: array) { (item) -> (Int) in
                return item * 2
            }
        }
        //与上述功能是一样的,尾闭包返回形式
        func double3(array:[Int])->[Int]  {
            return compute(array: array, action: {$0 * 2})
        }
        
//        func isEven(array:[Int])->[Bool]  {
//            return compute(array: array) { (item) -> (Int) in
//                return item % 2 == 0
//            }
//        }
        
    }
    
    // MARK: - Filter
    @objc  func Filter()  {
        let examplesFiles = ["Readme.md","Hellowodld.swift","FlappyBird.swift"]
        func getSwiftFiles(in fiels:[String])->[String]  {
            var result = [String]()
            for file in examplesFiles {
                if file.hasSuffix(".swift") {
                    result.append(file)
                }
            }
            return result
        }
        
        //现在可以使用getSwiftFiles取得examplesFiles数组中的Swift文件.
        //假如我们想查找没有扩展名的所有文件,或者是名字字符串"Hello"开头的文件,该怎么处理?
        //为了进行一个这样的查找,我们可以定义一个名为filter的通用型函数.就像之前看到的map那样,filter函数接受一个函数
        //作为参数.filter函数的类型是(Element)->Bool,对于数组中的所有元素,此函数都会判定它是否应该被包含在结果中:
        
        //现在根据filter2函数,可以很方便的定义getSwiftFiles函数
        func getSwiftFiles2(in files:[String])->[String]  {
            return files.filter2 { (file) -> Bool in
                return file.hasSuffix(".swift")
            }
        }
    }
    
    
    // MARK: - Reduce
    @objc  func Reduce()  {
        //1.在定义一个泛型函数来实现一个更常见的模式之前,先考虑一些相关简单的函数.
        //1.1 定义一个计算数组中所有整型值之和的函数非常简单:
        func sum(integers:[Int])->Int  {
            var result = 0
            for value in integers {
                result += value
            }
            return result
        }
        
        //1.2 连接数组中的所有字符串:
        func concatenate(strings:[String]) ->String  {
            var result = ""
            for strig in strings {
                result += strig
            }
            return result
        }
        
        //这些函数有什么共同点?都将变量result初始化为某个值.然后对输入数组的每一项进行遍历,最后以某种方式更新结果.
        //为了定义一个可以提现所需类型的泛型函数,我们需要对两份信息进行抽象:赋给result变量的初始值,和用于在每一次
        //循环中更新result的函数.
        
        //现在我们可以使用reduce2来定义出现的相关函数
        func sumUsingReduce(integers:[Int])->Int  {
            return integers.reduce2(0, combine: {
                result,x in result + x
            })
        }
        
        func squareUsingReduce(integers:[Int])->Int  {
            return integers.reduce2(0) { (result, x) in
                return result + x * x
            }
        }
        
        func addCharUsingReduce(chars:[String])->String  {
            return chars.reduce2("") { (result, char) -> String in
                return result + char
            }
        }
        
        //10
        print(sumUsingReduce(integers: [1,2,3,4]))
        //30
        print(squareUsingReduce(integers: [1,2,3,4]))
        //abcdef
        print(addCharUsingReduce(chars: ["a","b","c","d","e","f"]))
    }
    
    // MARK: - Actual Application (实际运用)
    @objc  func ActualApplication()  {
        let paris = MyCity(name: "Paris", population: 2241)
        let madrid = MyCity(name: "Madrid", population: 3165)
        let amsterdam = MyCity(name: "Amsterdam", population: 827)
        let berlin = MyCity(name: "Berlin", population: 3562)
        let cities = [paris,madrid,amsterdam,berlin]
        
        //现在可以使用filterm,map,reduce这些函数来实现自己的需求
        let result = cities.filter2({$0.population > 1000})
            .map({$0.scalingPopulation()})
            .reduce("City:Populcation", {result,c in
                return result + "\n"+"\(c.name):\(c.population)"
            })
        print(result)
//        Paris:2241000
//        Madrid:3165000
//        Berlin:3562000
}
    
    // MARK: - GenerailAndAnyTypes (泛型和Any类型)
    @objc  func GenerailAndAnyTypes()  {
        /* 除了泛型,Swift还支持Any类型,它能代表任何类型的值.
         泛型可以用于定义灵活的函数,类型检查仍然由编译器负责;而Any类型则可以避开Swift的类型系统(所以尽可能避免使用)
         
         */
    }
    
    
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row], tableView: tableView);
    }
    
}


//对于map2函数,使用Array的扩展 (其实并不需要我们自己去写,因为map函数已经是Swift标准库中的一个函数了)
extension Array {
    //Element 类型源于Swift的Array中对Element所进行的泛型定义.
    func map2<T>(_ transform:(Element)->T) -> [T] {
        var result = [T]()
        for x in self {
            result.append(transform(x))
        }
        return result
    }
    
    func filter2 (_ transform:(Element)->Bool) -> [Element] {
        var result = [Element]()
        for x in self where transform(x){
            result.append(x)
        }
        return result
    }
    
    //定义下述reduce函数来实现赋给result变量的初始值,和用于在每一次循环中更新result的函数.
    //该函数的泛型体现在两个方面:对于任意[Element]类型的输入数组来说,它会计算一个类型为T的返回值.这么做的前提是,首先需要一个
    //T类型的初始值,以及一个用于更新for循环中变量值的函数combine:(T,Eelement)->T.
    func reduce2<T>(_ initial:T,combine:(T,Element)->T)->T  {
        var result = initial
        for x in self {
            result = combine(result,x)
        }
        return result
        
    }
}

struct MyCity {
    let name :String
    let population :Int
}
extension MyCity {
    func scalingPopulation()->MyCity  {
        return MyCity(name: name, population: population * 1000)
    }
}
