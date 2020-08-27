//
//  OpaqueTypesViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/8/25.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class OpaqueTypesViewController: SWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefaultData()
    }
    

    func p_initDefaultData() -> Void {
        self.title = "OpaqueTypes(不透明类型)";
        listArray.append("TheProblemThatOpaqueTypesSolve")
        self.view.addSubview(self.tableView);
        tableView.reloadData()
    }
      
    // MARK: - The Problem That Opaque Types Solve (不透明类型解决的问题)
    @available(iOS 13.0.0, *)
    @objc  func TheProblemThatOpaqueTypesSolve()  {
        //1. 事例1
        let smallTriangle = Triangle(size: 3)
        printLog(smallTriangle.draw())
        
        //2.事例2 泛型事例
        let flippedTriangle = FlippedShape(shape: smallTriangle)
        print(flippedTriangle.draw())
        //***
        // **
        // *
        let joinedTriangles = JoinedShape(top: smallTriangle, bottom: flippedTriangle)
        print(joinedTriangles.draw())
        // *
        // **
        //***
        //***
        // **
        // *
        
        
        //3.Returning an Opaque Type
        struct Square:Shape {
            var size : Int
            func draw() -> String {
                let line = String(repeating: "*", count: size)
                let result = Array<String>(repeating: line, count: size)
                return result.joined(separator: "\n")
            }
        }
        
        //返回一个不透明类型 (任何遵守了Shape的类型都可以返回)
        func makeTrapezoid() -> some Shape  {
            let top = Triangle(size: 2)
            let middle = Square(size: 2)
            let bottom = FlippedShape(shape: top)
            let trapeZoid = JoinedShape(top: top, bottom: JoinedShape(top: middle, bottom: bottom))
            return trapeZoid
        }
        let trapezoid = makeTrapezoid()
        print(trapezoid.draw())
        
        //4.Combine opaque return types (不透明类型组合)
        func flip <T:Shape>(_ shape:T)->some Shape  {
            return FlippedShape(shape: shape)
        }
        func join <T:Shape,U:Shape>(_ top:T,_ bottom:U)->some Shape  {
            return JoinedShape(top: top, bottom: bottom)
        }
        
        let opaqueJoinedTriangles = join(smallTriangle, flip(smallTriangle))
        print(opaqueJoinedTriangles)
        
        
        //5.Differences between opaque types and protocol types (不透明类型和协议类型的区别)
        //返回一个不透明类型与使用协议类型作为返回值看起来很像,但是这种返回类型代表的类型本身是不同的.
        //不透明类型引用一种特定的类型即使函数的调用者也不能看到具体的类型
        //协议类型可以引用任何遵从该协议的类型.
        
        //使用协议类型作为返回值
        func protoFlip<T:Shape> (_ shape:T) ->Shape  {
            return FlippedShape(shape: shape)
        }
        
        func protoFlip2<T:Shape>(_ shape:T) ->Shape  {
            if shape is Square {
                return shape
            }
            return FlippedShape(shape: shape)
        }
        
        let protoFlippedTrianggle = protoFlip2(smallTriangle)
        let sameThing = protoFlip2(smallTriangle)
        
//        返回的协议类型,无法使用"==" 进行比较.
//        protoFlippedTrianggle == sameThing
        /*注意:
         1.使用协议作为函数的返回值给我们很大的灵活性,任何遵循该协议的类型均可.然而,这样灵活性的代价就是一些操作不能在返回值上进行.
         上面的例子说明, == 操作符就不可用.因为 == 依赖具体的类型信息,但是协议类型并没有保存.
         
         2.这种方法的另一个问题就是Shape变换不能嵌套.三角形的一个 flipping的结果是一个Shape类型,以及protoFlip2(_:)函数需要一个遵从了
         Shape类型的参数.然而,一个协议类型并没有遵从Shape协议,因为protoFlip2(_:)的返回值没有遵从Shape协议.这就意味着像protoFlip2(protoFlip2(smallTriangle))这种多次变换就是无效的,因为里面的参数是无效的.
         3.相反,不透明类型保存了基本类型的本体.Swift可以推断出关联类型,也就是允许你使用一个不透明类型来代替协议类型不能使用的返回值.
         如下:ContainerOpaque
         不能使用ContainerOpaque作为函数的返回类型,因为它有一个关联值,同时也不能使用它作为一个泛型返回类型的约束,因为在函数体外部没有
         足够的信息可以推断出需要什么样的泛型类型.
         
         */
//        func makeProtocolContainer <T>(item:T)->ContainerOpaque  {
//            return [item]
//        }
//        func makeProtocolContainer<T,C:ContainerOpaque>(item:T)-> C  {
//            return [item]
//        }
        //使用不透明类型 some ContainerOpaque作为表达式的的返回值
        //该函数返回一个容器,但是没有指定容器的类型
        func makeProtocolContainerOpaque<T>(item:T)-> some ContainerOpaque  {
            return [item]
        }
        let opaqueContainer = makeProtocolContainerOpaque(item: 12)
        let twelve = opaqueContainer[0]
        print(type(of: twelve))
        //Int
        //twelve 的类型推断出来是int,也间接的解释了类型推断使用的是不透明类型.
        //在上例中,不透明类型的容器是[T],在本例中,T是int,因为返回值是一个整型数组类型,以及关联值被推断为int类型.
        //容器中下标语法返回item,也就可以推断出twelve是int类型.
        
        
        
        
        
        
        
        
        
        
    }
    //

}

 //MARK: - The Problem That Opaque Types Solve (不透明类型解决的问题)
protocol Shape {
    func draw() -> String
}
struct Triangle:Shape {
    var size:Int
    func draw() -> String {
        var result = [String]()
        for legnth in 1...size {
            result.append(String(repeating: "*", count: legnth))
        }
        return result.joined(separator: "\n")
    }
}

// MARK: - 泛型事例
struct FlippedShape<T:Shape>:Shape {
    var shape:T
    func draw() -> String {
        let lines = shape.draw().split(separator: "\n")
        return lines.reversed().joined(separator: "\n")
    }
}

struct JoinedShape<T:Shape,U:Shape>:Shape {
    var top:T
    var bottom:U
    func draw() -> String {
        return top.draw() + "\n"+bottom.draw()
    }
}

protocol ContainerOpaque {
    associatedtype Item
    var count:Int {get}
    subscript(i:Int)->Item{get}
}
extension Array:ContainerOpaque {
    
}
