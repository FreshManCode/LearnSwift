//
//  SWFindViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/6/29.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWFindViewController: SWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发现";
        self.p_initDefaultData()
    }
    
    func p_initDefaultData() -> Void {
        self.view.addSubview(self.tableView);
        listArray.append("Functions")
        listArray.append("Enumerations")
        listArray.append("Properties")
        tableView.reloadData()
    }
    
    // MARK: - 函数
    @objc func Functions() {
        self.navigationController?.pushViewController(SWFunctionsViewController.init(), animated: true)
    }
    
    // MARK: - 枚举

    @objc func Enumerations () {
        self.navigationController?.pushViewController(SWEnumerationsController.init(), animated: true)
    }
    
    // MARK: - 属性
    @objc func Properties() {
        self.navigationController?.pushViewController(SWPropertiesViewController(),animated:true)
    }
    
    // MARK: - TableView--Delegate/DataSource
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row], tableView: tableView);
       }

    

}
