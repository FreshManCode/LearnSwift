//
//  SWSubscriptsViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/7/27.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWSubscriptsViewController: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "下标语法"
        p_initDefaultData()
        
    }
    
    func p_initDefaultData()  {
        view.addSubview(tableView);
        listArray.append("SubscriptSyntax")
        listArray.append("SubscriptUsage")
        listArray.append("Inheritance")
        tableView.reloadData()
    }
    
    // MARK: - Subscript Syntax (下标语法)
    @objc func SubscriptSyntax() {
        /* 类,结构体,以及枚举都可以定义下标,可以快速访问集合,数组以及序列元素的简洁方法.在下标中使用索引来获取或者设置值,不需要
         设置方法或者取值方法.
         
         下标使你能通过在实例名之后使用一个方括号,[] 可以是一个或多个值的形式来访问实例类型.使用subcript关键词来定义下标语法,
         确定一个或者多个输入参数以及返回类型,就像实例方法一样.不像实例方法,下标可以设置成读写或者只读模式.该行为就像计算属性的
         getter/setter方法来控制.
         
         subscript(index:Int) ->Int {
         get {
         
         }
         set(newValue) {
         
         }
         }
         */
        //下面是一个只读下标属性的例子
        struct TimesTable {
            let multiplier :Int
            subscript(index:Int)->Int {
                return multiplier * index
            }
        }
        let threeTimesTablee = TimesTable(multiplier: 3)
        print("six times three is \(threeTimesTablee[6])")
        //six times three is 18
    }
    
    // MARK: - Subscript Usage 下标语法使用
    @objc func SubscriptUsage()  {
        //1.字典的使用
        var numberOfLegs = ["sipder":8,"cat":4]
        numberOfLegs["bird"] = 2
        
        
        //2.(Subscript Options) 下标选择
        //通常来说下标语法都是一个单一的参数,也可以对需要的类型定义多个合适的参数.如下事例:
        struct Matrix {
            let rows:Int,colums:Int
            var grid:[Double]
            init(rows:Int,colums:Int) {
                self.rows = rows
                self.colums = colums
                grid = Array(repeating: 0.0, count: rows * colums)
            }
            
            func indexIsValid(row:Int,columd:Int) -> Bool {
                return row >= 0 && row < rows && columd >= 0 && columd < colums
            }
            subscript (row:Int,column:Int)->Double {
                get {
                    assert(indexIsValid(row: row, columd: column), "Index out of range")
                    return grid[(row * colums) + column]
                }
                set {
                    assert(indexIsValid(row: row, columd: column), "Index out of range")
                    grid[(row * colums ) + column] = newValue
                }
            }
        }
        
        var matrix = Matrix(rows: 2, colums: 2)
        matrix[0,1] = 5
        matrix[1,0] = 15
        print(matrix[0,1]) //5.0
        print(matrix[1,0]) //15.0
        
        
       //2.Type Subscripts (类型下标)
       /*实例下标,就像上面描述的这样.一个指定实例变量调用的下标.你也可以定义类型本身的下标.这种下标称为类型下标.
         在subcript关键词之前使用static关键词,来表示这是一个类型下标.Class可以使用class关键词代替.
         */
        
        enum Plant:Int {
            case mercury = 1,venus,erath,mars,jupiter,saturn,uranus,neptune
            
            static subscript(n:Int)->Plant {
                return Plant(rawValue: n)!
            }
        }
        
        let mars = Plant[4]
        print(mars)
        //mars
    }
    
    
    // MARK: - Inheritance 继承
    @objc  func Inheritance()  {
        //1.Defining a Base Class (定义一个基类)
        //任何不从其他Class继承过来的类,称为基类.
        //注意:Swift中的类不需要从通用的类继承过来.你定义的class没有继承于任何class,swift在编译的时会自动变为基类.
        class Vehicle {
            var currentSpeed = 0.0
            var description:String {
                return "traveling at \(currentSpeed) miles per hour"
            }
            
            func makenNoise()  {
                
            }
        }
        let someVehicle = Vehicle()
        print("Vehicle: \(someVehicle.description) ")
        
        
        //2.Subclassing (子类)
        class Bicycle:Vehicle {
            var hasBasket = false
        }
        let bicycle = Bicycle()
        bicycle.hasBasket = true
        bicycle.currentSpeed = 15.0
        print("bicycle: \(bicycle.description) ")
        
        //2.子类本身也可以作为父类
        class Tandem:Bicycle {
            var currentNumberofPassengers = 0
        }
        
        let tamdem = Tandem()
        tamdem.hasBasket = true
        tamdem.currentSpeed = 2
        tamdem.currentSpeed = 22.0
        print("tamdem: \(tamdem.description) ")
        
        //3.Overring (重写)
        //3.1 Overring Methods (重写方法)
        class Train:Vehicle {
            override func makenNoise() {
                print("Choo Choo")
            }
        }
        let train = Train()
        train.makenNoise() // "Choo Choo"
        
        
        //3.2 Overring Properties (重写属性)
        //重写属性的getter和setter方法
        //你可以在子类中把父类中只读的属性通过提供getter和setter方法来变成可读可写属性.然而你不能把继承过来的可读可写的属性变成一个只读的属性.
        class Car:Vehicle {
            var gear = 1
            override var description: String {
                return super.description + " in gear \(gear)"
            }
        }
        
        //3.2.2 Overring Property Observers (重写属性观察)
        class AutomaticCar:Car {
            override var currentSpeed: Double {
                didSet {
                    gear = Int(currentSpeed / 10.0) + 1
                }
            }
        }
        let automatic = AutomaticCar()
        automatic.currentSpeed = 35.0
        print("AutomaticCar: \(automatic.description)")
        
        
        //3.3 Preventing Overrides (防止重写)
        /* 如果不想让方法,属性,或者下标被重写,通过final关键词来标记.例如(final var,final func....)
         如果在子类中尝试重写使用final关键词标记的属性,方法,或者下标,将会出现编译错误.
         同样也可以防止class不被继承,使用final关键词来标志.例如:如下,继承class A会报错
         
         */
        final class A {
            
        }
//        class B : A {
//
//        }
        
        
        
        
        
        
    }
    
    
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row], tableView: tableView);
    }
}
