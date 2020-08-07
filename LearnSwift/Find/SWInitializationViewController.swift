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
        listArray.append("FailableInitializers")
        listArray.append("Deinitialization")
        listArray.append("DefineingModelClassesForOptionalChaining")
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
        
        class RecipeIngredient : Food {
            var quantity:Int
            init(name:String,quantity:Int) {
                self.quantity = quantity
                super.init(name: name)
            }
            
            convenience override init(name:String) {
                self.init(name:name,quantity:1)
            }
        }
        
        //以上这些初始化方法都可以创建RecipeIngredient 实例对象
        let oneMysteryItem = RecipeIngredient()
        //1 [Unnamed]
        let oneBacon = RecipeIngredient(name: "Bacon")
        let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
        print(oneMysteryItem.quantity,oneMysteryItem.name)
        
        class ShoppingListItem : RecipeIngredient {
            var purchased = false
            //计算属性
            var description:String {
                var output = "\(quantity) x \(name)"
                output += purchased ? "✔️" : "X"
                return output
            }
        }
        
        var breakfastList = [
            ShoppingListItem(),
            ShoppingListItem(name: "Bacon"),
            ShoppingListItem(name: "Eggs", quantity: 6),
        ]
        breakfastList[0].name = "Orange jujice"
        breakfastList[0].purchased = true
        for item in breakfastList {
            print(item.description)
        }
        //        1 x Orange jujice✔️
        //        1 x BaconX
        //        6 x EggsX
    }
    
    // MARK: - Failable Initializers (不可靠的初始化函数)
    @objc func FailableInitializers()  {
        //注意:不能定义一个错误的初始化函数与一个没错误的初始化函数有相同的参数类型和参数名.
        //例如,对于数值型转换的失败的初始化函数的实施.为了确保在转换的同时保持正确的数值,使用init(exactly:)初始化函数.
        //如果类型转换后没有保持正确的值,函数失败
        let wholeNumber : Double = 12345.0
        let pi = 3.14159
        if let valueMaintained = Int(exactly: wholeNumber) {
            print("\(wholeNumber) conversation to Int maintains value of\(valueMaintained)")
        }
        //12345.0 conversation to Int maintains value of12345
        
        let valueChanged = Int(exactly: pi)
        if valueChanged == nil{
            print("\(pi) conversion to int does not maintain value")
        }
        //3.14159 conversion to int does not maintain value
        
        //如下事例:定义了一个名为Animal的结构体,有一个类型为string名为species的常量属性
        //也有一个失败的初始化函数,来检查传入的species 是否为空字符串,如果是的就失败.否则就成功
        struct Animal {
            let species : String
            init?(species:String) {
                if species.isEmpty {
                    return nil
                }
                self.species = species
            }
        }
        
        let someCreature = Animal(species: "Giraffe")
        //someCreature 是一个Animal的可选型Animal?
        
        guard let giraffe = someCreature  else {
            return
        }
        print("An animal was initialized with a species of\(giraffe.species)")
        //An animal was initialized with a species ofGiraffe
        
        let annoymouseCreature = Animal(species: "")
        //The anoymous creature could not be initialized
        guard let _ =  annoymouseCreature else {
            print("The anoymous creature could not be initialized")
            return
        }
        
        
        //2.Failable Initializers for Enumerations
        enum TemperatureUnit {
            case kelvin,celsius,fahreheit
            init?(symbol:Character) {
                switch symbol {
                case "K":
                    self = .kelvin
                case "C":
                    self = .celsius
                case "F":
                    self = .fahreheit
                default:
                    return nil
                }
            }
        }
        let fahrenheitUnit = TemperatureUnit(symbol: "F")
        if fahrenheitUnit != nil {
            print("This is a defined temperature unit,so initialization succeeed.")
        }
        let unknownUnit = TemperatureUnit(symbol: "X")
        if unknownUnit == nil {
            print("This is not a defined temperature unit ,so initialization failed.")
        }
        
        
        //3.Failable Initializers for Enumerations with Raw Values
        //使用原始值初始化的枚举自动接收一个可失败的从初始化函数,init?(rawValue:),也就是意味着如果原始值合适并且有对应的案例正常执行
        //否则就是没有匹配的值,就会触发初始化失败.
        enum TemperatureUnit2 : Character  {
            case kelvin = "K",celsius = "C",fahrenheit = "F"
        }
        let fahrenheit = TemperatureUnit2(rawValue: "F")
        if fahrenheit != nil {
            print("This is a defined temperature unit,so initialization succeed.")
        }
        //"This is a defined temperature unit,so initialization succeed."
        
        let unknownUnit2 = TemperatureUnit2(rawValue: "X")
        if unknownUnit2 == nil {
            print("This is not a defined temperature unit,so initialization faield.")
        }
        //This is not a defined temperature unit,so initialization faield.
        
        
        //4.Propagation of Initialization Failure (初始化失败的传递)
        class Product  {
            let name : String
            init?(name:String) {
                if name.isEmpty {
                    return nil
                }
                self.name = name
            }
        }
        
        class CartItem : Product {
            let quantity : Int
            init?(name: String,quantity:Int) {
                if quantity < 1 {
                    return nil
                }
                self.quantity = quantity
                super.init(name: name)
            }
        }
        
        if let twoSocks = CartItem(name: "sock", quantity: 2) {
            print("Item:\(twoSocks.name),quantity:\(twoSocks.quantity)")
        }
        //"Item:sock,quantity:2"
        
        if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
            
        } else {
            print("unable to initialize zero shirts")
        }
        //unable to initialize zero shirts
        
        
        //4.Overring a Failable Initializer (重写失败的初始化函数)
        class Document  {
            var name:String?
            init() {
            }
            init?(name:String) {
                if name.isEmpty {
                    return nil
                }
                self.name = name
            }
        }
        
        class AuotomaticallyNamedDocument : Document {
            override init() {
                super.init()
                self.name = "[Untitled]"
            }
            //重写父类的可能会失败的初始化函数,使用一个不会失败的初始化函数
            override init(name: String) {
                super.init()
                if name.isEmpty {
                    self.name = "[Untitled]"
                } else {
                    self.name = name
                }
            }
        }
        
        //在调用父类可能失败的初始化函数时,可以使用强制解包的方式作为子类非失败初始化函数功能的一部分.
        class UntitledDocument : Document {
            override init() {
                //强制解包
                super.init(name: "[Untitled]")!
            }
        }
        
        
        //5.Required Initializers (需要初始化函数)
        //在函数之前加上required关键词来表示每个子类必须要实现该函数
        class SomeClass  {
            required init() {
                
            }
        }
        
        
        //6.Setting a Default Property Value with a Closure or Function
        class SomeClass2  {
            //立即执行函数
            let somePorperty : String =  {
                return "ac"
            }()
        }
        //注意:如果使用闭包来初始化属性,在闭包执行的时候类实例还没有执行完成.这表明,我们不能在闭包中获取类属性的其他属性,
        //即使这些属性有默认值.我们也不能在闭包内使用self属性,或者实例的方法.
    }
    
    // MARK: - Deinitialization
    @objc func Deinitialization()  {
        /* 调用 deinitializers函数是哟deinit关键词,仅仅在class中可用
         */
        //1.Deinitializers in Action (析构的行为)
        
        class Bank  {
            static var coinsInBank = 10_1000
            static  func distribute(coins numberOfConinsRequested:Int) ->Int  {
                let numberOfCoinsToVend = min(numberOfConinsRequested, coinsInBank)
                coinsInBank -= numberOfCoinsToVend
                return numberOfCoinsToVend
            }
            static  func receive(coins:Int)  {
                coinsInBank += coins
            }
        }
        
        class Player  {
            var coinsInPurse:Int
            init(coins:Int) {
                coinsInPurse = Bank.distribute(coins: coins)
            }
            func win(coins:Int)  {
                coinsInPurse += Bank.distribute(coins: coins)
            }
            //资源回收,该实例变量回收时,把硬币回归银行
            deinit {
                Bank.receive(coins: coinsInPurse)
            }
        }
        
        var playerOne:Player? = Player(coins: 100)
        print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
        //A new player has joined the game with 100 coins
        print("There are now \(Bank.coinsInBank) coins left in the bank")
        //There are now 9900 coins left in the bank
        
        playerOne!.win(coins: 2_000)
        print("PlayerOne won 2000 coins &now has \(playerOne!.coinsInPurse) coins")
        
        playerOne = nil
        //PlayerOne has left the game
        print("PlayerOne has left the game")
        
        //The bank now has101000 coins
        print("The bank now has\(Bank.coinsInBank) coins")
    }
    
    
    // MARK: - Defineing Model Classes For Optional Chaining (类的可选型链式调用)
    @objc func DefineingModelClassesForOptionalChaining()  {
        class Room  {
            let name : String
            init(name:String) {
                self.name = name
            }
        }
        
        class Person  {
            var residence:Residence?
        }
        
        class Address  {
            var buildingName:String?
            var buildingNumber:String?
            var street:String?
            func buildingIdentifier() -> String?   {
                if let buildingNumber = buildingNumber,let street = street {
                    return "\(buildingNumber) \(street)"
                } else if buildingName != nil {
                    return buildingName
                } else {
                    return nil
                }
            }
        }
        
        class Residence  {
            //存储属性
            var rooms = [Room]()
            
            //计算属性
            var numberOfRooms:Int {
                return rooms.count
            }
            
            subscript(i:Int)->Room {
                get {
                    return rooms[i]
                }
                set {
                    rooms[i] = newValue
                }
            }
            
            func printNumberOfRooms()  {
                print("The number of roos is \(numberOfRooms)")
            }
            
            var address:Address?
        }
        
        //2.Accessing Properties Through Optional Chaining
        //使用上述的class来创建一个Person实例,并且尝试获取其numberOfRooms属性
        let join = Person()
        if let roomCount = join.residence?.numberOfRooms {
            print("Join's residence has \(roomCount) rooms.")
        } else {
            print("Unable to retrive the number of rooms")
        }
        //Unable to retrive the number of rooms
        //因为 join.residence 的值为nil,该可选型链会调用失败
        let someAddress = Address()
        someAddress.buildingNumber = "29"
        someAddress.street = "Acacia Road"
        join.residence?.address = someAddress
        //也是无法正常获取相关值,因为  join.residence的值为nil,就不会继续往下执行了,如下测试:
        
        func createAddress()->Address  {
            print("Function was called.")
            let someAddress = Address()
            someAddress.buildingNumber = "29"
            someAddress.street = "Acacia Road"
            return someAddress
        }
        
        join.residence?.address = createAddress()
        //发现 createAddress() 函数并没有调用,也就是在判定join.residence的值为nil的时候,链就已经断开了.
        
        
        //3.Calling Methods Through Optional Chaining
        //检测调用printNumberOfRooms的返回值是不是为nil来判定来函数是不是成功被调用
        if join.residence?.printNumberOfRooms() != nil {
            print("call printNumberOfRooms methods success")
        } else {
            print("call printNumberOfRooms methods failure")
        }
        //call printNumberOfRooms methods failure
        
        
        //4.Accessing Subscripts Through Optional Chaining
        //注意:如果你在可选型联调中通过下标来获取一个可选型的值,"?" 放在[]之前,而不是之后,如下:
        if let firstRoomName = join.residence?[0].name {
            print("The fitst room name is \(firstRoomName)")
        } else {
            print("Unable ro retrive the first room name.")
        }
        //print("Unable ro retrive the first room name.")
        
        //如果给join.residence赋值的同时,把Room实例对象里面的房间数组也有一个或者多个值,可以正常访问
        let joinHouse = Residence()
        joinHouse.rooms.append(Room(name: "Living Room"))
        joinHouse.rooms.append(Room(name: "KITCHEN"))
        join.residence = joinHouse
        
        if let firstRoomName = join.residence?[0].name {
            print("The fitst room name is \(firstRoomName)")
        } else {
            print("Unable ro retrive the first room name.")
        }
        //The fitst room name is Living Room
        
        
        //5.Accessing Subscripts of Optional Type
        //如果下标的返回值是一个可选型的值,就像字典类型一样.在返回的可选型值之后,也就是[]之后放置?
        var testScore = ["Dave":[86,82,84],"Bev":[79,94,81]]
        testScore["Dave"]?[0] = 91
        testScore["Bev"]?[0] += 1
        //失败,因为testScore 没有该key对应的值
        testScore["Brain"]?[0] = 72
        
        
        //6.Linking Multiple Levels of Chaining (关联多级链式)
        //为了获取更深层的属性,方法或者下标,可以把多个可选型链条连接在一起
        //1.如果你获取的值不是可选型的,由于可选型链条的原因,该值将会变成可选型
        //2.如果你获取的值是可选型的,该值不会因为链式变成多层可选型.
        
        //下面展示了两层可选型链条用来获取相关的属性
        if let johnsStreet = join.residence?.address?.street {
            print("Join's street name is \(johnsStreet).")
        } else {
            print("Unable ro retrive the address.")
        }
        //Unable ro retrive the address.
        
        //给residence?.address 属性赋上一个值
        let address = Address()
        address.buildingName = "The larches"
        address.street = "Laurel Street"
        join.residence?.address = address
        
        if let johnsStreet = join.residence?.address?.street {
            print("Join's street name is \(johnsStreet).")
        } else {
            print("Unable ro retrive the address.")
        }
        //Join's street name is Laurel Street.
        
        
        
        //6.Chaining on Methods with Optional Return Values (链式上带有可选返回值的方法)
        //下面展示了通过可选型链来获取buildingIdentifier函数的可选返回值
        if let buildingIdentifier = join.residence?.address?.buildingIdentifier() {
            print("Join's building identifier is \(buildingIdentifier)")
        }
        
        //如果想对返回值做更深层的操作,在返回值之后使用?标记来进行相关操作
        
        if let beginWithThe = join.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
            print("Join's building identifier begin With \"The\"")
        } else {
            print("Join's building identifier does not  begin With \"The\"")
        }
        //注意:上例在链式可选型方法后面的大括号放置?,是因为该链式可选型方法的返回值是可选型的,而不是buildingIdentifier() 函数其本身
        

        
        
        
        
        

        
    }
    
    
}
