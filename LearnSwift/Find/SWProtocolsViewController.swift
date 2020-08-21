//
//  SWProtocolsViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/8/12.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class Dice {
    let sides : Int
    let generator : RandomNumberGenerator
    init(sides:Int,generator:RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int  {
        return Int(generator.random() * Double(sides)) + 1
    }
}

//RandomNumberGenerator 协议中定义了 random的实例函数,
class LinearCongruentialGenerator : RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy: m))
        return lastRandom/m
    }
}


struct Hamster  {
    var name:String
    var textualDescription: String {
        return "A hamster named\(name)"
    }
}

class SWProtocolsViewController: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefaultData()
    }
    
    
    func p_initDefaultData() -> Void {
        self.title = "Protocols(协议)";
        listArray.append("ProtocolsConcept")
        listArray.append("ProtocolsUse")
        listArray.append("InitializerRequirements")
        listArray.append("Delegation")
        listArray.append("AddingProtocolConformanceWithAnExtension")
        listArray.append("ProtocolExtensions")
        self.view.addSubview(self.tableView);
        tableView.reloadData()
    }
    
    // MARK: - Protocols Concept
    @objc  func ProtocolsConcept()  {
        /* 协议定义了方法,属性,或者其他需求用来满足一个特殊任务或者一段功能的蓝图.协议可以通过继承类,结构体,枚举来提供这些需要的实现.
         任何满足协议的需求类,称为遵从了该协议.
         
         协议语法:
         protocol SomeProtocol {
         
         }
         
         
         //遵从相关协议语法:
         struct SomeStructure:FirstProtocol,SecondProtocol {
         
         }
         
         //如果一个class有父类,则把父类放在最前面
         class SomeStructure:BaseClass,FirstProtocol,SecondProtocol {
         
         }
         */
        
        //2.Property Requirements
        //属性需求总是用关键词var来表述该属性为可变的属性.通过在定义的时候来放置对应的getter和setter方法
        /*
         protocol SomeProtocol {
         
         var name : String {get,set}
         
         }
         */
        
        //参考  Protocol.swift的相关内容
        //FullyNamed 协议需要遵从的类型提供一个完整的认证名,该协议没有描述遵从该协议类型的本质,
        //只要遵从该协议并且其本身提供一个fullname方法就行.
        //该协议表明,任何遵从FullyNamed协议的类型,必须要有一个名称为fullName的可读的实例String属性,如下例:
        struct Person:FullyNamed {
            var fullName: String
        }
        let john = Person(fullName: "John Applesseed")
        print(john.fullName)
        //John Applesseed
    }
    
    // MARK: - Protocols Use
    @objc  func ProtocolsUse()  {
        class Starship : FullyNamed {
            var prefix:String?
            var name: String
            
            init(name:String,prefix:String? = nil) {
                self.name = name
                self.prefix = prefix
            }
            
            var fullName: String {
                return (prefix != nil ? prefix! + " ":"") + name
            }
        }
        
        var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
        print(ncc1701.fullName)
        //USS Enterprise
        
        
        //2.Method Requirements
        //通过遵循协议,来实现协议中提供的实例方法或者类型方法.
        //这些方法在协议中,作为定义协议的一部分,与正常的实例方法或者类型方法一样,只不过没有用大括号包裹函数体.
        /*
         protocol SomeProtocol {
         static func someTypeMethod()
         func random() -> Double
         }
         */
        
        
        let generator = LinearCongruentialGenerator()
        print("Here's a random number:\(generator.random())")
        //Here's a random number:0.3746499199817101
        print("And another one: \(generator.random())")
        //And another one: 0.729023776863283
        
        
        //3.Mutating Method Requirements
        //如果协议中定义的方法意图是尊从该协议可以修改相关实例,在声明该协议的时候使用mutating 关键词标记.
        //这就使得枚举/结构体继遵循该协议之后可以进行相应的修改.
        //注意:如果协议中声明的方法使用mutating关键词标记,在class遵从该协议的时候,实现该方法时不用添加mutating关键词,在枚举/结构体中
        //需要添加该关键词.
        enum OnOffSwitch : Togglable {
            case off,on
            mutating func toggle() {
                switch self {
                case .off:
                    self = .on
                case .on:
                    self = .off
                }
            }
            
        }
        
        var lightSwitch = OnOffSwitch.off
        lightSwitch.toggle()
        //lightSwitch is  now equal to .on
        
    }
    
    // MARK: - Initializer Requirements
    @objc  func InitializerRequirements()  {
        /*protocol SomeProtocol {
         init (someParamter:Int)
         }
         */
        class SomeSuperClass {
            init() {
                
            }
        }
        
        class SomeSubClass : SomeSuperClass,SomePtorocol {
            required override init() {
                
            }
        }
        
        
        //2.Protocols As Types
        //可以在允许使用其他类型的地方使用协议.包含
        //1.函数,实例方法或者初始化方法的参数或者返回类型
        //2.常量/变量,或者属性的类型
        //3.作为数组,字典或者其它容器的元素类型.
        
        //generator 是RandomNumberGenerator 协议类型,因此可以把该参数设置为任何遵从该协议的类型.
        
        class LinearCongruentialGenerator2 : RandomNumberGenerator {
            var lastRandom = 42.0
            let m = 139968.0
            let a = 3877.0
            let c = 29573.0
            func random() -> Double {
                lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy: m))
                return lastRandom/m
            }
        }
        
        var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator2())
        for _ in 1...5 {
            print("Random dice roll is\(d6.roll())")
        }
        //Random dice roll is3
        //        Random dice roll is5
        //        Random dice roll is4
        //        Random dice roll is5
        //        Random dice roll is4
    }
    
    // MARK: - Delegation
    @objc  func Delegation()  {
        /* 委托是一种设计模式,可以把一个类或者结构的一些职责委托到别的类型的实例中.
         为了防止代理与委托者之间互相强引用,因此delegate使用weak标识的弱引用.
         */
        let tracker = DiceGameTracker()
        let game = SnakesAndLadders()
        game.delegate = tracker
        game.play()
        //通过扩展来实现相关协议
        print(game.textualDescription)
        //        Started a new game of Snakes and Ladders
        //        The game is using a 6 -sided dice
        //        Rolled a 3
        //        The game lasted for 1 turns
        //        Rolled a 5
        //        The game lasted for 2 turns
        //        Rolled a 4
        //        The game lasted for 3 turns
        //        Rolled a 5
    }
    
    // MARK: - Adding Protocol Conformance With An Extension
    @objc func AddingProtocolConformanceWithAnExtension()  {
        //协议名紧跟着类型名之后,通过:分隔开,在扩展的大括号范围内添加所有协议需要提供的实现.
        //参照Extensions.swift 与Protocol.swift中的
        //extension Dice:TextRepresentable 以及 protocol TextRepresentable
        //现在任何Dice的实例都可以当做TextRepresentable:来处理
        let dic2 = Dice(sides: 12, generator: LinearCongruentialGenerator())
        print(dic2.textualDescription)
        //A 12-sided dice
        //同样SnakesAndLadders也可以通过扩展来实现TextRepresentable协议;
        
        
        //2.Condictionally Conforming to a Protocol (根据条件遵从相关协议)
        //下面的扩展使数组实例遵循了TextRepresentable协议,仅仅存储这些遵从了TextRepresentable的协议的元素
        //Extensions.swift Array扩展
        
        
        //3.Declaring Protocol Adoption with an Extension
        //如果一个类型已经实现来了一个协议的需要,但是没有声明遵从该协议,可以使用一个空的扩展来遵从该协议.
        let simonTheHamster = Hamster(name: "Simon")
        let somethingTextRepresentable:TextRepresentable = simonTheHamster
        print(somethingTextRepresentable.textualDescription)
        //"A Hamster named Simon"
        
        
        //4.Collections of Protocol Types (集合中的协议类型)
        let things:[TextRepresentable] = [simonTheHamster,dic2]
        for thing in things {
            print(thing.textualDescription)
        }
        //注意:things中的常量类型是TextRepresentable协议类型,不是Hamster,或者Dice类型.
        
        //5.Protocol Inheritance  参照protocol PrettyTextRepresentable : TextRepresentable
        
        
        //6.Class-Only Protocols
        //通过协议在声明的时候在在继承列表里面添加AnyObject可以限制协议只能由Class遵从
        //protocol SomeClassOnlyprocol : AnyObject,TextRepresentable
        //SomeClassOnlyprocol协议只能通过Class来遵从,如果让枚举或者结构体来遵从该协议会报错,如下会报错
//        struct TestStruct:SomeClassOnlyprocol {
//
//        }
        class TestClass : SomeClassOnlyprocol {
            var textualDescription: String {
                return "ClassOnlyProtocols"
            }
        }
        
        
        //7.Protocol Composition (协议组合)
        //有时一个类型需要同时遵从多个协议.此时就可以把多个协议组合在一起,协议组合的形式如下:
        //SomeProtocol & AnotherProtocol....,如下事例
        
        //协议组合 (同时遵守Named和Aged 协议 )
        func wishHappyBirthday(to celebrator:Named & Aged)  {
            print("Haapy birthday, \(celebrator.name),you're \(celebrator.age)!")
        }
        let birthdayPerson = Person(name: "Malcolm", age: 21)
        wishHappyBirthday(to: birthdayPerson)
        
        
        func beginConcert(in location:Location & Named)  {
            print("Hello, \(location.name) !")
        }
        
        let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
        beginConcert(in: seattle)
        //"Hello,Seattle"
        
        
        //8.Checking for Protocol Conformance
        //使用is 或者as 操作符来检查遵从协议.
        //1.is 操作符返回true,如果一个实例遵从协议,如果没有返回false
        //2. as? 如果遵守该协议返回协议的类型值,如果不是返回nil
        //3. as! 如果解包不成功会报错
//        Protocol.swift 中定义的,Circle,Country,Animal没有共同的基类.
        let objects:[AnyObject] = [
            Circle(radius: 2.0),
            Country(area: 243_610),
            Animal(legs: 4)
        ]
        //遍历该数组,来检测每一个元素是否遵从了HasArea协议
        for object in objects {
            if let objectWithArea = object as? HasArea {
                print("Area is \(objectWithArea.area)")
            } else {
                print("Somethind that does't have an area")
            }
        }
        
        
        //9 Optional Protocol Requirements (可选协议需求)
        /*
         可以定义可选型的协议,也就是这些协议并不一定需要实现该协议.可选型协议在Swift中和OC中都是可用的,在可选型协议中需要使用@objc 关键词来表明.
         注意:@objc表明的而协议,只能有OC中的类遵从或者其他使用了@objc标记的类.这些协议不能被结构体或者枚举类型遵从.
         
         注意:当在一个可选的协议中声明的方法或者属性时,其类型自动变为可选型.整个函数的功能被包装为可选型,而不是函数的返回值为可选型.
         
         */
        
        class Counter {
            var count = 0
            var dataSource:CounterDataSource?
            func increment()  {
                if let amount = dataSource?.increment?(forCount: count) {
                    count += amount
                }
                else if let amount = dataSource?.fixedIncremnt {
                    count += amount
                }
            }
        }
        
        class ThreeSource : CounterDataSource {
            let fixedIncremnt = 3
        }
        
        var counter = Counter()
        counter.dataSource = ThreeSource()
        for _ in 1...4 {
            counter.increment()
            print(counter.count)
        }
        
        class TowardsZeroSource : CounterDataSource {
            func increment(forCount count: Int) -> Int {
                if count == 0 {
                    return 0
                } else if count < 0 {
                    return 1
                } else {
                    return -1
                }
            }
        }
        
        counter.count = -4
        counter.dataSource = TowardsZeroSource()
        for _ in 1...5 {
            counter.increment()
            print(counter.count)
        }
    }
    
    // MARK: - Protocol Extensions
    @objc  func ProtocolExtensions()  {
//        Extensions.swift   RandomNumberGenerator 扩展
        let generator = LinearCongruentialGenerator()
        print("Here's a random number:\(generator.random())")
        //Here's a random number:0.3746499199817101
        print("And here's a random boolvalue:\(generator.randomBool())")
        //And here's a random boolvalue:true
        
        /* 对协议进行扩展可以对遵从协议的类型添加实现,但是不能使用协议扩展或者继承另一个协议.
         协议的继承总是在声明的时候就已定确定了.
         */
        
        
        //2.Providing Default implementations
        /* 可以使用协议的扩展对于遵循协议的类型,提供方法的或者计算属性的默认实现.如果遵从协议的类有其自己对方法或者属性的实现,
         该实现将会取代扩展的实现.示例如下
         extension TextRepresentable
         */
        
        
        //3.Adding Constraints to Protocol Extensions
        //当定义一个协议扩展的时候,可以通过加一些条件,使得遵从协议的类型,在可以使用方法或者属性之前,必须要满足这些条件.
        //通过在协议扩展的名字之后加上where语句.
        //例如:对于Collection扩展协议,可以添加条件为:要遵从该协议的类型必须遵从Equatable协议.通过在协议扩展之后,使用where
        //语句,使得遵从该协议的元素都满足该协议需求.可以使用==或者!=操作符来检测两个元素是相等还是不相等
        //extension Collection where Element:Equatable 事例
        let equalNumbers = [100,100,100,100]
        let differNumbers = [100,200,100,100]
        //数组遵从Collection协议,整数类型遵从Equatable协议,因此两个数组均可以使用allEqual()方法
        print("equalNumbers:\(equalNumbers.allEqual()) ") //equalNumbers:true
        print("differNumbers:\(differNumbers.allEqual()) ") //differNumbers:false
        
    }
    
}





class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board : [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08;board[06] = +11; board[09] = +09;board[10] = +02;
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08;
    }
    weak var delegate:DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        
        gameLoop:while square != finalSquare {
            let diceRool = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRool)
            switch square + diceRool {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare :
                continue gameLoop
            default:
                square += diceRool
                square += board[square]
            }
            delegate?.gameDidEnd(self)
        }
    }
}


/// 该Class 遵从DiceGameDelegate
class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    // MARK: - DiceGameDelegate
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides) -sided dice")
    }
    
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
}


/// 因为CounterDataSource协议中的函数和变量都是可选型的,所以遵从该协议时,并不需要执行相关协议也不会报错.
class TestClass : CounterDataSource {
    
}
