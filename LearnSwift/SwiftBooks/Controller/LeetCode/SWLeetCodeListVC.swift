//
//  SWLeetCodeListVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/3/1.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWLeetCodeListVC: SWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
    }
    
    func p_initDefautData()  {
        title = "LeetCode刷题"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1. 两数之和", subTitle: "", funName: "SwiftSumLeetCode"))
        listItemArray.append(SWBookListItem(title: "2. 两数相加", subTitle: "", funName: "SwiftAddLeetCode"))

        tableView.reloadData()
    }

    
    // MARK: - 两数之和
    @objc  func SwiftSumLeetCode()  {
        psuhToTargetVC(className: "SwiftSumLeetCodeVC")
    }
    
    // MARK: - 两数相加
    @objc  func SwiftAddLeetCode()  {
        psuhToTargetVC(className: "SwiftAddLeetCodeVC")
    }
    
    
    
    
    
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listItemArray[indexPath.row].title!, tableView: tableView);
    }
    
    func psuhToTargetVC(className:String)  {
        let modelClass: AnyClass? = NSClassFromString("LearnSwift.\(className)")
        if let VCClass = modelClass as? UIViewController.Type {
            let vcInstance = VCClass.init()
            navigationController?.pushViewController(vcInstance, animated: true)
        }
    }

}
