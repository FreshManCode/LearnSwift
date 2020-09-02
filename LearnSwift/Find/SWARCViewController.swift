//
//  SWARCViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/8/27.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWARCViewController: SWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefaultData()
    }
    

    
    func p_initDefaultData() -> Void {
        self.title = "AutomaticReferenceCounting(ARC)";
        listArray.append("Introduction")
        listArray.append("StrongReferenceCyclesForClosures")
        self.view.addSubview(self.tableView);
        tableView.reloadData()
    }
    
    // MARK: - Introduction (简介)
    @objc  func Introduction()  {
        /* 引用计算只适用于类的实例.结构体和枚举是值类型,不是引用类型,并且不能通过引用存储和传递*/
        
        var reference1 :Person?
        var reference2 :Person?
        var reference3 :Person?
        reference1 = Person(name: "John Applesseed")
        //1.ARC in Action
        class Person  {
            let name : String
            init(name:String) {
                self.name = name
                print("\(name) is being initialization")
            }
            var apartment :Apartment?
            
            deinit {
                print("\(name) is being deinitialized")
            }
            
        }
        
        class Apartment {
            let unit : String
            init(unit:String) {
                self.unit = unit
            }
            var tenant :Person?
            deinit {
                print("Apartment \(unit) is being deinitialization")
            }
        }
        
        //2.Strong Reference Cycles Between Class Instances
        var john : Person?
        var unit4A:Apartment?
        
        john = Person(name: "John")
        unit4A = Apartment(unit: "4A")
        
        //把两个强引用互相链接起来
        john?.apartment = unit4A
        unit4A?.tenant  = john
        
        //现在即使把john和unit4A两个变量回收,两者的引用计算也不会为0,因为强应用导致它们没有释放.
        john = nil
        unit4A = nil
        
        //现在两个实例的deinit 函数均没有执行.
        
        
        //3.Resolving Strong reference cycles between class instances
        //Swift提供了两种解决强引用的方法,一种是weak引用,一种是unowned 引用.
        /* 当一个实例有较短的生命周期时使用weak引用,也就是先释放的用weak修饰.在Apartment类中,对于Apartment实例来说,有可能在某个使其没有
         apartment,因为weak在这种情况下就比较适合解决循环引用问题.相反当另一个实例有相同的声明或者更长的声明周期时 使用unowned引用.
         */
        
        //1.Weak Reference
        //弱引用是一种不会对引用的实例产生强持有.很可能弱引用还存在,但是实例已经被释放了.因此ARC自动把弱引用设置为你来,当其引用的对象
        //释放的时候.因为弱引用允许它们的值在运行时改变,所以经常被声明为var类型,而不是常量类型,或者可选类型.
        //注意:当ARC把弱引用置位nil时,刷新观察方法不会调用.
        
        class Apartment2 {
            let unit : String
            init(unit:String) {
                self.unit = unit
            }
            weak var tenant :Person?
            deinit {
                print("Apartment2 \(unit) is being deinitialization")
            }
        }

        
        //4.Unowned References
        //与weak引用不同的是,当另一个实例的生命周期相同或者更久时使用Unowned引用.
        //Unowned 引用被期望总是有值的.因此,ARC从不把Unowned值设置为nil,也就意味着Unowned使用非可选型类型定义.
        //注意:使用Unowned 引用一定要确保引用的实例对象一定没有被回收,如果你访问使用Unowned修饰的实例,而且已经释放了
        //那么你将会得到一个运行时错误.
    }
    
    // MARK: - StrongReferenceCyclesForClosures (闭包导致的循环引用)
    @objc  func StrongReferenceCyclesForClosures()  {
        /* 强类型的循环引用在闭包中也会出现,如果把闭包作为一个实例的属性,并且闭包的内部也捕获了该实例对象.这样就会导致实例对象与闭包之间
         相关持有,就会导致循环引用.闭包中可能访问实例的属性,例如:self.someProperty,或者调用了实例的方法,例如:self.someMethod(),
         无论哪种情况,这些访问都会导致闭包捕获self,导致了一个强的循环引用.
         如下事例:
         */
        let heading = HTMLElement(name: "h1")
        let defaultText = "some default text"
        heading.asHTML = {
            return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
        }
        print(heading.asHTML())
        
        //1.Defining a Capture List
        //如下形式,其中需要用到关键词in
        /*
         [unowned self,weak delegate = self.delegate] in
         */
        
        //2.Conflicting Access to In-Out Parameters (访问in out 关键词标记的参数的冲突)
        //1.长期写访问的一个后果就是使你无法获取使用in-out 参数传递的变量的原始值.即使作用域以及允许访问都满足,
        //在获取原始值的时候都会产生冲突,如下:
        var stepSize = 1
        func increment(_ number:inout Int)  {
            number += stepSize
        }
//        increment(&stepSize)
        //在本例中,stepSize是一个全局变量,并且在increment(_:)内部正常获取.然而,读取stepSize以及写number
        //的操作重叠在一起.这两个变量在内存中引用的是同一块位置,所以产生了冲突
        
        //解决该冲突的一个方法就是给stepSize一个明显的副本
        var copySize = stepSize
        increment(&copySize)
        stepSize = copySize
        
        
        //2.长期访问in-out参数的另一个问题就是,如果有多个in-out参数在同一个函数中,传递了一个变量,也会产生冲突
//        传递playerTwoScore 作为两个参数的值产生了冲突,因为尝试在同一个内存区域同时去写两次操作
//        balance(&playerTwoScore, &playerTwoScore)
        var playerOnScore = 42
        var playerTwoScore = 30
        balance(&playerOnScore, &playerTwoScore)
        
        //3.Conflicting Access to self in Methods
        var oscar = Player(name: "OSCar", health: 10, energy: 10)
        var maria = Player(name: "Maris", health: 5, energy: 10)
        //该方法正常运行,没有产生冲突
        oscar.shareHealth(with: &maria)
        
        //上述代码中,它们在内存中访问的是不同的位置.即使两个写入操作同时进行,也不会冲突;
        
        //但是如果你把oscar作为另一个参数来传递,就会冲突,如下:
        //oscar.shareHealth(with: &oscar)
        
        
        //4.Conflicting Access to Properties
        //像结构体,元素,以及枚举是由单值组成的,比如结构体中的属性或者元组中的元素,因为这些都是值类型.
        //改变这些值的一部分就会改变整个值,意味着对一个属性读或者写操作需要读或者访问整个值
        //例如:重叠写元组中的元素会导致错误
        var playerInformation = (health:10,energy:20)
        balance(&playerInformation.health, &playerInformation.energy)
        
        var holly = Player(name: "Holly", health: 10, energy: 10)
        balance(&holly.health, &holly.energy)
        
    }
      
}

class HTMLElement {
    let name:String
    let text:String?
    // asHTML: 是一个闭包
    lazy var asHTML:()->String = {
        //使用捕获列表,就避免了闭包和实例之间的相互引用
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name)/>"
        }
    }
    init(name:String,text:String? = nil) {
        self.name = name
        self.text = text
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

func balance(_ x: inout Int,_ y: inout Int)  {
    let sum = x + y
    x = sum / 2
    y = sum - x
}


// MARK: - 3. Conflicting Access to self in Methods

struct Player {
    var name:String
    var health:Int
    var energy:Int
    static let maxHealth = 10
    mutating  func restoreHealth()  {
        health = Player.maxHealth
    }
}

extension Player {
    mutating  func shareHealth(with teammate:inout Player)  {
        balance(&teammate.health, &health)
    }
}





