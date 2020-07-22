//
//  SWPropertiesViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/7/22.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWPropertiesViewController: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "属性";
        self.p_initDefaultData();
    }
    
    
    func p_initDefaultData()  {
        self.view.addSubview(self.tableView);
        listArray.append("StoredProperties")
        listArray.append("PropertyObservers")
        listArray.append("PropertyWrapper")
        listArray.append("SettingInitialValuesForWrappedProperties")
        tableView.reloadData()
    }
    
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row], tableView: tableView);
    }
    
    // MARK: - Stored Properties
    @objc func StoredProperties()  {
        /* 储值属性最简单的形式就是一个储值属性的常量或者变量作为一个指定类或者结构体的实例的一部分.
         可以在定义属性的时候给其默认值,也可以在初始化实例的时候给其初始值.
         */
        struct FixedLengthRange {
            var firstValue : Int
            let length : Int
        }
        
        var rangeOfThreeItems = FixedLengthRange(firstValue:0,length:3)
        rangeOfThreeItems.firstValue = 6
        //因为length 属性 是常量,在初始化的时候有了初始值,所以之后无法改变.
        
        //2.Stored Properties of Constant Stucture Instances (结构体常量实例的储值属性)
        //如果创建结构体实例的时候,把它复制给一个常量,即使该结构体的属性是可变的,你也无法修改该属性.
        let rangeOfFourItems = FixedLengthRange(firstValue:0,length:4)
        //        做以下修改属性操作会报错.
        //        rangeOfFourItems.firstValue = 6
        
        //注意:之所以会报错是因为结构体是值类型.当其实例对象被标记为常量的时候,它所有的属性都是常量了.
        //这点和Class的实例有所不同,因为class是引用类型.即使Class的实例对象是常量,仍然可以修改可变属性的值
        
        
        //3.Lazy Stored Properties (懒加载储值属性)
        //懒加载属性是该属性在初始化的时候不会被调用,直到第一次使用到该属性才会调用.通过使用lazy关键词来标记.
        
        //注意:必须将懒加载的属性声明为可变类型的.因为它的初始值可能在实例初始化完成后才能获得.常量属性总是需要在初始化
        //完成之前获取值,因此不能使用懒加载.
        
        class DataImporter {
            var fileName = "data.txt"
        }
        class DataManager {
            lazy var importer = DataImporter()
            var data = [String]()
        }
        let manager = DataManager()
        manager.data.append("some data")
        manager.data.append("Some more data")
        
        //注意:如果在多线程中访问未初始化的懒加载变量,不能保证该属性只会被初始化一次.
        
        //4.Stored Properties and instance Variable
        //在OC中,有两种方式用来储值以及引用一个class的实例对象.除了属性之外,可以使用实例变量作为存储在属性上的值的备用存储.
        //Swift把这些概念统一为了单一的属性声明.Swift中的属性没有与之相对应的实例变量,并且备用存储无法直接获取.
        
        
        //5.Computed properties
        /* 除了储值属性之外,类,结构体和枚举还可以定义计算属性,实际上没有真正保存值.而是提供了一个getter和一个可选的setter
         方法去获取以及间接赋值.
         */
        struct Point {
            var x  = 0.0, y = 0.0
        }
        struct Size {
            var width = 0.0, height = 0.0
        }
        struct Rect {
            var origin = Point()
            var size = Size()
            
            //定义了一个自定义的计算属性center,实现了getter和setter方法
            var center:Point {
                get {
                    let centerX = origin.x + (size.width / 2)
                    let centerY = origin.y + (size.height / 2)
                    return Point(x: centerX, y: centerY)
                }
                
                set (newCenter) {
                    origin.x = newCenter.x - (size.width / 2)
                    origin.y = newCenter.y - (size.height / 2)
                }
            }
        }
        
        var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
        let initialSquareCenter = square.center
        square.center = Point(x: 15.0, y: 15.0)
        print("square.center is now at(\(square.origin.x),\(square.origin.y)")
        
        
        //6.Shorthand Setter Declaration (setter简写方法)
        /* 如果一个计算属性的setter方法没有对新值进行命名,默认的名字是newValue.
         */
        struct CompactRect {
            var origin = Point()
            var size = Size()
            var center : Point {
                get {
                    Point(x: origin.x + size.width / 2, y: origin.y + size.height / 2)
                }
                //忽略return 关键字,像之前描述函数章节的一样
                
                //              使用setter方法的默认值
                set {
                    origin.x = newValue.x - size.width / 2
                    origin.y = newValue.y - size.height / 2
                }
            }
        }
        
        
        //7.Read-Only Computed Properties (只读计算属性)
        /* 只有getter方法没有setter方法的计算属性叫做只读计算属性.只读计算属性总是通过.语法返回一个值,但是不能用setter方法去修改.
         在声明只读属性的时候,必须声明为可变类型,因为只读属性的值不固定.
         
         通过移除get关键词,可以简化定义只读计算属性
         */
        //     一个新的结构体用来表示一个长方形的盒子 (长,宽,高)
        struct Cuboid {
            var width = 0.0,height = 0.0, depth = 0.0
            //          只读属性的容积
            var volume : Double {
                return width * height * depth;
            }
        }
        
        let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
        print("the volume of foureByFiveByTwo is\(fourByFiveByTwo)")
        
    }
    
    // MARK: - Property Observers 属性观察者
    @objc func PropertyObservers() {
        /*
         1.willSet 在值保存之前被调用
         2.didSet 在值被保存之后立即调用
         */
        class StepCounter {
            //          定义了一个名为totalStep的储值属性,并且实现了willSet和didSet方法
            var totalStep : Int = 0 {
                //willSet观察者方法使用了自定义参数名为newTotalSteps 默认值的参数名:newValue
                willSet(newTotalSteps) {
                    print("About to set totalSetps to \(newTotalSteps)")
                }
                didSet {
                    //默认值的参数名:oldValue
                    if totalStep > oldValue {
                        print("Added\(totalStep - oldValue) steps")
                    }
                }
                
            }
        }
        
        let stepCounter = StepCounter()
        stepCounter.totalStep = 200
        stepCounter.totalStep = 360
        stepCounter.totalStep = 896
        //        About to set totalSetps to 200
        //        Added200 steps
        //        About to set totalSetps to 360
        //        Added160 steps
        //        About to set totalSetps to 896
        //        Added536 steps
        
    }
    
    
    // MARK: - Property Wrapper 属性包装
    @objc func PropertyWrapper() {
        @propertyWrapper
        struct TwelveOrLess {
            private var number:Int
            init() {
                self.number = 0
            }
            var wrappedValue:Int {
                get {
                    return number
                }
                set {
                    number = min(newValue, 12)
                }
            }
            // setter方法确保了新值小于12,getter方法确保可以获取保存的值.
        }
        
        
        struct SmallRectangle {
            @TwelveOrLess var height:Int
            @TwelveOrLess var width :Int
        }
        var rectangle = SmallRectangle()
        print(rectangle.height)
        //0
        
        rectangle.height = 10
        print(rectangle.height)
        //10
        
        rectangle.height = 24
        print(rectangle.height)
        //12
        
        //也可以不利用包装属性的优势来书写代码,如下事例:在声明结构体属性的时候,没有使用@TwelveOrLess 作为一个属性
        struct SmallRectangle2 {
            private var _height = TwelveOrLess()
            private var _width = TwelveOrLess()
            var height:Int {
                get { return _height.wrappedValue }
                set {_height.wrappedValue = newValue}
            }
            
            var width:Int  {
                get { return _width.wrappedValue }
                set {_width.wrappedValue = newValue}
            }
        }
    }
    
    // MARK: - Setting Initial Values For Wrapped Properties (给包装的属性设置初始值)
    @objc func SettingInitialValuesForWrappedProperties() {
        
        @propertyWrapper
        struct SmallNumber {
            private var maxinum:Int
            private var number:Int
            
            var wrappedValue : Int {
                get {
                    return number
                }
                set {
                    number = min(newValue , maxinum)
                }
            }
            
            init() {
                maxinum = 12
                number = 0
            }
            init(wrappedValue:Int) {
                maxinum = 12
                number = min(wrappedValue, maxinum)
            }
            
            init(wrappedValue:Int,maxinum:Int) {
                self.maxinum = maxinum
                number = min(wrappedValue, maxinum)
            }
        }
        struct ZeroRectangle {
            @SmallNumber var height:Int
            @SmallNumber var width:Int
        }
        var zeroRectangle = ZeroRectangle()
        print(zeroRectangle.height,zeroRectangle.width)
        //0 0
        
        struct UnitRectangle {
            @SmallNumber var height:Int = 1
            @SmallNumber var width:Int = 1
        }
        //当使用包装属性为上述方式时,被转义为调用init(wrappedValue:Int) 初始化方法.该SmallNumber的实例包装height和width通过调用
        //init(wrappedValue:1) 方法.该方法使用默认的最大值是12
        var unitRectangle = UnitRectangle()
        print(unitRectangle.height,unitRectangle.width)
        //1 1
        
        //如果在初始化的时候提供一个初始值和一个最大值,将会使用init(wrappedValue:Int,maxinum:Int) 方法进行初始化
        struct NarrowRectangle {
            @SmallNumber (wrappedValue: 2, maxinum: 5) var height:Int
            @SmallNumber (wrappedValue: 3, maxinum: 4) var width :Int
        }
        var narrowRectangle = NarrowRectangle()
        //2 3
        print(narrowRectangle.height,narrowRectangle.width)
        
        narrowRectangle.height = 100
        narrowRectangle.width = 100
        //5 4
        print(narrowRectangle.height,narrowRectangle.width)
        
        
    }
    
    
    
    
    
    
}
