//
//  SWItratorAndSequenceVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/10/10.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

//从概念上来说,一个迭代器是每次根据请求生成数组新元素的"过程".任何类型只要遵守以下协议,那么它就是一个协议.
protocol IteratorProtocol {
    associatedtype Element
    mutating  func next()->Element?
}

//例如,下文的迭代器会从数组的末尾开始生成序列值,一直到0.Element 的类型可以由方法next推断出来,不必显式指定:
struct ReverseIndexIterator:IteratorProtocol {
    var index:Int
    init<T>(array:[T]) {
        index = array.endIndex - 1
    }
    mutating func next() -> Int? {
        guard index >= 0 else {
            return nil
        }
        defer {
            index -= 1
        }
        return index
    }
}

//定义一个迭代器来生成"无数个"二的幂值(直到该值变为某个极大值,致使NSDecimalNumber 溢出)
struct PowerIterator:IteratorProtocol {
    var power:NSDecimalNumber = 1
    mutating func next() -> NSDecimalNumber? {
        power = power.multiplying(by: 2)
        return power
    }
}

extension PowerIterator {
    mutating  func find(where predicate:(NSDecimalNumber)->Bool)->NSDecimalNumber?  {
        while let x = next() {
            if predicate(x) {
                return x
            }
        }
        return nil
    }
}


struct FileLinesIterator:IteratorProtocol {
    let lines : [String]
    var currentLine:Int = 0
    init(fileName:String) throws {
        let content:String = try String(contentsOfFile: fileName)
        lines = content.components(separatedBy: .newlines)
    }
    mutating func next() -> String? {
        guard currentLine < lines.endIndex else {
            return nil
        }
        defer {
            currentLine += 1
        }
        return lines[currentLine]
    }
}

//构建一个迭代转换器,可以用参数中的Limit值来限制参数迭代器所生成的结果个数:
struct LimitIterator<I:IteratorProtocol>:IteratorProtocol {
    var limit = 0
    var iterator:I
    
    init(limit:Int,iterator:I) {
        self.limit = limit
        self.iterator = iterator
    }
    
    mutating func next() -> I.Element? {
        guard limit > 0 else {
            return nil
        }
        limit -= 1
        return iterator.next()
    }
}

extension Int {
    func countDown()->AnyIterator<Int>  {
        var i = self - 1
        return AnyIterator {
            guard i >= 0 else {
                return nil
            }
            defer {
                i -= 1
            }
            return nil
        }
    }
    
}

//我们甚至可以依据AnyIterator 来定义能够对迭代器进行操作和组合的函数.比如,我们可以拼接两个基础元素类型相同的迭代器
//代码如下:
func +<I:IteratorProtocol,J:IteratorProtocol>(first:I,sencond:J)->AnyIterator<I.Element> where I.Element == J.Element  {
    var i = first
    var j = sencond
    return AnyIterator{
        i.next() ?? j.next()
    }
}




class SWItratorAndSequenceVC: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "迭代器和序列"
        listArray.append("ConceptOfIterator")
        listArray.append("Sequence")
        view.addSubview(tableView)
    }
    
    // MARK: - ConceptOfIterator (迭代器相关概念)
    @objc  func ConceptOfIterator()  {
        //我们声明一个输入参数为数组的构造方法,然后使用数组的最后一个合法序列值初始化index
        let letters = ["A","B","C"]
        var iterator = ReverseIndexIterator(array: letters)
        while let i = iterator.next() {
            print("Element \(i) of the array is \(letters[i])")
        }
        /*
         Element 2 of the array is C
         Element 1 of the array is B
         Element 0 of the array is A
         */
        
        //2.我们可以使用PowerIterator 来检视增长中的大数组序列值
        //我们可以使用find方法来计算二的幂值中大于1000的最小值
        var powerIterator = PowerIterator()
        let result = powerIterator.find(where: {$0.intValue > 1000})
        print(result) //Optional(1024)
        
        //3.该迭代器会生成一组字符串,与某个文件中以行为单位的内容相对应
        //通过这种定义迭代器的方式,我们将数据的生成与使用分离开.生成过程可能会涉及到打开一个文件或是一个URL,
        //并且会处理过程中抛出的错误.将这些隐藏在一份简单的迭代器协议之后,可以确保使用代码去操作生成的数据时,
        //不必考虑这些问题.基于为迭代器定义的协议,我们还可以编写一些适用于所有迭代器的泛型函数.
        
        //4.在编写迭代器时,为每个迭代器引入一个新的结构体有时是一件很繁琐的事情.Swift提供了一个简单的AnyIterator<Element>
        //结构体,其中的元素类型是一个泛型.要初始化该结构体,既可以传入一个已有的迭代器,也可以传入一个next函数:
        //使用AnyIterator可以使我们更为简短地定义迭代器,比如,我们可以像下面的代码一样重写 ReverseIndexIterator:
    }
    
    // MARK: - Sequence 序列
    @objc func Sequence() {
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row], tableView: tableView);
    }
    
    
}
