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
        
    }
}
