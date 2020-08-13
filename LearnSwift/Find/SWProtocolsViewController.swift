//
//  SWProtocolsViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/8/12.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

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
        
    }
}
