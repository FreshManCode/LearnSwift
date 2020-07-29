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
        
        
        
        
    }
    
    
}
