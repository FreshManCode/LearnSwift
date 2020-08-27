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
        
        
        
        
    }
      

}



