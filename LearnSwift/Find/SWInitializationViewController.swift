//
//  SWInitializationViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/7/28.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWInitializationViewController: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "初始化"
        p_initDefaultData()
        
        // Do any additional setup after loading the view.
    }
    
    func p_initDefaultData() -> Void {
        self.view.addSubview(self.tableView);
        listArray.append("Initialization")
        listArray.append("InitializerInheritanceAndOverriding")
        tableView.reloadData()
    }
    
    // MARK: - 函数
    @objc func Functions() {
        self.navigationController?.pushViewController(SWFunctionsViewController.init(), animated: true)
    }
    
    
    // MARK: - Initialization 初始化
    @objc  func Initialization()  {
        /* 和OC的初始化函数不同.Swift的初始化函数没有返回值.Swift可以确保一个新的实例在第一次使用的时候可以正确的初始化.
         deinitializer函数用来释放资源
         */
        //1.Setting Initial Values for Stored Properties (对于储值函数设置初值)
        //classes以及结构体在创建实例的时候必须给它们的储值属性赋上合适的值.存储属性不能是一个未定义的状态
        //可以在初始化函数中设置初值,或者在属性定义的时候给个默认值.
        //注意:当你给初值属性默认值或者使用初始化函数直接设置初值的时候,不会调用任何观察函数.
        
        //1.Initializers
        struct Fahrenheit {
            var temperature:Double
            
//          给属性设置默认值
            var temperature2 = 32.0
            
            init() {
                temperature = 32.0
            }
        }
        
        var f = Fahrenheit()
        print("The default temperature is \(f.temperature) Fahrenheit")
        
        //2.Default Property Values
        //在声明的时候就给其默认值.
        
        //3.Customzing Initialization
        //3.1 Initialization Parameters (初始化参数)
        
        struct Celsius {
            var temperature :Double
            init(fromFahrenheit fahrenheit:Double) {
                temperature = (fahrenheit - 32.0)/1.8
            }
            
            init(fromKelvin kelvin:Double) {
                temperature = kelvin - 273.15
            }
        }
        
        let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
        let freezingPointOfWater = Celsius(fromKelvin: 273.15)
        
        //3.2 Parameter Names and Argument Lables (参数名和参数标签)
        struct Color {
            let red,green,blue:Double
            init(red:Double,green:Double,blue:Double) {
                self.red = red
                self.green = green
                self.blue = blue
            }
            init(white:Double) {
                red = white
                green = white
                blue = white
            }
        }
        
        let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
        let halfGray = Color(white: 0.5)
        //注意:如果调用初始化函数的时候不使用参数标签,会报错.
        
        
        //3.3 Initializer Parameters Without Argument Labels (不适用参数标签初始化参数)
        //如果想在初始化函数的时候不使用参数标签,使用"_"来代替参数的显式标签用来覆写默认的行为.如下事例:
        struct Celsius2 {
            var temperatureCelsius:Double
            init(fromFahrenheit fahrenheit:Double) {
                temperatureCelsius = (fahrenheit - 32.0)/1.8
            }
            init(fromKelvin kelvin:Double) {
                temperatureCelsius = kelvin - 273.15
            }
            init(_ celsius:Double) {
                temperatureCelsius = celsius
            }
        }
        let bodyTemperature = Celsius2(37.0)
        
        
        //3.4 Optional Property Types
        /* 如果自定义类型的储值属性允许没有值,可能因为它的值在初始化的时候没有设置,或者在之后的某个时候允许没有值,此时把该属性声明为可选型.
         可选型的值初始化的时候自动设置为nil
         */
        class SurveyQuestion {
            var text:String
            var response:String?
            init(text:String) {
                self.text = text
            }
            func ask()  {
                print(text)
            }
        }
        let cheeseQuestion = SurveyQuestion(text:"Do you like cheese?")
        cheeseQuestion.ask()
        cheeseQuestion.response = "Yes,I do like cheese."
        
        
        //3.5 Assigning Const Properties  During Initialization
        //可以在初始化的任何时候给一个常量属性赋值,只要在初始化完成的时候该常量属性有定义的值就可以.一旦常量被赋值之后,就无法改变
        //注意:对于类实例,一个常量属性只能引进该类初始化的时候可以修改值.不能被子类修改.
        class SurveyQuestion2 {
            let text : String
            var response:String?
            //虽然text是常量属性,仍然可以在初始化函数中赋值
            init(text:String) {
                self.text = text
            }
            func ask()  {
                print(text)
            }
        }
        let beetsQuestion = SurveyQuestion2(text: "How about beets?")
        beetsQuestion.ask()
        beetsQuestion.response = "I also like betts.(But not with cheese)"
        
        
        //3.6 Default Initializers (默认初始化函数)
        class ShoppingListItem {
            var name:String?
            var quantity = 1
            var purchased = false
        }
        var item = ShoppingListItem()
        
        
        //3.7 Memberwise Initializers for Structure Types (结构体成员类型的初始化构造函数)
        //结构体类型如果没有定义它们本身的初始化函数,会自动提供一个成员初始化函数.和默认初始化函数不同,
        //该结构体接收一个成员初始化函数,即使有初值属性,也没有默认值.
        //如下结构体Size,自动接收一个init(width:height:)的成员初始化函数.可以用来创建一个实例
        struct Size {
            var width = 0.0,height = 0.0
        }
        
        //忽略初始化参数的默认值
        let twoByTwo  = Size(width: 2.0, height: 2.0)
        print(twoByTwo.width,twoByTwo.height) //2.0,2.0
        
        let zeroByTwo = Size(height:2.0)
        print(zeroByTwo.width,zeroByTwo.height) //0.0,2.0
        
        
        //3.8 Initializer Delegation for Value Types (值类型的初始化委托)
        struct Size2 {
            var width = 0.0,height = 0.0
        }
        struct Point2 {
            var x = 0.0,y = 0.0
        }
        struct Rect {
            var origin = Point2()
            var size = Size2()
            init() {
                
            }
            init(origin:Point2,size:Size2) {
                self.origin = origin
                self.size   = size
            }
            init(center:Point2,size:Size2) {
                let originX = center.x - (size.width)/2
                let originY = center.y - (size.height)/2
                //调用委托初始化方法
                self.init(origin: Point2(x: originX, y: originY), size: size)
            }

        }
        
        let basicRect = Rect()
        //origin (0.0,0.0) size (0.0,0.0)
        let originRect = Rect(origin: Point2(x: 2.0, y: 2.0), size: Size2(width: 5.0, height: 5.0))
        
        
        //3.9 Class Inheritance and Initialization (类的集成与初始化)
        //Designated Initializers and Convenience Initializers (指定初始化方法和创建初始化方法)
        //Syntax for Designed and Convenience Initializers
        /* init(parameter) {
         
         }
         
         //便捷初始化方式以相同的样式抒写,只是在init关键词前有convenice 修饰词.
         convenice init(parameter) {
         
         }
         */
        
        //3.10 Initializer Delegation for Class Types (对于class类型的委托构造器)
        //为了简化指定构造器和便捷构造器之间的关系,Swift在这两种构造器的调用上提供了三种规则.
        //1.指定构造器必须调用来自它直接父类的函数
        //2.便捷构造器必须能够调用来自同一个class的另一个构造器.
        //3.便捷构造器最终必须要调用指定构造器.
        
        //3.10.1 Two-Phase Initialization (两阶段初始化)
        /*Swift的类初始化有两个阶段.第一个阶段是每个存储的属性在该类被引入的时候设置初始值.一旦存储的每个属性完成初始值的设定之后,
         第二阶段就要开始了,在创建的新实例可用之前,每个类都有机会来自定义其储存的属性.
         */
    }
    // MARK: - Initializer Inheritance And Overriding
    @objc func InitializerInheritanceAndOverriding()  {
        class Vehicle  {
            var numberOfWheels = 0
            var description :String {
                return "\(numberOfWheels) wheels"
            }
        }
        
        let vehicle = Vehicle()
        print("Vehivle:\(vehicle.description)")
        
        class Bicycle : Vehicle {
            override init() {
                super.init()
                numberOfWheels = 2
            }
        }
        
        let bicycle = Bicycle()
        print("Bicycle:\(bicycle.description)")
        //Bicycle:2 wheels
        
        
        class HoverBoard : Vehicle {
            var color:String
            init(color:String) {
                self.color = color
                //super.init() 隐式调用
            }
            override var description: String {
                return "\(super.description) in a beautifual \(color)"
            }
        }
        
        //HoverBoard 的实例使用了由Vehicle初始化函数提供的默认值
        let hoverBoard = HoverBoard(color: "sliver")
        print("hoverBoard:\(hoverBoard.description)")
        //hoverBoard:0 wheels in a beautifual sliver
        //注意:子类可以在初始化期间修改继承父类的可变属性,但是不能修改继承的常量属性.
        //Food->RecipeIngredient->ShoppingListItem
        class Food  {
            var name:String
            init(name:String) {
                self.name = name
            }
            //便捷初始化函数,使用参数"[Unnamed]"调用指定初始化函数来
            convenience init() {
                self.init(name:"[Unnamed]")
            }
        }
        
        let mysteryMeat = Food()
        let namedMeat   = Food(name: "Bacon")
        
        
        
        
        
   
    }
    
    
}
