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
        listArray.append("ProjectAValueFromAPropertyWrapper")
        listArray.append("GlobalAndLocalVariables")
        listArray.append("ClassAndInstanceMethod")
        listArray.append("ModifyingValueTypesFromWithinInstanceMethods")
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
        @propertyWrapper //告诉编译器 TwelveOrLess 需要属性包装
        struct TwelveOrLess {
            private var number:Int
            init() {
                self.number = 0
            }
            // wrappedValue 是属性包装需要实现的属性
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
        
        
        //封装一个 TwelveOrLess 相关的Struct
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
        
        struct MixedRectangle {
            @SmallNumber var height:Int = 1
            @SmallNumber var width :Int = 2
        }
        var mixedRectangle = MixedRectangle()
        print(mixedRectangle.height) //1
        
        mixedRectangle.height = 20
        print(mixedRectangle.height) //12
        
        
        
    }
    
    
    // MARK: - Project A Value From A Property Wrapper (从属性包装器映射值)
    @objc func ProjectAValueFromAPropertyWrapper()  {
        /* 除了包装值,属性包装可以定义一个映射值来公开其他的功能,例如,属性包装通过在其映射值上公开一个flushDataBaseConnection()方法来访问数据库.
         映射值的名称与包装值相同,除了它以$符号开头.因为代码在定义属性的时候不能以$开头,所以映射值永远不会对你定义的属性有影响.
         
         在上面的SmallNumber的例子中,如果你尝试给其赋值一个很大的number,属性包装会在存储之前进行调整
         .下面的代码在SmallNumber结构体中添加了一个projectedValue属性用来记录在存储新值之前,属性包装值是否进行了调整.
         */
        
        @propertyWrapper
        struct SmallNumber {
            private var number:Int
            var projectedValue:Bool
            init() {
                self.number = 0
                self.projectedValue = false
            }
            
            var wrappedValue:Int {
                get {
                    return number
                }
                set {
                    if newValue > 12 {
                        number = 12
                        projectedValue = true
                    } else {
                        number = newValue
                        projectedValue = false
                    }
                }
            }
        }
        
        struct SomeStruture {
            @SmallNumber var someNumber:Int
            
        }
        var someStructure = SomeStruture()
        someStructure.someNumber = 4
        //false  使用 someStructure.$someNumber 获取包装的projectedValue的值.
        print(someStructure.$someNumber)
        
        someStructure.someNumber = 55
        //true
        print(someStructure.$someNumber)
        
        
        enum Size {
            case small,large
        }
        
        struct SizedRectangle {
            @SmallNumber var height:Int
            @SmallNumber var width:Int
            
            //注意:结构体和枚举中的方法默认情况下是不能修改属性的.如果需要修改要将方法声明为可变的(mutating)
            mutating func resize(to size:Size)->Bool {
                switch size {
                case .small:
                    height = 10
                    width  = 20
                case .large:
                    height = 100
                    width  = 100
                }
                return $height || $width
            }
        }
        
        /* 因为属性包装语法其实是属性的getter和setter方法的语法糖,访问height和width向访问其他属性的行为一样.例如,代码中resize(to:)
         访问height 和 width 使用它们的包装属性
         */
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
        
        
        
        //2.Querying and Setting Type Properties  (访问和设置类型属性)
        print(SomeStructure.storedTypeProperty)
        SomeStructure.storedTypeProperty = "Another values."
        
        struct AudioChannel {
            //定义只读属性
            static var thresholdLevel : Int {
                return 10
            }
            static var maxInputLevelForAllChannels = 0
            
            var currentLebel:Int = 0 {
                didSet {
                    if currentLebel > AudioChannel.thresholdLevel {
                        currentLebel = AudioChannel.thresholdLevel
                    }
                    if currentLebel > AudioChannel.maxInputLevelForAllChannels {
                        AudioChannel.maxInputLevelForAllChannels = currentLebel;
                    }
                }
            }
        }
        var leftChannel  = AudioChannel()
        var rightChannel = AudioChannel()
        
        leftChannel.currentLebel = 7
        print(leftChannel.currentLebel) //7
        print(AudioChannel.maxInputLevelForAllChannels) //7
    }
    
    // MARK: - Class And Instance Method (类和实例方法)
    
    @objc func ClassAndInstanceMethod()  {
        /* 实际上结构体和枚举可以定义方法是Swift和OC的主要区别.在OC中只有类可以定义方法.
         在Swift中可以选择,类,结构体,枚举来灵活的定义方法.
         */
        //1.Instance Method  (实例方法) 属于一个固定的类,结构体或者枚举的实例.
        //实例方法中可以隐式获取该类型的其他实实例方法或者属性.
        class Counter {
            var count = 0
            func increment()  {
                count += 1
            }
            func increment(by amount:Int)  {
                count += amount
            }
            
            func deduct(number:Int)  {
                self.count -= number
            }
            
            func reset()  {
                count = 0
            }
        }
        
        //2.The self Property
        
        //每个实例对象都有一个名为self的隐藏属性.和实例对象本身等价.可以通过self引用实例对象内部的实例方法.
        //如果deduct方法中引用 count 属性
        //实际上,我们并不一定需要写self,当我们在一个实例方法内部时,系统假定我们引用的属性或者方法都是当前的实例对象的.
        //除了一些情况出现时,如:一个实例变量的实例方法中的参数名与实例的属性名相同时,参数名是优先响应的.此时如果要引用
        //实例属性,就需要加上self,用来区分是引用的函数参数还是实例属性.
        //如下事例:函数中的变量x与属性x
        struct Point {
            var x  = 0.0, y = 0.0
            func isToTheRightOf(x:Double) -> Bool {
                return self.x > x;
            }
        }
        
        let somePoint = Point(x: 4.0, y: 5.0)
        if somePoint.isToTheRightOf(x: 1.0) {
            print("This point is to the right of the line where x == 1.0")
        }
    }
    
    // MARK: - Modifying Value Types From Within Instance Methods (值类型在实例方法中的修改)
    @objc func ModifyingValueTypesFromWithinInstanceMethods()  {
        //结构体和枚举都是值类型.默认情况下,属性的值不能在实例方法中修改.
        //如果需要在结构体/枚举的实例方法中修改属性,需要在方法前使用mutating关键词来标记该行为.该方法可以在方法内部修改属性,并且在方法结束的时候
        //把改变赋给对应的恶属性.
        struct Point {
            var x = 0.0,y = 0.0
            mutating func moveBy(x deltaX:Double,y deltaY:Double) {
                x += deltaX
                y += deltaY
            }
        }
        var somePoint = Point(x: 1.0, y: 1.0)
        somePoint.moveBy(x: 2.0, y: 3.0)
        print("The point is now at:(\(somePoint.x),\(somePoint.y))")
        //The point is now at:(3.0,4.0)
        //注意:如果是一个结构体的常量实例,不能调用mutating修饰的方法,因为其属性不允许改变,即使这些属性是可变的
        //因为结构体/枚举是值类型.
        let fixedPoint = Point(x: 3.0, y: 3.0)
        //         调用下面的函数将会报错
        //        fixedPoint.moveBy(x: 1.0, y: 1.0)
        
        //2.Assigning to self Within a Mutating Method (在mutating方法内部给当前实例赋值)
        //mutating方法可以完全复制给隐式属性self赋一个全新的实例变量.
        
        struct Point2 {
            var x  = 0.0,y = 0.0
            //使用x和y设置目标位置,创建了一个新的结构体
            mutating func moveBy(x deltaX:Double,y deltaY:Double) {
                self = Point2 (x: x + deltaX, y: y + deltaY)
            }
        }
        
        //枚举的mutating 方法在同一个枚举的可以隐式设置self参数为不同的案例.
        enum TriStateSwitch {
            case off,low,high
            mutating func next()  {
                switch self {
                case .off:
                    self = .low
                case .low:
                    self = .high
                case .high:
                    self = .off
                }
            }
        }
        
        var ovenLight = TriStateSwitch.low
        ovenLight.next()
        print(ovenLight)//high
        
        ovenLight.next()
        print(ovenLight)//off
        
        
        //3.Type Method (类型方法)
        //由类型本身调用的方法叫做类型方法.通过在方法名前添加static关键词,来表述这是一个类型方法.
        //如果是Class可以使用class关键词代替,并且允许子类重写父类的方法.
        //注意:在OC中只有Class可以定义类型级别的方法.在Swift中,你可以在类,结构体,以及枚举中定义类型方法.
        class SomeClass {
            class func someTypeMethod() {
                
            }
        }
        //类型方法的创建于调用
        SomeClass.someTypeMethod()
        
        struct LevelTracker {
            static var highestUnlockedLevel = 1
            var currentLevel = 1
            static  func unlock(_ level:Int)  {
                if level > highestUnlockedLevel {
                    highestUnlockedLevel = level
                }
            }
            
            static  func isUnlocked(_ level:Int) -> Bool  {
                return level <= highestUnlockedLevel
            }
            
            @discardableResult
            //@discardableResult 关键词标记的函数,可以忽略返回值.(如果有返回值未使用的情况下,可能会出现警告,使用该关键词就可以忽略警告)
            mutating  func advance(to level:Int)-> Bool  {
                if LevelTracker.isUnlocked(level) {
                    currentLevel = level
                    return true
                } else {
                    return false
                }
            }
        }
        
        class Player {
            var tracker = LevelTracker()
            var playerName:String
            func complete(levevl:Int)  {
                LevelTracker.unlock(levevl + 1)
                //忽略了advance(_)函数的返回值
                tracker.advance(to: levevl + 1)
            }
            init(name:String) {
                playerName = name
            }
        }
        
        var player = Player(name: "Argytios")
        player.complete(levevl: 1)
        print("Highest unlocked level is now\(LevelTracker.highestUnlockedLevel)")
        //Highest unlocked level is now2
        
        //如果新建一个玩家,并尝试着移动该游戏中没有任何一个玩家达到的等级,尝试获取这个玩家的当前等级会失败
        player = Player(name: "Beto")
        if player.tracker.advance(to: 6) {
            print("player is now on level 6")
        } else {
            print("level 6 has not yet been unlocked")
        }
        //level 6 has not yet been unlocked

    }
    
}
