//
//  SWConstantValueVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/9/23.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWConstantValueVC: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "不可变性的价值"
        listArray.append("ValueAndPointerTypes")
        view.addSubview(tableView)
        tableView.reloadData()
    }
    
    // MARK: - ValueAndPointerTypes (值类型和引用类型)
    @objc  func ValueAndPointerTypes()  {
        struct PointStruct {
            var x:Int
            var y:Int
        }
        var structPoint = PointStruct(x: 1, y: 2)
        var sameStructPoint = structPoint
        sameStructPoint.x = 3
        //(1,2),(3,2)
        print("(\(structPoint.x),\(structPoint.y)),(\(sameStructPoint.x),\(sameStructPoint.y)) ")
        //值类型与引用类型之间的区别关键在于:当被赋以一个新值或者作为参数传递给函数时,值类型会被复制.
        
        class PointClass  {
            var x:Int
            var y:Int
            
            init(x:Int,y:Int) {
                self.x = x
                self.y = y
            }
        }
        
        var classPoint = PointClass(x: 1, y: 2)
        var sameClassPoint = classPoint
        sameClassPoint.x = 3
        //(3,2),(3,2)
        print("(\(classPoint.x),\(classPoint.y)),(\(sameClassPoint.x),\(sameClassPoint.y)) ")
        
    }
    
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row], tableView: tableView);
    }
    
}


