//
//  SWEnumerationsController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/7/20.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWEnumerationsController: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "枚举";
        p_initDefaultData();
    }
    
    func p_initDefaultData()  {
        self.view.addSubview(self.tableView);
        listArray.append("EnumerationSyntax")
        listArray.append("AssociatedValues")
        listArray.append("RawValues")
        listArray.append("RecursiveEnumerations")
        listArray.append("StructuresAndClasses")
        listArray.append("StructuresAndEnumerationsAreValueTypes")
        listArray.append("GlobalAndLocalVariables")
        tableView.reloadData()
    }
    
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row], tableView: tableView);
    }
    
    // MARK: - Enumeration Syntax (枚举语法)
    @objc func EnumerationSyntax()  {
        /* 使用enum 关键词来表示枚举类型,并且在大括号后面来放置完整的定义
         
         注意:Swift中的枚举默认没有一个整数值,不像C语言或者OC,下面的例子,north,south,east,west 没有隐式的等于
         0,1,2,3.相反,不同的枚举值就是其右边的值,
         */
        enum CompassPoint {
            case north
            case south
            case east
            case west
        }
        
        //2.多个类型可以在一行出现,通过","分割
        enum Plant {
            case mercury,venus,earth,mars,jupiter,saturn,uranus,neptune
        }
        var directionToHead = CompassPoint.west
        print("directionToHead is:\(directionToHead)")
        //directionToHead is:west
        
        directionToHead = .east
        print("directionToHead is:\(directionToHead)")
        //directionToHead is:east
        
        
        //2.Matching Enumeration Values with a Switch Statement (使用Switch语句来匹配枚举类型)
        //this is east
        switch directionToHead {
        case .north:
            print("this is north")
        case .south:
            print("this is south")
            
        case .east:
            print("this is east")
            
        case .west:
            print("this is west")
            
        }
        
        //3.Iterrating over Eunmeration Cases (枚举的遍历)
        //有时候需要获取枚举的所有案例,可以通过在声明的枚举之后加上:CaseInterable来表明该枚举是可遍历的
        enum Beverage:CaseIterable {
            case coffee,tea,juice
        }
        let numberOfChoices = Beverage.allCases.count
        //3 beverages available
        print("\(numberOfChoices) beverages available")
        
        //3.1 可以像其他集合类型一样,来处理可以进行枚举集合的类:
        for bevarage in Beverage.allCases {
            print("bevarage is:\(bevarage)")
        }
        //bevarage is:coffee bevarage is:tea bevarage is:juice
        //以上声明的枚举类型,遵从了 CaseIterable 协议
    }
    
    // MARK: - Associated Values (关联值)
    @objc func AssociatedValues()  {
        enum BarCode {
            case upc (Int,Int,Int,Int)
            case qrCode(String)
        }
        //该定义没有提供任何实际的Int或者String的值,仅仅定义了BarCode 相关联的常量以及变量存储的类型.
        //可以使用如下方式创建一个新的BarCode类型
        var productBarcode = BarCode.upc(8, 85909, 51226, 3)
        
        productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
        
        //可以使用switch语句来检查不同类型的barcode.关联值作为switch的分支语句:
        switch productBarcode {
        case .upc(let numberSystem, let manufacture, let product, let check):
            print("UPC:\(numberSystem),\(manufacture),\(product),\(check).")
        case .qrCode(let productCode):
            print("QR code:\(productCode).")
        }
        //QR code:ABCDEFGHIJKLMNOP.
        
        //如果枚举中关联值都被提取为常量或者变量,可以把let或者var提前,放在对应的name名称之前,如下:
        switch productBarcode {
        case let .upc(numberSystem, manufacture, product, check):
            print("UPC:\(numberSystem),\(manufacture),\(product),\(check).")
        case let .qrCode(productCode):
            print("QR code:\(productCode).")
        }
        //QR code:ABCDEFGHIJKLMNOP.
    }
    
    // MARK: - Raw Values (原始值)
    @objc func RawValues() {
        enum ASCIIControlCharacter : Character {
            case tab = "\t"
            case lineFeed = "\n"
            case carriageReturn = "\r"
        }
        
        //2.Implicitly Assigned Raw Values  (隐式分配原始值)
        /* 当你处理的枚举类型是存储整型或者字符串类型原始值的时候,不必显式为每个条目赋上原始值.当你没有赋原始值的时候,Swift自动
         帮你分配值.
         例如,如果原始值是整型,对于隐式赋值的每个条目的原始值都会比上一个条目大.如果第一个条目没有设置默认值,系统会从0开始帮你分配.
         */
        enum Plant:Int {
            case mercury = 1,venus,earth,mars,jupiter,saturn,uranus,neptune
        }
        //上述枚举中, mercury 显示赋值为1,venus隐式赋值为2,后面的一次类推
        
        //3.当使用字符串作为原始值的时候,系统默认使用每个条目的名称作为原始值
        enum CompassPoint : String,CaseIterable {
            case north,south,east, west
        }
        //上述事例中 north有个 默认原始值为"north",其他的以此类推.
        
        //4.可以通过rawValue属性来获取枚举中每个条目的原始值
        for item in CompassPoint.allCases {
            print(item.rawValue)
        }
        //north  south east west
        
        //5.Initializing from a Raw Values (使用原始值来初始化)
        //如果给枚举定义了一个原始值类型,枚举自动接收一个原始值类型的参数来初始化并且返回枚举中对应的条目或者nil.
        let possiblePlant  = Plant(rawValue: 7)
        if let _ = possiblePlant {
            print("possiblePlant is:\(possiblePlant!)")
        }
        //possiblePlant is:uranus
        //并不是所有的Int值都能找到对应的匹配项,因此原始值初始化方式返回的是一个可选型的枚举.
        //如果试着找出11对应的行星,该枚举可选型返回的原始值将会是nil
        let positionToFind = 11
        if let sompleant = Plant(rawValue: positionToFind) {
            switch sompleant {
            case .earth:
                print("Mostly harmless")
            default:
                print("Not a safe place for humans")
            }
        } else {
            print("There isn't a planet at position\(positionToFind)")
        }
    }
    
    // MARK: - Recursive Enumerations (递归枚举)
    @objc func RecursiveEnumerations() {
        /* 递归枚举是一个有其它递归实例作为一个或者过个关联值的枚举实例.
         通过使用indirect 关联词来标识
         */
        //1.存储简单的数学表达式的值
        enum ArithmeticExpression {
            case number(Int)
            indirect case addition(ArithmeticExpression,ArithmeticExpression)
            indirect case muliplication (ArithmeticExpression,ArithmeticExpression)
        }
        
        //2.可以通过在枚举声明之前加上 indirect 关键词:
        indirect enum ArithmeticExpression2 {
            case number(Int)
            case addition(ArithmeticExpression2,ArithmeticExpression2)
            case muliplication(ArithmeticExpression2,ArithmeticExpression2)
        }
        /* 说明:
         addition,muliplication 条目的关联值也是数学表达式,这样的关联值就使得嵌套表达式成为可能.
         例如:(5 + 4) * 2,如下:
         */
        let fiveAddFour = ArithmeticExpression2.addition(ArithmeticExpression2.number(5), ArithmeticExpression2.number(4))
        let result = ArithmeticExpression2.muliplication(fiveAddFour, ArithmeticExpression2.number(2))
        
        func evaluate(_ expression:ArithmeticExpression2)->Int {
            switch expression {
            case let .number(value):
                return value
            case let.addition(left, right):
                return evaluate(left) + evaluate(right)
            case let.muliplication(left, right):
                return evaluate(left) * evaluate(right)
            }
        }
        //fiveAddFour is:9 result is:18
        print("fiveAddFour is:\(evaluate(fiveAddFour)) result is:\(evaluate(result))")
    }
    
    // MARK: - Structures And Classes (结构体和类)
    @objc func StructuresAndClasses()  {
        //1.结构体与类相比较 相似点:
        /*
         1.定义属性保存值
         2.定义方法提供函数功能
         3.定义下标语法用来使用下标语法取值
         4.定义建立初始化状态的函数
         5.在默认的功能之外扩展功能
         6.遵从协议用来提供特定的功能
         */
        
        //2.类有结构体不具备的特性:
        /*
         1.继承使得可以获得其他类的特性
         2.类型转换使得可以在运行时检查和解释实例的类型
         3.denitializers函数使得一个类的实例释放其所占用的资源
         4.引用计数允许对实例进行多个引用
         
         类所支持的额外功能,是以增加了复杂性为代价.通常来讲更倾向于使用结构体.
         */
        
        //2.Definition Syntax (语法定义)
        //结构体的定义与Class的定义相似,通过struct 关键词然后后面用大括号包裹着
        struct Resolution {
            var width = 0
            var height = 0
        }
        class VideoMode {
            var resolution = Resolution()
            var interlaces = false
            var frameRate = 0.0
            var name:String?
        }
        
        //3.结构体和类的实例
        let someResolution = Resolution()
        let someVideoMode = VideoMode()
        //使用最简单的初始化语法来构建实例对象
        
        //4.Accessing Properties (访问属性)
        //1.使用.语法来获取实例变量的属性
        print("The width of someResolution is \(someResolution.width)")
        //The width of someResolution is 0
        
        //2.也可以获取子属性的属性
        print("The width of someResolution is \(someVideoMode.resolution.width)")
        //The width of someResolution is 0
        
        //3.也可以使用.语法来给一个变量赋值
        someVideoMode.resolution.width = 1280
        print("The width of someResolution is \(someVideoMode.resolution.width)")
        //The width of someResolution is 1280
        
        //4.Memberwise Initializers for structure Types (结构体的成员变量初始化方式)
        //实例变量的初始值可以通过实例变量的名字传递,如下:
        let vga = Resolution(width: 640, height: 480)
        //不像结构体,类就没有这种默认的成员变量初始化方式
    }
    
    // MARK: - Structures And Enumerations Are Value Types (结构体和枚举都是值类型)
    @objc func StructuresAndEnumerationsAreValueTypes()  {
        /* 值类型就是一种当把它给常量或者变量甚至函数传递时,传递的是拷贝的副本.
         在Swift中,像整型,浮点型,布尔型,字符串,数组以及字典都是值类型.
         所有的结构体和枚举都是值类型,这表明你创建的任何结构体和枚举的实例以及它们所有的属性,在传递的时候总是以拷贝的副本形式传递.
         */
        struct Resolution {
            var width = 0
            var height = 0
        }
        class VideoMode {
            var resolution = Resolution()
            var interlaces = false
            var frameRate = 0.0
            var name:String?
        }
        
        let hd = Resolution(width: 1920, height: 1080)
        var cinema = hd
        //虽然 cinema 与 hd 有相同的宽高,但是它们是两个完全不同的实例,请看如下
        cinema.width = 2048
        print("hd's width is:\(hd.width) cinema's width is:\(cinema.width)")
        //hd's width is:1920 cinema's width is:2048
        //当把hd的值赋值cinema的时候,存储在hd中的值被拷贝到cinema实例中.结果是两个拥有相同值完全独立的实例.
        //因为两个实例是独立的,所以修改cinema的width属性的时候,hd的width属性依然是之前的值.
        
        //2.相同的属性可以应用到枚举中
        enum CompassPoint {
            case north,south,east,west
            mutating func turnNorth() {
                self = .north
            }
        }
        var currentDirection = CompassPoint.west
        let rememberDirection = currentDirection
        currentDirection.turnNorth()
        print("currentDirection is:\(currentDirection) rememberDirection is:\(rememberDirection)")
        //currentDirection is:north rememberDirection is:west
        
        //3.Classes Are Reference Types (Class 是引用类型)
        //和值类型不同,引用类型在被赋值给常量/变量或者作为函数的参数传递时,不是传递一个copy的副本.而是对齐实例的一个引用,
        //如下事例:
        let tenEighty = VideoMode()
        tenEighty.resolution = hd
        tenEighty.interlaces = true
        tenEighty.name = "1080i"
        tenEighty.frameRate = 25.0
        
        //将其赋值给一个新的常量,然后修改该常量实例的某些属性
        let alsoTenEighty = tenEighty
        alsoTenEighty.frameRate = 30.0
        
        print("tenEighty's frameRate is:\(tenEighty.frameRate)  alsoTenEighty's frameRate is:\(alsoTenEighty.frameRate)")
        //tenEighty's frameRate is:30.0  alsoTenEighty's frameRate is:30.0
        //因为Class是引用类型,所以alsoTenEighty以及tenEighty 引用的都是同一个VideoMode的实例,因此修改其中一个,另外一个也随之修改
        
        
        //4.Identify Operators (区别运算符)
        //有时为了鉴别出两个实例是不是引用了同一个class的实例,Swift提供了两种操作符 === 以及!==
        //使用这两个操作符来鉴别常量/变量是否对同一个实例的引用
        if tenEighty === alsoTenEighty {
            print("tenEighty and alsoTenEighty refer to the same VideMode instance.")
        }
        //tenEighty and alsoTenEighty refer to the same VideMode instance.
    }
    
    // MARK: - Global And Local Variables (全局和局部变量)
    @objc func GlobalAndLocalVariables() {
        //1.Type Properties (类型属性)
        /* 可以定义属于类型本身的属性,二不属于任何类型的实例.这种属性只会有一个副本,无论你创建了多少个类型实例.
         这种类型的属性称为类型属性.
         
         注意:和存储实例属性不同的是,你必须给存储类型属性一个默认值.因为类型本身没有使用初始化函数来分配值当实例初始化的时候.
         存储类型属性在第一次访问的时候使用懒加载的形式.它们保证只初始化一次,及时在多线程中同时访问,并且不需要用lazy关键词来标识.
         */
        
        //2.Type Property Syntax (类型属性语法)
        //使用static关键词来定义类型属性.对于类的计算类型属性使用class关键词允许子类重写父类的执行.如下事例:
        struct SomeStructure {
            static var storedTypeProperty = "Some value."
            static var computedTypeProperty : Int {
                return 1
            }
            
            static var singleTon:SomeStructure {
                return SomeStructure.init()
            }
        }
        enum SomeEnumeration {
            static var storedTypeProperty = "Some value."
            static var computedTypeProperty:Int {
                return 6
            }
        }
        class SomeClass {
            static var storedTypeProperty = "Some values."
            //可读属性
            static var computedTypeProperty : Int {
                return 27
            }
            class var overrideableComputedTypeProperty : Int {
                return 107
            }
        }
        
        print("1 is: \(SomeStructure.singleTon)")
        print("2 is: \(SomeStructure.singleTon)")
        
        
        
    }
    
    
    

}
