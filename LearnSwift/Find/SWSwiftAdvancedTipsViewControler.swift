//
//  SWSwiftAdvancedTipsViewControler.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/9/8.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWSwiftAdvancedTipsViewControler: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefaultData()
        
        
    }
    
    func p_initDefaultData() -> Void {
        self.title = "Swift的实用技巧";
        listArray.append("ChainPrograming")
        self.view.addSubview(self.tableView);
        tableView.reloadData()
    }
    
    // MARK: - ChainPrograming (函数式编程)
    @objc  func ChainPrograming()  {
        let names = ["libai","Liming","wang","ai","wu","wang1","wang2","wang3","wang4"]
        //对内容进行筛选
        let resultNames = names.filter { (text) -> Bool in
            return text.hasPrefix("l")
        }
        //resultNames is["libai"]
        print("resultNames is\(resultNames)")
        //prefixWangResult is["wang", "wang1", "wang2", "wang3", "wang4"]
        let prefixWangResult = names.customFilter { (text) -> (Bool) in
            return text.hasPrefix("wang")
        }
        print("prefixWangResult is\(prefixWangResult)")
    
        
        
    }
    
    
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row], tableView: tableView);
    }
    
}


extension Collection {
    func customFilter(filter:(Self.Element)->(Bool)) ->[Self.Element]  {
        var resultArray = [Self.Element]()
        for value in self {
            if filter(value ) {
                resultArray.append(value)
            }
        }
        return resultArray
    }
}
